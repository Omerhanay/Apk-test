import { PassThrough } from "node:stream";
import { describe, expect, it } from "vitest";
import { sha256Hex } from "../src/auth.js";
import { PROMPT_VERSION, loadSystemPrompt, loadToolSpecs } from "../src/contracts.js";
import { MockProvider } from "../src/llm/mock.js";
import { type LlmProvider, ProviderError } from "../src/llm/types.js";
import { buildServer } from "../src/server.js";

const TOKEN = "test-token-0123456789abcdef0123456789abcdef";
const auth = { authorization: `Bearer ${TOKEN}` };

async function makeApp(overrides: { provider?: LlmProvider; rateLimitPerMinute?: number } = {}) {
  const logStream = new PassThrough();
  const logs: string[] = [];
  logStream.on("data", (c) => logs.push(c.toString()));
  const app = await buildServer({
    tokenSha256: sha256Hex(TOKEN),
    provider: overrides.provider ?? new MockProvider(),
    systemPrompt: loadSystemPrompt(),
    promptVersion: PROMPT_VERSION,
    tools: loadToolSpecs(),
    rateLimitPerMinute: overrides.rateLimitPerMinute ?? 100,
    logStream,
  });
  return { app, logs };
}

const userTurn = (text: string) => ({ messages: [{ role: "user", content: [{ type: "text", text }] }] });

describe("relay auth", () => {
  it("allows unauthenticated health checks", async () => {
    const { app } = await makeApp();
    const res = await app.inject({ method: "GET", url: "/health" });
    expect(res.statusCode).toBe(200);
  });

  it.each([
    ["missing header", {}],
    ["wrong token", { authorization: "Bearer wrong-token-wrong-token-wrong-token-xx" }],
    ["wrong scheme", { authorization: `Basic ${TOKEN}` }],
  ])("rejects %s", async (_label, headers) => {
    const { app } = await makeApp();
    const res = await app.inject({ method: "POST", url: "/v1/agent/turn", headers, payload: userTurn("hi") });
    expect(res.statusCode).toBe(401);
  });
});

describe("relay ping", () => {
  it("requires auth and reports provider and prompt version", async () => {
    const { app } = await makeApp();
    expect((await app.inject({ method: "GET", url: "/v1/ping" })).statusCode).toBe(401);
    const res = await app.inject({ method: "GET", url: "/v1/ping", headers: auth });
    expect(res.json()).toEqual({ status: "ok", provider: "mock", prompt_version: PROMPT_VERSION });
  });
});

describe("relay validation", () => {
  it("rejects malformed messages", async () => {
    const { app } = await makeApp();
    const res = await app.inject({
      method: "POST",
      url: "/v1/agent/turn",
      headers: auth,
      payload: { messages: [{ role: "system", content: [{ type: "text", text: "x" }] }] },
    });
    expect(res.statusCode).toBe(400);
  });

  it("rejects unknown block types", async () => {
    const { app } = await makeApp();
    const res = await app.inject({
      method: "POST",
      url: "/v1/agent/turn",
      headers: auth,
      payload: { messages: [{ role: "user", content: [{ type: "image", data: "..." }] }] },
    });
    expect(res.statusCode).toBe(400);
  });
});

describe("relay agent turn", () => {
  it("returns provider output with the prompt version", async () => {
    const { app } = await makeApp();
    const res = await app.inject({ method: "POST", url: "/v1/agent/turn", headers: auth, payload: userTurn("when does my insurance expire?") });
    expect(res.statusCode).toBe(200);
    const body = res.json();
    expect(body.stop).toBe("tool_calls");
    expect(body.prompt_version).toBe(PROMPT_VERSION);
    expect(body.content[0]).toMatchObject({ type: "tool_call", name: "search_memory" });
  });

  it("mock provider says it lacks information when searches return nothing", async () => {
    const { app } = await makeApp();
    const res = await app.inject({
      method: "POST",
      url: "/v1/agent/turn",
      headers: auth,
      payload: {
        messages: [
          { role: "user", content: [{ type: "text", text: "what is my blood type?" }] },
          { role: "assistant", content: [{ type: "tool_call", id: "c1", name: "search_memory", input: { query: "blood type" } }] },
          { role: "user", content: [{ type: "tool_result", call_id: "c1", content: "[]" }] },
        ],
      },
    });
    expect(res.json().content[0].text).toBe("I don't have enough information to answer that.");
  });

  it("never writes message content or the bearer token to logs", async () => {
    const { app, logs } = await makeApp();
    const secret = "my-passport-renewal-note-7f3a";
    await app.inject({ method: "POST", url: "/v1/agent/turn", headers: auth, payload: userTurn(secret) });
    const all = logs.join("");
    expect(all).toContain("agent_turn");
    expect(all).not.toContain(secret);
    expect(all).not.toContain(TOKEN);
  });

  it("maps provider failures to safe error codes", async () => {
    const failing: LlmProvider = {
      name: "failing",
      agentTurn: async () => {
        throw new ProviderError("upstream_unavailable", true);
      },
    };
    const { app } = await makeApp({ provider: failing });
    const res = await app.inject({ method: "POST", url: "/v1/agent/turn", headers: auth, payload: userTurn("hi") });
    expect(res.statusCode).toBe(502);
    expect(res.json()).toEqual({ error: "upstream_unavailable", retryable: true });
  });

  it("rate limits", async () => {
    const { app } = await makeApp({ rateLimitPerMinute: 2 });
    const codes: number[] = [];
    for (let i = 0; i < 3; i++) {
      codes.push((await app.inject({ method: "POST", url: "/v1/agent/turn", headers: auth, payload: userTurn("hi") })).statusCode);
    }
    expect(codes).toEqual([200, 200, 429]);
  });
});

describe("tool contract", () => {
  it("strips app-only fields before sending tools to the LLM", () => {
    for (const tool of loadToolSpecs()) {
      expect(Object.keys(tool).sort()).toEqual(["description", "input_schema", "name"]);
    }
  });

  it("does not expose any approval tool to the model", () => {
    const names = loadToolSpecs().map((t) => t.name);
    expect(names.some((n) => /approv|confirm|execute/.test(n))).toBe(false);
  });
});

describe("system prompt", () => {
  it("defines the no-information reply in both supported languages", () => {
    const prompt = loadSystemPrompt();
    expect(prompt).toContain("I don't have enough information to answer that.");
    expect(prompt).toContain("Bunu yanıtlamak için yeterli bilgim yok.");
  });
});
