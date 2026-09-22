import { describe, expect, it } from "vitest";
import { loadConfig } from "../src/config.js";

const hash = "a".repeat(64);

describe("loadConfig", () => {
  it("applies defaults", () => {
    const c = loadConfig({ RELAY_TOKEN_SHA256: hash, ANTHROPIC_API_KEY: "x" });
    expect(c.LLM_MODEL).toBe("claude-opus-5");
    expect(c.LLM_PROVIDER).toBe("anthropic");
  });

  it("requires an API key for the anthropic provider but not for mock", () => {
    expect(() => loadConfig({ RELAY_TOKEN_SHA256: hash })).toThrow(/ANTHROPIC_API_KEY/);
    expect(() => loadConfig({ RELAY_TOKEN_SHA256: hash, LLM_PROVIDER: "mock" })).not.toThrow();
  });

  it("does not echo secret values in errors", () => {
    const bad = "not-a-hash-but-a-secret";
    try {
      loadConfig({ RELAY_TOKEN_SHA256: bad });
      expect.unreachable();
    } catch (e) {
      expect((e as Error).message).not.toContain(bad);
    }
  });
});
