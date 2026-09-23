import { z } from "zod";

// Provider-neutral wire format shared with the mobile app. The app never sees a
// provider SDK's block shapes, so swapping providers does not touch the client.

export const TextBlock = z.object({ type: z.literal("text"), text: z.string().max(50_000) });

export const ToolCallBlock = z.object({
  type: z.literal("tool_call"),
  id: z.string().min(1).max(200),
  name: z.string().min(1).max(100),
  input: z.record(z.string(), z.unknown()),
});

export const ToolResultBlock = z.object({
  type: z.literal("tool_result"),
  call_id: z.string().min(1).max(200),
  content: z.string().max(100_000),
  is_error: z.boolean().optional(),
});

// Provider-specific blocks (e.g. thinking) that must be echoed back verbatim.
// The client stores them without interpreting them.
export const OpaqueBlock = z.object({
  type: z.literal("opaque"),
  provider: z.string().max(50),
  data: z.record(z.string(), z.unknown()),
});

export const Block = z.discriminatedUnion("type", [TextBlock, ToolCallBlock, ToolResultBlock, OpaqueBlock]);
export type Block = z.infer<typeof Block>;

export const Message = z.object({
  role: z.enum(["user", "assistant"]),
  content: z.array(Block).min(1).max(200),
});
export type Message = z.infer<typeof Message>;

export const AgentTurnRequest = z.object({
  messages: z.array(Message).min(1).max(100),
});
export type AgentTurnRequest = z.infer<typeof AgentTurnRequest>;

export const MemoryCategory = z.enum([
  "family", "vehicle", "home", "health", "work", "finance", "travel", "preference", "routine", "other",
]);

export const MemoryParseRequest = z.object({
  text: z.string().trim().min(1).max(2000),
  locale: z.enum(["en", "tr"]),
  today: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  /** Keys of facts already stored, so corrections reuse them. Keys only, never content. */
  known_subjects: z
    .array(z.object({ subject: z.string().max(100), predicate: z.string().max(100) }))
    .max(300)
    .default([]),
});
export type MemoryParseRequest = z.infer<typeof MemoryParseRequest>;

export const MemoryParse = z.object({
  op: z.enum(["create", "retract"]),
  content: z.string(),
  category: MemoryCategory,
  kind: z.enum(["semantic", "episodic", "procedural", "temporal"]),
  subject: z.string().nullable(),
  predicate: z.string().nullable(),
  value: z.string().nullable(),
  valid_until: z.string().nullable(),
  sensitivity: z.enum(["normal", "personal", "sensitive", "special_category"]),
  confidence: z.number(),
  needs_clarification: z.string().nullable(),
});
export type MemoryParse = z.infer<typeof MemoryParse>;

export type StopReason = "end_turn" | "tool_calls" | "max_tokens" | "refusal" | "incomplete";

export interface AgentTurnResult {
  stop: StopReason;
  content: Block[];
  model: string;
  usage: { input_tokens: number; output_tokens: number };
}

export interface ToolSpec {
  name: string;
  description: string;
  input_schema: Record<string, unknown>;
}

export interface LlmProvider {
  readonly name: string;
  agentTurn(input: { system: string; tools: ToolSpec[]; messages: Message[] }): Promise<AgentTurnResult>;
  parseMemory(input: { system: string; request: MemoryParseRequest }): Promise<MemoryParse>;
}

/** Thrown by providers for upstream failures; carries a safe, content-free code. */
export class ProviderError extends Error {
  constructor(
    readonly code: "rate_limited" | "upstream_unavailable" | "bad_request" | "auth" | "refused" | "unparseable" | "unknown",
    readonly retryable: boolean,
  ) {
    super(code);
  }
}
