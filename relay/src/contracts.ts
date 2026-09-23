import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import type { ToolSpec } from "./llm/types.js";

const here = dirname(fileURLToPath(import.meta.url));
const repoRoot = resolve(here, "../..");

export const PROMPT_VERSION = "agent.v2";

export const MEMORY_PARSE_PROMPT_VERSION = "memory-parse.v1";

function loadPrompt(version: string): string {
  return readFileSync(resolve(repoRoot, "relay/prompts", `${version}.md`), "utf8");
}

export function loadSystemPrompt(): string {
  return loadPrompt(PROMPT_VERSION);
}

export function loadMemoryParsePrompt(): string {
  return loadPrompt(MEMORY_PARSE_PROMPT_VERSION);
}

interface ContractTool extends ToolSpec {
  capability: string;
  effect: "read" | "prepare" | "commit";
  risk: string;
}

/** Loads the shared tool contract and strips app-only fields before they reach the LLM. */
export function loadToolSpecs(): ToolSpec[] {
  const raw = JSON.parse(readFileSync(resolve(repoRoot, "contracts/agent-tools.json"), "utf8")) as { tools: ContractTool[] };
  return raw.tools.map(({ name, description, input_schema }) => ({ name, description, input_schema }));
}
