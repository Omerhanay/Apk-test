import Anthropic from "@anthropic-ai/sdk";
import type { BetaContentBlock, BetaContentBlockParam, BetaMessageParam } from "@anthropic-ai/sdk/resources/beta/messages/messages";
import { type AgentTurnResult, type Block, type LlmProvider, type Message, ProviderError, type StopReason, type ToolSpec } from "./types.js";

const PROVIDER = "anthropic";

export interface AnthropicOptions {
  model: string;
  effort: "low" | "medium" | "high" | "xhigh" | "max";
  maxTokens: number;
  /** Injected for tests; defaults to a client that reads ANTHROPIC_API_KEY from the environment. */
  client?: Pick<Anthropic, "beta">;
}

export class AnthropicProvider implements LlmProvider {
  readonly name = PROVIDER;
  private readonly client: Pick<Anthropic, "beta">;

  constructor(private readonly opts: AnthropicOptions) {
    this.client = opts.client ?? new Anthropic();
  }

  async agentTurn(input: { system: string; tools: ToolSpec[]; messages: Message[] }): Promise<AgentTurnResult> {
    try {
      const response = await this.client.beta.messages.create({
        model: this.opts.model,
        max_tokens: this.opts.maxTokens,
        thinking: { type: "adaptive" },
        output_config: { effort: this.opts.effort },
        // Server-side refusal fallback, routed by refusal category.
        betas: ["server-side-fallback-2026-07-01"],
        fallbacks: "default",
        // System prompt and tools are static, so the prefix caches across turns.
        system: [{ type: "text", text: input.system, cache_control: { type: "ephemeral" } }],
        tools: input.tools.map((t) => ({
          name: t.name,
          description: t.description,
          input_schema: t.input_schema as Anthropic.Tool.InputSchema,
        })),
        messages: input.messages.map(toAnthropicMessage),
      });

      return {
        stop: mapStop(response.stop_reason),
        content: response.content.flatMap(fromAnthropicBlock),
        model: response.model,
        usage: { input_tokens: response.usage.input_tokens, output_tokens: response.usage.output_tokens },
      };
    } catch (err) {
      throw mapError(err);
    }
  }
}

function toAnthropicMessage(m: Message): BetaMessageParam {
  return { role: m.role, content: m.content.flatMap(toAnthropicBlock) };
}

function toAnthropicBlock(b: Block): BetaContentBlockParam[] {
  switch (b.type) {
    case "text":
      return [{ type: "text", text: b.text }];
    case "tool_call":
      return [{ type: "tool_use", id: b.id, name: b.name, input: b.input }];
    case "tool_result":
      return [{ type: "tool_result", tool_use_id: b.call_id, content: b.content, is_error: b.is_error }];
    case "opaque":
      // Blocks from another provider are meaningless here; drop them.
      return b.provider === PROVIDER ? [b.data as unknown as BetaContentBlockParam] : [];
  }
}

function fromAnthropicBlock(b: BetaContentBlock): Block[] {
  switch (b.type) {
    case "text":
      return [{ type: "text", text: b.text }];
    case "tool_use":
      return [{ type: "tool_call", id: b.id, name: b.name, input: (b.input ?? {}) as Record<string, unknown> }];
    default:
      // thinking, redacted_thinking, fallback markers, etc. must round-trip unchanged.
      return [{ type: "opaque", provider: PROVIDER, data: b as unknown as Record<string, unknown> }];
  }
}

function mapStop(reason: string | null): StopReason {
  switch (reason) {
    case "end_turn":
    case "stop_sequence":
      return "end_turn";
    case "tool_use":
      return "tool_calls";
    case "max_tokens":
    case "model_context_window_exceeded":
      return "max_tokens";
    case "refusal":
      return "refusal";
    default:
      return "incomplete";
  }
}

function mapError(err: unknown): ProviderError {
  if (err instanceof Anthropic.RateLimitError) return new ProviderError("rate_limited", true);
  if (err instanceof Anthropic.AuthenticationError || err instanceof Anthropic.PermissionDeniedError)
    return new ProviderError("auth", false);
  if (err instanceof Anthropic.BadRequestError) return new ProviderError("bad_request", false);
  if (err instanceof Anthropic.InternalServerError || err instanceof Anthropic.APIConnectionError)
    return new ProviderError("upstream_unavailable", true);
  if (err instanceof Anthropic.APIError && (err.status ?? 0) >= 500) return new ProviderError("upstream_unavailable", true);
  return new ProviderError("unknown", false);
}
