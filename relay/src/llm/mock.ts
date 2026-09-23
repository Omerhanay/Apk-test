import type { AgentTurnResult, LlmProvider, MemoryParse, MemoryParseRequest, Message, ToolSpec } from "./types.js";

/**
 * DEVELOPMENT/TEST ONLY. A deterministic stand-in for a real model so the app and
 * relay can be exercised without network access or API cost. It never invents
 * personal facts: without tool results it replies that it lacks information.
 */
export class MockProvider implements LlmProvider {
  readonly name = "mock";

  async agentTurn(input: { system: string; tools: ToolSpec[]; messages: Message[] }): Promise<AgentTurnResult> {
    const last = input.messages.at(-1);
    const toolResults = last?.content.filter((b) => b.type === "tool_result") ?? [];

    if (last?.role === "user" && toolResults.length === 0 && input.tools.some((t) => t.name === "search_memory")) {
      const query = last.content.find((b) => b.type === "text")?.text ?? "";
      return this.result("tool_calls", [{ type: "tool_call", id: `mock_${input.messages.length}`, name: "search_memory", input: { query } }]);
    }

    const found = toolResults.filter((r) => r.type === "tool_result" && !r.is_error && r.content !== "[]");
    const text = found.length
      ? `[mock] Found ${found.length} relevant result(s).`
      : "I don't have enough information to answer that.";
    return this.result("end_turn", [{ type: "text", text }]);
  }

  /** Stores the text verbatim as an uncategorized note; it never guesses structure. */
  async parseMemory(input: { system: string; request: MemoryParseRequest }): Promise<MemoryParse> {
    return {
      op: "create",
      content: input.request.text,
      category: "other",
      kind: "semantic",
      subject: null,
      predicate: null,
      value: null,
      valid_until: null,
      sensitivity: "normal",
      confidence: 0.3,
      needs_clarification: null,
    };
  }

  private result(stop: AgentTurnResult["stop"], content: AgentTurnResult["content"]): AgentTurnResult {
    return { stop, content, model: "mock", usage: { input_tokens: 0, output_tokens: 0 } };
  }
}
