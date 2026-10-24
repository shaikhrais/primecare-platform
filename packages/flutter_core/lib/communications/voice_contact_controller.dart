import 'dart:math';
import 'communication_core.dart';
import 'communication_workspace_controller.dart';

/// One inherited native-session lifecycle. No automatic SMS/check retries and no
/// code/phone stored in controller state. The server owns identity and quotas.
final class VoiceContactController extends CommunicationWorkspaceControllerBase {
 VoiceContactController({required this.hub,String Function()? requestId}):_requestId=requestId??_uuid;
 final CommunicationHub hub;
 final String Function() _requestId;
 String? _challenge;
 int? _expiresAt;
 bool? _verified;
 bool _allowed=false;
 String _status='phoneNotEnrolled';
 bool _loaded=false,_uncertain=false;
 bool get verified=>_verified==true;
 bool get canSend=>!busy&&_loaded&&_allowed&&!verified&&!_uncertain&&_challenge==null;
 bool get canCheck=>!busy&&!_uncertain&&_challenge!=null&&(_expiresAt??0)>DateTime.now().millisecondsSinceEpoch;
 String get statusKey=>failureKey??(busy?'loading':_status);
 static String _uuid(){final r=Random.secure(),b=List<int>.generate(16,(_)=>r.nextInt(256));b[6]=(b[6]&15)|64;b[8]=(b[8]&63)|128;final h=b.map((v)=>v.toRadixString(16).padLeft(2,'0')).join();return '${h.substring(0,8)}-${h.substring(8,12)}-${h.substring(12,16)}-${h.substring(16,20)}-${h.substring(20)}';}
 bool _exact(Map<String,Object?> value,Set<String> keys)=>value.length==keys.length&&keys.every(value.containsKey);
 @override void clearPrivateState(){_challenge=null;_expiresAt=null;_verified=null;_allowed=false;_loaded=false;}
 @override void operationFailed(Object error){if(error is! CommunicationInputException){_uncertain=true;_status='phoneUnknown';}}
 @override String classify(Object error)=>error is CommunicationInputException?'phoneInvalid':super.classify(error)=='unavailable'?'phoneUnknown':super.classify(error);
 Future<bool> refresh()=>run(() async {
  final value=await hub.voiceContacts.status();
  if(!_exact(value,{'verified','enrollmentAllowed'})||value['verified'] is! bool||value['enrollmentAllowed'] is! bool||value['verified']==true&&value['enrollmentAllowed']==true)throw StateError('Invalid enrollment status');
  return (){_verified=value['verified'] as bool;_allowed=value['enrollmentAllowed'] as bool;_loaded=true;
   if(verified){_challenge=null;_expiresAt=null;_uncertain=false;_status='phoneVerified';}
   else if(_uncertain)_status='phoneUnknown';else if(_challenge!=null)_status='phoneCodeSent';else _status=_allowed?'phoneNotEnrolled':'phoneEnrollmentUnavailable';
  };
 });
 Future<bool> send(String phone){
  if(!canSend)return Future.value(false);
  return run(() async {
   if(phone.length>16||phone!=phone.trim()||!RegExp(r'^\+[1-9][0-9]{6,14}$').hasMatch(phone))throw CommunicationInputException();
   final value=await hub.voiceContacts.start(phone,_requestId()),expires=value['expiresAt'];
   if(!_exact(value,{'challengeId','verificationRequested','expiresAt'})||value['verificationRequested']!=true||value['challengeId'] is! String||(value['challengeId'] as String).length!=36||!RegExp(r'^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$').hasMatch(value['challengeId'] as String)||expires is! int||expires<=DateTime.now().millisecondsSinceEpoch||expires>DateTime.now().millisecondsSinceEpoch+120000)throw StateError('Invalid enrollment challenge');
   return (){_challenge=value['challengeId'] as String;_expiresAt=expires;_status='phoneCodeSent';};
  });
 }
 Future<bool> check(String code){
  if(!canCheck)return Future.value(false);
  final id=_challenge!;
  return run(() async {
   if(code.length!=6||!RegExp(r'^[0-9]{6}$').hasMatch(code))throw CommunicationInputException();
   final value=await hub.voiceContacts.check(id,code);
   if(!_exact(value,{'verified'})||value['verified'] is! bool)throw StateError('Invalid enrollment result');
   return (){if(value['verified']==true){clearPrivateState();_verified=true;_loaded=true;_status='phoneVerified';}else _status='phoneCodeRejected';};
  });
 }
}
