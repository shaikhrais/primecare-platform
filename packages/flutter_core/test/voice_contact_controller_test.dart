import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/business_core.dart';
import 'fixtures/voice_contact_transport.dart';
void main(){
 late VoiceContactTransport transport;late VoiceContactController model;
 setUp((){transport=VoiceContactTransport();model=VoiceContactController(hub:CommunicationHub(transport),requestId:()=>VoiceContactTransport.challenge);});
 tearDown(()=>model.dispose());
 test('a failed read-only initial status can recover without sending a verification',() async {
  transport.statusError=StateError('Read unavailable');expect(await model.refresh(),false);
  expect(model.canSend,false);expect(transport.sends,0);
  transport.statusError=null;expect(await model.refresh(),true);expect(model.canSend,true);
  expect(transport.sends,0);expect(await model.send('+14165550101'),true);expect(transport.sends,1);
 });
 test('a failed status after any send cannot enable a resend',() async {
  await model.refresh();await model.send('+14165550101');
  transport.statusError=StateError('Read unavailable');expect(await model.refresh(),false);
  transport.statusError=null;await model.refresh();expect(model.canSend,false);
  expect(await model.send('+14165550101'),false);expect(transport.sends,1);
 });

 test('inherited controller uses three native actions and requires an explicit SMS request',() async {
  expect(model,isA<CommunicationWorkspaceControllerBase>());expect(model.canSend,false);await model.refresh();expect(transport.sends,0);expect(model.canSend,true);
  expect(await model.send('+14165550101'),true);expect(model.canSend,false);expect(model.canCheck,true);expect(await model.send('+14165550102'),false);expect(transport.sends,1);
  transport.approved=false;expect(await model.check('123456'),true);expect(model.verified,false);expect(model.canCheck,true);expect(model.statusKey,'phoneCodeRejected');
  transport.approved=true;expect(await model.check('123456'),true);expect(model.verified,true);expect(model.canCheck,false);expect(model.canSend,false);expect(model.statusKey,'phoneVerified');
  expect(transport.requests.where((r)=>r['action']=='start').single,{'action':'start','phone':'+14165550101','requestId':VoiceContactTransport.challenge});
 });
 test('invalid phone and code are rejected without transport while pending challenge is retained',() async {
  await model.refresh();expect(await model.send('4165550101'),false);expect(transport.sends,0);expect(model.statusKey,'phoneInvalid');expect(await model.send('+14165550101'),true);
  expect(await model.check('123456\n'),false);expect(transport.checks,0);expect(model.canCheck,true);
 });
 test('ambiguous SMS or check never retries, duplicates or restores private state',() async {
  await model.refresh();transport.sendUnknown=true;expect(await model.send('+14165550101'),false);expect(model.statusKey,'phoneUnknown');expect(model.canSend,false);await model.refresh();expect(model.canSend,false);expect(await model.send('+14165550101'),false);expect(transport.sends,1);
 });
 test('uncertain approved check is resolved by read-only status, not another SMS or check',() async {
  await model.refresh();await model.send('+14165550101');transport.checkUnknown=true;expect(await model.check('123456'),false);expect(model.canCheck,false);transport.verified=true;await model.refresh();expect(model.verified,true);expect(model.statusKey,'phoneVerified');expect(transport.sends,1);expect(transport.checks,1);
 });
 test('busy lifecycle prevents double clicks and disposal ignores late private results',() async {
  await model.refresh();transport.wait=Completer<void>();final pending=model.send('+14165550101');expect(await model.send('+14165550101'),false);expect(transport.sends,1);model.dispose();transport.wait!.complete();expect(await pending,false);expect(model.canSend,false);expect(model.canCheck,false);
 });
 test('existing or revoked contact status cannot enable replacement enrollment',() async {
  transport.allowed=false;await model.refresh();expect(model.canSend,false);expect(model.statusKey,'phoneEnrollmentUnavailable');expect(await model.send('+14165550101'),false);expect(transport.sends,0);
 });
 test('native phone paths cannot use fallback success and clients reject actor overrides',() async {
  expect(isCommunicationPath('/v1/voice/contact/start'),true);expect(isCommunicationPath('/v1/voice/contact/check'),true);
  expect(()=>model.hub.voiceContacts.execute('start',{'actorId':'other'}),throwsArgumentError);
 });
 test('an unmounted native endpoint displays enrollment uncertainty without another SMS',() async {
  await model.refresh();final request=RequestOptions(path:'/v1/voice/contact/start');transport.sendError=DioException(requestOptions:request,response:Response(requestOptions:request,statusCode:404));
  expect(await model.send('+14165550101'),false);expect(model.statusKey,'phoneUnknown');expect(model.canSend,false);expect(await model.send('+14165550101'),false);expect(transport.sends,1);
 });

}
