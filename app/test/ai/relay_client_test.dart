import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:life_os/core/ai/relay_client.dart';
import 'package:life_os/core/ai/wire.dart';
import 'package:life_os/core/security/key_store.dart';

void main() {
  final creds = RelayCredentials(Uri.parse('https://relay.example'), 'token-abc');
  final question = [const WireMessage(Role.user, [TextBlock('what is tomorrow?')])];

  test('sends bearer auth and parses a tool-call turn with opaque blocks', () async {
    late http.Request sent;
    final client = RelayClient(creds, httpClient: MockClient((req) async {
      sent = req;
      return http.Response(
        jsonEncode({
          'stop': 'tool_calls',
          'model': 'claude-opus-5',
          'prompt_version': 'agent.v1',
          'usage': {'input_tokens': 5, 'output_tokens': 3},
          'content': [
            {'type': 'opaque', 'provider': 'anthropic', 'data': {'type': 'thinking', 'signature': 's'}},
            {'type': 'tool_call', 'id': 'c1', 'name': 'search_events', 'input': {'start': 'a', 'end': 'b'}},
          ],
        }),
        200,
      );
    }));

    final turn = await client.agentTurn(question);
    expect(sent.headers['authorization'], 'Bearer token-abc');
    expect(sent.url.path, '/v1/agent/turn');
    expect(turn.stop, StopReason.toolCalls);
    expect(turn.content.first, isA<OpaqueBlock>());
    expect((turn.content.last as ToolCallBlock).name, 'search_events');
  });

  test('round-trips wire messages', () {
    const msg = WireMessage(Role.user, [ToolResultBlock('c1', '[]', isError: true)]);
    final back = WireMessage.fromJson(jsonDecode(jsonEncode(msg.toJson())) as Map<String, dynamic>);
    final block = back.content.single as ToolResultBlock;
    expect(block.callId, 'c1');
    expect(block.isError, isTrue);
  });

  test('maps relay errors to content-free exceptions', () async {
    Future<RelayException> errorFor(http.Response r) async {
      final c = RelayClient(creds, httpClient: MockClient((_) async => r));
      try {
        await c.agentTurn(question);
      } on RelayException catch (e) {
        return e;
      }
      throw StateError('expected RelayException');
    }

    expect((await errorFor(http.Response('', 401))).code, 'unauthorized');
    final upstream = await errorFor(http.Response(jsonEncode({'error': 'upstream_unavailable', 'retryable': true}), 502));
    expect(upstream.code, 'upstream_unavailable');
    expect(upstream.retryable, isTrue);
  });

  test('network failure is reported as offline, not as an answer', () async {
    final c = RelayClient(creds, httpClient: MockClient((_) async => throw http.ClientException('no route')));
    expect(() => c.agentTurn(question), throwsA(isA<RelayException>().having((e) => e.code, 'code', 'offline')));
  });
}
