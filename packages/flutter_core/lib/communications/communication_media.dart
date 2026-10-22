import 'communication_core.dart';

/// Platform media owns resources; all signaling still uses the shared channels.
abstract class CommunicationMediaSession {
 bool get closed;
 Future<void> start();
 void mute(bool muted);
 void close();
}
typedef CommunicationMediaFactory=Future<CommunicationMediaSession> Function({required CommunicationHub hub,required String userId,required String tenantId,required String threadId,required String callId,required void Function(String) onState});
