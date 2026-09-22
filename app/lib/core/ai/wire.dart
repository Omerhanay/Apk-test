/// Provider-neutral message format shared with the relay (relay/src/llm/types.ts).
sealed class Block {
  const Block();

  Map<String, dynamic> toJson();

  static Block fromJson(Map<String, dynamic> j) => switch (j['type']) {
        'text' => TextBlock(j['text'] as String),
        'tool_call' => ToolCallBlock(j['id'] as String, j['name'] as String, (j['input'] as Map).cast<String, dynamic>()),
        'tool_result' => ToolResultBlock(j['call_id'] as String, j['content'] as String, isError: j['is_error'] == true),
        'opaque' => OpaqueBlock(j['provider'] as String, (j['data'] as Map).cast<String, dynamic>()),
        final t => throw FormatException('Unknown block type: $t'),
      };
}

class TextBlock extends Block {
  const TextBlock(this.text);
  final String text;

  @override
  Map<String, dynamic> toJson() => {'type': 'text', 'text': text};
}

class ToolCallBlock extends Block {
  const ToolCallBlock(this.id, this.name, this.input);
  final String id;
  final String name;
  final Map<String, dynamic> input;

  @override
  Map<String, dynamic> toJson() => {'type': 'tool_call', 'id': id, 'name': name, 'input': input};
}

class ToolResultBlock extends Block {
  const ToolResultBlock(this.callId, this.content, {this.isError = false});
  final String callId;
  final String content;
  final bool isError;

  @override
  Map<String, dynamic> toJson() =>
      {'type': 'tool_result', 'call_id': callId, 'content': content, if (isError) 'is_error': true};
}

/// Provider-specific block (e.g. model reasoning) kept only to echo back.
class OpaqueBlock extends Block {
  const OpaqueBlock(this.provider, this.data);
  final String provider;
  final Map<String, dynamic> data;

  @override
  Map<String, dynamic> toJson() => {'type': 'opaque', 'provider': provider, 'data': data};
}

enum Role { user, assistant }

class WireMessage {
  const WireMessage(this.role, this.content);
  final Role role;
  final List<Block> content;

  Map<String, dynamic> toJson() => {'role': role.name, 'content': content.map((b) => b.toJson()).toList()};

  factory WireMessage.fromJson(Map<String, dynamic> j) => WireMessage(
        Role.values.byName(j['role'] as String),
        (j['content'] as List).cast<Map<String, dynamic>>().map(Block.fromJson).toList(),
      );
}

enum StopReason { endTurn, toolCalls, maxTokens, refusal, incomplete }

class AgentTurn {
  const AgentTurn({
    required this.stop,
    required this.content,
    required this.model,
    required this.promptVersion,
    required this.inputTokens,
    required this.outputTokens,
  });

  factory AgentTurn.fromJson(Map<String, dynamic> j) => AgentTurn(
        stop: switch (j['stop']) {
          'end_turn' => StopReason.endTurn,
          'tool_calls' => StopReason.toolCalls,
          'max_tokens' => StopReason.maxTokens,
          'refusal' => StopReason.refusal,
          _ => StopReason.incomplete,
        },
        content: (j['content'] as List).cast<Map<String, dynamic>>().map(Block.fromJson).toList(),
        model: j['model'] as String,
        promptVersion: j['prompt_version'] as String?,
        inputTokens: (j['usage'] as Map)['input_tokens'] as int,
        outputTokens: (j['usage'] as Map)['output_tokens'] as int,
      );

  final StopReason stop;
  final List<Block> content;
  final String model;
  final String? promptVersion;
  final int inputTokens;
  final int outputTokens;
}
