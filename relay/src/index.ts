import { loadConfig } from "./config.js";
import { MEMORY_PARSE_PROMPT_VERSION, PROMPT_VERSION, loadMemoryParsePrompt, loadSystemPrompt, loadToolSpecs } from "./contracts.js";
import { AnthropicProvider } from "./llm/anthropic.js";
import { MockProvider } from "./llm/mock.js";
import { buildServer } from "./server.js";

const config = loadConfig();

const provider =
  config.LLM_PROVIDER === "mock"
    ? new MockProvider()
    : new AnthropicProvider({ model: config.LLM_MODEL, effort: config.LLM_EFFORT, maxTokens: config.LLM_MAX_TOKENS });

const app = await buildServer({
  tokenSha256: config.RELAY_TOKEN_SHA256,
  provider,
  systemPrompt: loadSystemPrompt(),
  promptVersion: PROMPT_VERSION,
  memoryParsePrompt: loadMemoryParsePrompt(),
  memoryParsePromptVersion: MEMORY_PARSE_PROMPT_VERSION,
  tools: loadToolSpecs(),
  rateLimitPerMinute: config.RATE_LIMIT_PER_MINUTE,
  logLevel: config.LOG_LEVEL,
});

if (config.LLM_PROVIDER === "mock") app.log.warn("LLM_PROVIDER=mock: responses are simulated, not real model output");

await app.listen({ port: config.PORT, host: config.HOST });
