import 'dart:convert';

enum ToolEffect { read, prepare, commit }

enum RiskTier { none, low, medium, high }

/// One tool from `contracts/agent-tools.json`.
class ToolDef {
  const ToolDef({
    required this.name,
    required this.description,
    required this.capability,
    required this.effect,
    required this.risk,
    required this.inputSchema,
  });

  factory ToolDef.fromJson(Map<String, dynamic> j) => ToolDef(
        name: j['name'] as String,
        description: j['description'] as String,
        capability: j['capability'] as String,
        effect: ToolEffect.values.byName(j['effect'] as String),
        risk: RiskTier.values.byName(j['risk'] as String),
        inputSchema: (j['input_schema'] as Map).cast<String, dynamic>(),
      );

  final String name;
  final String description;
  final String capability;
  final ToolEffect effect;
  final RiskTier risk;
  final Map<String, dynamic> inputSchema;
}

class ToolRegistry {
  ToolRegistry(Iterable<ToolDef> tools) : _tools = {for (final t in tools) t.name: t};

  factory ToolRegistry.fromContractJson(String source) {
    final decoded = jsonDecode(source) as Map<String, dynamic>;
    final tools = (decoded['tools'] as List).cast<Map<String, dynamic>>().map(ToolDef.fromJson);
    return ToolRegistry(tools);
  }

  final Map<String, ToolDef> _tools;

  ToolDef? operator [](String name) => _tools[name];
  Iterable<ToolDef> get all => _tools.values;
}
