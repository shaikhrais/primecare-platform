import 'communication_media.dart';
/// Native hosts must supply a platform media adapter; no simulated success.
CommunicationMediaFactory browserCommunicationMediaFactory({required Map<String,Object?> configuration})=>({required hub,required userId,required tenantId,required threadId,required callId,required onState}) async =>throw UnsupportedError('Browser media required');
