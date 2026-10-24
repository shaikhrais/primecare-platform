import 'dart:async';
import 'package:flutter_core/business_core.dart';
final class VoiceContactTransport implements CommunicationTransport {
 final requests=<Map<String,Object?>>[];
 bool verified=false,allowed=true,sendUnknown=false,checkUnknown=false,approved=true;
 Completer<void>? wait;
 int sends=0,checks=0;
 static const challenge='11111111-1111-4111-8111-111111111111';
 @override Future<Map<String,Object?>> execute(String channel,Map<String,Object?> request) async {
  if(channel!='voiceContact')throw StateError('Unexpected channel');requests.add(Map.of(request));
  if(request['action']=='status')return {'verified':verified,'enrollmentAllowed':!verified&&allowed};
  if(request['action']=='start'){sends++;await wait?.future;if(sendUnknown)throw StateError('PRIVATE PROVIDER DATA');return {'challengeId':challenge,'verificationRequested':true,'expiresAt':DateTime.now().millisecondsSinceEpoch+60000};}
  if(request['action']=='check'){checks++;await wait?.future;if(checkUnknown)throw StateError('PRIVATE PROVIDER DATA');verified=approved;return {'verified':verified};}
  throw StateError('Unexpected action');
 }
}
