import rateLimit from "@fastify/rate-limit";
import Fastify, { type FastifyInstance } from "fastify";
import { randomUUID } from "node:crypto";
import { verifyBearer } from "./auth.js";
import { AgentTurnRequest, type LlmProvider, ProviderError, type ToolSpec } from "./llm/types.js";

export interface ServerDeps {
  tokenSha256: string;
  provider: LlmProvider;
  systemPrompt: string;
  promptVersion: string;
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

  return app;
}
