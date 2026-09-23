import rateLimit from "@fastify/rate-limit";
import Fastify, { type FastifyInstance } from "fastify";
import { randomUUID } from "node:crypto";
import { verifyBearer } from "./auth.js";
import {
  AgentTurnRequest,
  DocumentExtractRequest,
  LOCAL_ONLY_DOCUMENT_TYPES,
  type LlmProvider,
  MemoryParseRequest,
  ProviderError,
  type ToolSpec,
} from "./llm/types.js";

export interface ServerDeps {
  tokenSha256: string;
  provider: LlmProvider;
  systemPrompt: string;
  promptVersion: string;
  memoryParsePrompt: string;
  memoryParsePromptVersion: string;
  documentExtractPrompt: string;
  documentExtractPromptVersion: string;
  tools: ToolSpec[];
  rateLimitPerMinute: number;
  logLevel?: string;
  /** Test hook to capture log output. */
  logStream?: NodeJS.WritableStream;
}

export async function buildServer(deps: ServerDeps): Promise<FastifyInstance> {
  const app = Fastify({
    bodyLimit: 2 * 1024 * 1024,
    genReqId: () => randomUUID(),
    logger: {
      level: deps.logLevel ?? "info",
      stream: deps.logStream,
      // Request bodies are never logged. Headers are redacted defensively.
      redact: { paths: ["req.headers.authorization", "req.headers.cookie"], remove: true },
    },
  });

  await app.register(rateLimit, { max: deps.rateLimitPerMinute, timeWindow: "1 minute" });

  app.get("/health", { config: { rateLimit: false } }, async () => ({ status: "ok" }));

  app.addHook("onRequest", async (req, reply) => {
    if (req.url === "/health") return;
    if (!verifyBearer(req.headers.authorization, deps.tokenSha256)) {
      req.log.warn({ event: "auth_rejected" });
      return reply.code(401).send({ error: "unauthorized" });
    }
  });

  // Authenticated connectivity check used when pairing the app. Reveals no secrets.
  app.get("/v1/ping", async () => ({ status: "ok", provider: deps.provider.name, prompt_version: deps.promptVersion }));

  app.post("/v1/agent/turn", async (req, reply) => {
    const parsed = AgentTurnRequest.safeParse(req.body);
    if (!parsed.success) {
      return reply.code(400).send({ error: "invalid_request", issues: parsed.error.issues.map((i) => i.path.join(".")) });
    }

    const started = performance.now();
    try {
      const result = await deps.provider.agentTurn({
        system: deps.systemPrompt,
        tools: deps.tools,
        messages: parsed.data.messages,
      });
      req.log.info({
        event: "agent_turn",
        provider: deps.provider.name,
        model: result.model,
        prompt_version: deps.promptVersion,
        stop: result.stop,
        latency_ms: Math.round(performance.now() - started),
        input_tokens: result.usage.input_tokens,
        output_tokens: result.usage.output_tokens,
        tool_calls: result.content.filter((b) => b.type === "tool_call").map((b) => (b.type === "tool_call" ? b.name : "")),
      });
      return { ...result, prompt_version: deps.promptVersion };
    } catch (err) {
      const code = err instanceof ProviderError ? err.code : "unknown";
      const retryable = err instanceof ProviderError && err.retryable;
      req.log.error({ event: "agent_turn_failed", code, latency_ms: Math.round(performance.now() - started) });
      return reply.code(code === "rate_limited" ? 429 : 502).send({ error: code, retryable });
    }
  });

  app.post("/v1/memory/parse", async (req, reply) => {
    const parsed = MemoryParseRequest.safeParse(req.body);
    if (!parsed.success) {
      return reply.code(400).send({ error: "invalid_request", issues: parsed.error.issues.map((i) => i.path.join(".")) });
    }
    const started = performance.now();
    try {
      const result = await deps.provider.parseMemory({ system: deps.memoryParsePrompt, request: parsed.data });
      // Structural fields only: category and op are not personal content.
      req.log.info({
        event: "memory_parse",
        provider: deps.provider.name,
        prompt_version: deps.memoryParsePromptVersion,
        op: result.op,
        category: result.category,
        latency_ms: Math.round(performance.now() - started),
      });
      return { ...result, prompt_version: deps.memoryParsePromptVersion };
    } catch (err) {
      const code = err instanceof ProviderError ? err.code : "unknown";
      const retryable = err instanceof ProviderError && err.retryable;
      req.log.error({ event: "memory_parse_failed", code, latency_ms: Math.round(performance.now() - started) });
      return reply.code(code === "rate_limited" ? 429 : code === "refused" ? 422 : 502).send({ error: code, retryable });
    }
  });

  app.post("/v1/document/extract", async (req, reply) => {
    const parsed = DocumentExtractRequest.safeParse(req.body);
    if (!parsed.success) {
      return reply.code(400).send({ error: "invalid_request", issues: parsed.error.issues.map((i) => i.path.join(".")) });
    }
    // Defense in depth: the app never sends these, and the relay refuses them if it does.
    if (LOCAL_ONLY_DOCUMENT_TYPES.has(parsed.data.doc_type)) {
      req.log.warn({ event: "document_extract_refused_local_only", doc_type: parsed.data.doc_type });
      return reply.code(422).send({ error: "local_only_document", retryable: false });
    }
    const started = performance.now();
    try {
      const result = await deps.provider.extractDocument({ system: deps.documentExtractPrompt, request: parsed.data });
      req.log.info({
        event: "document_extract",
        provider: deps.provider.name,
        prompt_version: deps.documentExtractPromptVersion,
        doc_type: result.doc_type,
        field_count: result.fields.length,
        latency_ms: Math.round(performance.now() - started),
      });
      return { ...result, prompt_version: deps.documentExtractPromptVersion };
    } catch (err) {
      const code = err instanceof ProviderError ? err.code : "unknown";
      const retryable = err instanceof ProviderError && err.retryable;
      req.log.error({ event: "document_extract_failed", code, latency_ms: Math.round(performance.now() - started) });
      return reply.code(code === "rate_limited" ? 429 : code === "refused" ? 422 : 502).send({ error: code, retryable });
    }
  });

  return app;
}
