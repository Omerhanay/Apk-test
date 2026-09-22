import { z } from "zod";

const Env = z.object({
  PORT: z.coerce.number().int().default(8787),
  HOST: z.string().default("0.0.0.0"),
  LOG_LEVEL: z.enum(["fatal", "error", "warn", "info", "debug"]).default("info"),
  /** SHA-256 (hex) of the device token. The token itself is never stored server-side. */
  RELAY_TOKEN_SHA256: z.string().regex(/^[0-9a-f]{64}$/, "must be a lowercase hex SHA-256"),
  LLM_PROVIDER: z.enum(["anthropic", "mock"]).default("anthropic"),
  LLM_MODEL: z.string().default("claude-opus-5"),
  LLM_EFFORT: z.enum(["low", "medium", "high", "xhigh", "max"]).default("high"),
  LLM_MAX_TOKENS: z.coerce.number().int().min(1024).max(64_000).default(16_000),
  RATE_LIMIT_PER_MINUTE: z.coerce.number().int().min(1).default(30),
});

export type Config = z.infer<typeof Env>;

export function loadConfig(env: NodeJS.ProcessEnv = process.env): Config {
  const parsed = Env.safeParse(env);
  if (!parsed.success) {
    // Report which variables are wrong, never their values.
    const fields = parsed.error.issues.map((i) => `${i.path.join(".")}: ${i.message}`).join("; ");
    throw new Error(`Invalid relay configuration: ${fields}`);
  }
  if (parsed.data.LLM_PROVIDER === "anthropic" && !env.ANTHROPIC_API_KEY) {
    throw new Error("Invalid relay configuration: ANTHROPIC_API_KEY is required when LLM_PROVIDER=anthropic");
  }
  return parsed.data;
}
