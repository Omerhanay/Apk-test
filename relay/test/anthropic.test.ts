import Anthropic from "@anthropic-ai/sdk";
import { describe, expect, it } from "vitest";
import { AnthropicProvider } from "../src/llm/anthropic.js";
import { ProviderError } from "../src/llm/types.js";

function fakeClient(respond: (params: any) => any) {
  const calls: any[] = [];
  const client = {
    beta: {
      messages: {
        create: async (params: any) => {
          calls.push(params);
          return respond(params);
        },
      },
    },
  } as unknown as Pick<Anthropic, "beta">;
  return { client, calls };
}

const tools = [{ name: "search_memory", description: "d", input_schema: { type: "object", properties: {} } }];

describe("AnthropicProvider", () => {
  it("builds the request and maps blocks both ways", async () => {
    const thinking = { type: "thinking", thinking: "", signature: "sig" };
    const { client, calls } = fakeClient(() => ({
      model: "claude-opus-5",
      stop_reason: "tool_use",
      usage: { input_tokens: 10, output_tokens: 5 },
      content: [thinking, { type: "tool_use", id: "tu_1", name: "search_memory", input: { query: "car" } }],
    }));
    const provider = new AnthropicProvider({ model: "claude-opus-5", effort: "high", maxTokens: 16000, client });

    const result = await provider.agentTurn({
      system: "sys",
      tools,
      messages: [
        { role: "user", content: [{ type: "text", text: "my car?" }] },
        { role: "assistant", content: [{ type: "opaque", provider: "other", data: { x: 1 } }, { type: "text", text: "ok" }] },
        { role: "user", content: [{ type: "tool_result", call_id: "tu_0", content: "[]" }] },
      ],
    });

    const req = calls[0];
    expect(req.fallbacks).toBe("default");
    expect(req.betas).toContain("server-side-fallback-2026-07-01");
    expect(req.thinking).toEqual({ type: "adaptive" });
    expect(req.system[0].cache_control).toEqual({ type: "ephemeral" });
    // Opaque blocks from other providers are dropped.
    expect(req.messages[1].content).toEqual([{ type: "text", text: "ok" }]);
    expect(req.messages[2].content[0]).toMatchObject({ type: "tool_result", tool_use_id: "tu_0" });

    expect(result.stop).toBe("tool_calls");
    expect(result.content[0]).toEqual({ type: "opaque", provider: "anthropic", data: thinking });
    expect(result.content[1]).toEqual({ type: "tool_call", id: "tu_1", name: "search_memory", input: { query: "car" } });
  });

  it("echoes its own opaque blocks back verbatim", async () => {
    const thinking = { type: "thinking", thinking: "", signature: "sig" };
    const { client, calls } = fakeClient(() => ({
      model: "m",
      stop_reason: "end_turn",
      usage: { input_tokens: 1, output_tokens: 1 },
      content: [{ type: "text", text: "done" }],
    }));
    const provider = new AnthropicProvider({ model: "m", effort: "high", maxTokens: 16000, client });
    await provider.agentTurn({
      system: "s",
      tools,
      messages: [
        { role: "user", content: [{ type: "text", text: "q" }] },
        { role: "assistant", content: [{ type: "opaque", provider: "anthropic", data: thinking }] },
        { role: "user", content: [{ type: "text", text: "q2" }] },
      ],
    });
    expect(calls[0].messages[1].content[0]).toEqual(thinking);
  });

  it("maps refusal stop reason", async () => {
    const { client } = fakeClient(() => ({ model: "m", stop_reason: "refusal", usage: { input_tokens: 0, output_tokens: 0 }, content: [] }));
    const provider = new AnthropicProvider({ model: "m", effort: "high", maxTokens: 16000, client });
    const r = await provider.agentTurn({ system: "s", tools, messages: [{ role: "user", content: [{ type: "text", text: "q" }] }] });
    expect(r.stop).toBe("refusal");
  });

  it("maps SDK errors to content-free provider errors", async () => {
    const { client } = fakeClient(() => {
      throw new Anthropic.RateLimitError(429, { error: { message: "slow down" } }, "slow down", new Headers());
    });
    const provider = new AnthropicProvider({ model: "m", effort: "high", maxTokens: 16000, client });
    await expect(
      provider.agentTurn({ system: "s", tools, messages: [{ role: "user", content: [{ type: "text", text: "q" }] }] }),
    ).rejects.toMatchObject(new ProviderError("rate_limited", true));
  });
});
