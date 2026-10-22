import 'dart:typed_data';

/// Existing registered communication paths must never use demo/offline success.
/// This classifies failure handling only; it grants no route or permission.
bool isCommunicationPath(String value) {
  final path = (Uri.tryParse(value)?.normalizePath().path ?? value)
      .replaceFirst(RegExp(r'/+$'), '');
  const roots = {
    '/v1/messages',
    '/v1/psw/messages',
    '/v1/user/messaging/threads',
    '/v1/staff/messages/hub',
    '/v1/client/family/message',
    // Existing registered screens still have legacy controller/generated paths.
    // Classifying their failures grants no alias or backend implementation.
    '/staff/communication',
    '/common/patient-messages',
    '/clinic/messaging',
    '/offices/clinical/roles/psw/messages',
    '/v1/communication',
    '/v1/messaging',
    '/v1/psw-messages',
    '/v1/patient-messages',
  };
  return roots.any((root) => path == root || path.startsWith('$root/'));
}

/// Implement with authenticated transport and registered route mappings.
/// Binary requests require the approved upload adapter, not JSON encoding.
abstract interface class CommunicationTransport {
  Future<Map<String, Object?>> execute(
    String channel,
    Map<String, Object?> request,
  );
}

/// Every client inherits request construction; permissions stay on the server.
abstract base class CommunicationChannelClient {
  CommunicationChannelClient(this.transport, this.channel, Set<String> actions)
      : _actions = Set.unmodifiable(actions);

  final CommunicationTransport transport;
  final String channel;
  final Set<String> _actions;

  Future<Map<String, Object?>> execute(
    String action,
    Map<String, Object?> fields,
  ) {
    if (!_actions.contains(action)) {
      throw ArgumentError('Unsupported communication action');
    }
    const reserved = {'action', 'actor', 'actorId', 'tenantId', 'roles'};
    if (fields.keys.any(reserved.contains)) {
      throw ArgumentError('Identity belongs to authenticated transport');
    }
    return transport.execute(
      channel,
      Map.unmodifiable({'action': action, ...fields}),
    );
  }
}

final class MessageChannelClient extends CommunicationChannelClient {
  MessageChannelClient(CommunicationTransport transport)
      : super(transport, 'message', {'create', 'send', 'read', 'mark_read', 'inbox'});

  Future<Map<String, Object?>> create(
    String id,
    String key,
    List<String> members,
    String businessReference,
  ) => execute('create', {
        'id': id,
        'key': key,
        'members': List<String>.unmodifiable(members),
        'businessReference': businessReference,
      });

  Future<Map<String, Object?>> send(
    String id,
    String key,
    int version,
    String text, {
    List<String> pictureIds = const [],
  }) => execute('send', {
        'id': id,
        'key': key,
        'version': version,
        'text': text,
        'pictureIds': List<String>.unmodifiable(pictureIds),
      });

  Future<Map<String, Object?>> inbox({int limit = 50}) => execute('inbox', {'limit': limit});

  Future<Map<String, Object?>> read(String id) => execute('read', {'id': id});

  Future<Map<String, Object?>> markRead(
    String id, String key, int version, int sequence,
  ) => execute('mark_read', {
        'id': id, 'key': key, 'version': version, 'sequence': sequence,
      });
}

final class PictureChannelClient extends CommunicationChannelClient {
  PictureChannelClient(CommunicationTransport transport)
      : super(transport, 'picture', {'upload', 'open'});

  Future<Map<String, Object?>> upload(
    String threadId, Uint8List bytes, String mediaType,
  ) => execute('upload', {
        'threadId': threadId,
        'bytes': Uint8List.fromList(bytes),
        'mediaType': mediaType,
      });

  Future<Map<String, Object?>> open(String threadId, String pictureId) =>
      execute('open', {'threadId': threadId, 'pictureId': pictureId});
}

final class AudioChannelClient extends CommunicationChannelClient {
  AudioChannelClient(CommunicationTransport transport)
      : super(transport, 'audio', {
          'invite', 'accept', 'decline', 'end', 'expire', 'signal',
        });

  Future<Map<String, Object?>> call(
    String action, String id, String key, int version, String callId, {
    String? recipientId,
  }) {
    if (!{'invite', 'accept', 'decline', 'end', 'expire'}.contains(action)) {
      throw ArgumentError('Use the signal method for call signaling');
    }
    return execute(action, {
        'id': id, 'key': key, 'version': version, 'callId': callId,
        if (recipientId != null) 'recipientId': recipientId,
      });
  }

  Future<Map<String, Object?>> signal(
    String id, String key, int version, String callId,
    Map<String, Object?> signal,
  ) => execute('signal', {
        'id': id, 'key': key, 'version': version, 'callId': callId,
        'signal': Map<String, Object?>.unmodifiable(signal),
      });
}

final class EmailChannelClient extends CommunicationChannelClient {
  EmailChannelClient(CommunicationTransport transport)
      : super(transport, 'email', {'queue', 'deliver', 'read', 'inbox'});

  Future<Map<String, Object?>> queue(
    String id, String key, String to, String subject, String text,
  ) => execute('queue', {
        'id': id, 'key': key, 'to': to, 'subject': subject, 'text': text,
      });

  Future<Map<String, Object?>> deliver(String id, String key, int version) =>
      execute('deliver', {'id': id, 'key': key, 'version': version});

  Future<Map<String, Object?>> read(String id) => execute('read', {'id': id});

  Future<Map<String, Object?>> inbox({
    required String direction,
    String? mailboxId,
    int limit = 50,
    String? after,
  }) {
    if (!{'inbound', 'outbound'}.contains(direction) ||
        (direction == 'inbound' && (mailboxId == null || mailboxId.trim().isEmpty)) ||
        (direction == 'outbound' && mailboxId != null) || limit < 1 || limit > 100 ||
        (after != null && after.trim().isEmpty)) {
      throw ArgumentError('A bounded registered mailbox scope is required');
    }
    return execute('inbox', {
      'direction': direction,
      if (mailboxId != null) 'mailboxId': mailboxId,
      'limit': limit,
      if (after != null) 'after': after,
    });
  }
}

/// Inject the same authenticated transport in every portal and role.
final class CommunicationHub {
  CommunicationHub(CommunicationTransport transport)
      : messages = MessageChannelClient(transport),
        pictures = PictureChannelClient(transport),
        audio = AudioChannelClient(transport),
        email = EmailChannelClient(transport);

  final MessageChannelClient messages;
  final PictureChannelClient pictures;
  final AudioChannelClient audio;
  final EmailChannelClient email;
}
