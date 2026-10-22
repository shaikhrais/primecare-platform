import 'dart:typed_data';
import '../packages/flutter_core/lib/communications/communication_core.dart';

final class FixtureTransport implements CommunicationTransport {
  final calls = <(String, Map<String, Object?>)>[];
  bool denied = false;
  @override
  Future<Map<String, Object?>> execute(
    String channel, Map<String, Object?> request,
  ) async {
    if (denied) throw StateError('Forbidden');
    calls.add((channel, request));
    return {'id': request['id'] ?? 'fixture-picture', 'version': 2};
  }
}

void check(bool condition, String message) {
  if (!condition) throw StateError(message);
}
Future<void> rejects(Future<void> Function() action) async {
  var rejected = false;
  try { await action(); } catch (_) { rejected = true; }
  check(rejected, 'Expected rejection');
}
Future<void> main() async {
  check(isCommunicationPath('/v1/psw/messages?enable-semantics=true'), 'Protect legacy messaging');
  check(isCommunicationPath('https://api.example.invalid/v1/messages/inbox/'), 'Protect absolute inbox');
  check(isCommunicationPath('/v1/user/messaging/threads/thread'), 'Protect thread children');
  check(!isCommunicationPath('/v1/messages-other'), 'Match path boundaries');
  check(!isCommunicationPath('/v1/provider/profile'), 'Keep unrelated classification');
  for (final path in ['/staff/communication', '/common/patient-messages',
      '/clinic/messaging', '/offices/clinical/roles/psw/messages',
      '/v1/communication', '/v1/messaging', '/v1/psw-messages', '/v1/patient-messages']) {
    check(isCommunicationPath(path), 'Protect existing screen failure: $path');
    check(!isCommunicationPath('$path-other'), 'Preserve screen path boundaries');
  }
  final transport = FixtureTransport();
  final hub = CommunicationHub(transport);
  await hub.messages.send('thread', 'command', 1, 'Fixture', pictureIds: ['picture']);
  check(transport.calls.last.$1 == 'message', 'Message channel');
  check(transport.calls.last.$2['version'] == 1, 'Preserve expected version');
  check(transport.calls.last.$2['key'] == 'command', 'Preserve duplicate key');
  final bytes = Uint8List.fromList([1, 2, 3]);
  await hub.pictures.upload('thread', bytes, 'image/png');
  bytes[0] = 99;
  check((transport.calls.last.$2['bytes']! as Uint8List)[0] == 1, 'Copy upload bytes');
  await hub.audio.call('accept', 'thread', 'accept', 2, 'call');
  check(transport.calls.last.$1 == 'audio', 'Audio channel');
  await hub.email.queue('mail', 'queue', 'fixture@example.invalid', 'Task', 'Fixture');
  check(transport.calls.last.$1 == 'email', 'Email channel');
  await hub.email.inbox(direction: 'inbound', mailboxId: 'owned', limit: 10, after: 'mail:previous');
  check(transport.calls.last.$2['action'] == 'inbox', 'Shared mailbox discovery');
  check(transport.calls.last.$2['after'] == 'mail:previous', 'Preserve bounded continuation');
  final before = transport.calls.length;
  await rejects(() async { await hub.messages.execute('read', {'id': 'thread', 'tenantId': 'other'}); });
  await rejects(() async { await hub.email.execute('receive', {'raw': 'forged'}); });
  await rejects(() async { await hub.audio.call('signal', 'thread', 'signal', 2, 'call'); });
  await rejects(() async { await hub.email.inbox(direction: 'inbound'); });
  await rejects(() async { await hub.email.inbox(direction: 'outbound', mailboxId: 'other'); });
  await rejects(() async { await hub.email.inbox(direction: 'outbound', limit: 101); });
  check(transport.calls.length == before, 'Do not dispatch identity overrides or inbound mail');
  transport.denied = true;
  await rejects(() async { await hub.messages.read('thread'); });
  check(transport.calls.length == before, 'Propagate access denial without retry');
  print('Dart communication core: all channel, binary-copy, identity and denial checks passed');
}
