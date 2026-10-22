import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/business_core.dart';
import 'fixtures/communication_channels_transport.dart';
import 'fixtures/communication_workspace_transport.dart';

void main(){
 late ChannelsTransport transport;late CommunicationCallController model;MediaFixture? media;var serial=0;
 Future<CommunicationMediaSession> factory({required CommunicationHub hub,required String userId,required String tenantId,required String threadId,required String callId,required void Function(String) onState}) async {media=MediaFixture(onState);return media!;}
 setUp((){transport=ChannelsTransport();media=null;model=CommunicationCallController(hub:CommunicationHub(transport),userId:'alice',tenantId:'tenant-a',key:()=> 'call-${serial++}',mediaFactory:factory);model.selectThread('thread');});
 tearDown(()=>model.dispose());
 void accepted({String caller='alice',String recipient='bob'}){transport.record['calls']=[{'id':'call','callerId':caller,'recipientId':recipient,'status':'accepted'}];}
 test('shared inherited call controller invites with a fresh version and no identity overrides',() async {
  expect(model,isA<CommunicationWorkspaceControllerBase>());await model.refresh();transport.record['version']=3;
  expect(await model.invite('bob'),true);expect(model.calls.single['status'],'ringing');expect(transport.requests.firstWhere((r)=>r['channel']=='audio')['version'],3);
 });
 test('recipient accept and decline are explicit and caller cannot accept own invitation',() async {
  transport.record['calls']=[{'id':'call','callerId':'bob','recipientId':'alice','status':'ringing'}];await model.refresh();expect(await model.act('accept','call'),true);expect(model.calls.single['status'],'accepted');
  transport.record['calls']=[{'id':'call','callerId':'alice','recipientId':'bob','status':'ringing'}];await model.refresh();expect(await model.act('accept','call'),false);expect(model.failureKey,'callInvalid');
 });
 test('invalid targets and third-party calls cannot create microphone sessions',() async {
  await model.refresh();expect(await model.invite('alice'),false);expect(await model.invite('outsider'),false);
  transport.record['members']=['alice','bob','carol'];accepted(caller:'bob',recipient:'carol');await model.refresh();expect(model.calls,isEmpty);expect(await model.connect('call'),false);expect(media,isNull);
 });
 test('ringing calls never request a microphone',() async {
  await model.invite('bob');expect(await model.connect(model.calls.single['id'] as String),false);expect(media,isNull);
 });
 test('ambiguous invitation preserves original key and does not invite twice',() async {
  transport.loseCall=true;expect(await model.invite('bob'),false);expect(model.hasPendingCommand,true);final original=Map.of(transport.requests.firstWhere((r)=>r['channel']=='audio'));
  expect(await model.invite('bob'),false);expect(await model.retryPending(),true);expect(transport.requests.where((r)=>r['channel']=='audio').last,original);expect((transport.record['calls'] as List).length,1);
 });
 test('accepted participant can connect, mute, unmute and release before server hangup',() async {
  accepted();await model.refresh();expect(await model.connect('call'),true);expect(model.mediaState,'mediaConnected');model.toggleMute();expect(media!.muted,true);expect(model.mediaState,'mediaMuted');model.toggleMute();expect(media!.muted,false);
  final ended=model.act('end','call');expect(media!.closed,true);expect(await ended,true);expect(model.calls.single['status'],'ended');expect(media!.closes,1);
 });
 test('background media denial clears private call presentation and closes resources',() async {
  accepted();await model.connect('call');expect(model.calls,isNotEmpty);media!.onState('failed');expect(model.calls,isEmpty);expect(media!.closed,true);expect(model.mediaState,'mediaUnavailable');
 });
 test('changing conversation releases the old microphone and clears call presentation',() async {
  accepted();await model.connect('call');model.selectThread('different');expect(media!.closed,true);expect(model.calls,isEmpty);expect(model.threadId,'different');
 });
 test('permission revocation during refresh closes media and hides private call records',() async {
  accepted();await model.connect('call');transport.nextFailure=denied(403);expect(await model.refresh(),false);expect(media!.closed,true);expect(model.calls,isEmpty);expect(model.failureKey,'forbidden');
 });
 test('disposing during a late platform factory result closes that uncommitted session',() async {
  final waiting=Completer<CommunicationMediaSession>();final orphan=MediaFixture((_){});
  final delayed=CommunicationCallController(hub:CommunicationHub(transport),userId:'alice',tenantId:'tenant-a',mediaFactory:({required hub,required userId,required tenantId,required threadId,required callId,required onState})=>waiting.future);
  accepted();delayed.selectThread('thread');final connecting=delayed.connect('call');await Future<void>.delayed(Duration.zero);delayed.dispose();waiting.complete(orphan);expect(await connecting,false);expect(orphan.closed,true);expect(orphan.starts,0);
 });
 test('late microphone permission cannot restore a disposed session',() async {
  final permission=Completer<void>();final delayed=CommunicationCallController(hub:CommunicationHub(transport),userId:'alice',tenantId:'tenant-a',mediaFactory:({required hub,required userId,required tenantId,required threadId,required callId,required onState}) async {media=MediaFixture(onState)..permission=permission;return media!;});
  accepted();delayed.selectThread('thread');final connecting=delayed.connect('call');await Future<void>.delayed(Duration.zero);delayed.dispose();permission.complete();expect(await connecting,false);expect(media!.closes,1);expect(delayed.calls,isEmpty);
 });
 test('no configured media factory produces a visible error instead of simulated audio',() async {
  final unconfigured=CommunicationCallController(hub:CommunicationHub(transport),userId:'alice',tenantId:'tenant-a');unconfigured.selectThread('thread');accepted();expect(await unconfigured.connect('call'),false);expect(unconfigured.failureKey,'mediaUnavailable');unconfigured.dispose();
 });
 test('cross-tenant and malformed call records never enter view state',() async {
  transport.record['tenantId']='tenant-b';expect(await model.refresh(),false);expect(model.calls,isEmpty);transport.record['tenantId']='tenant-a';transport.record['calls']=[{'id':'call','callerId':'outsider','recipientId':'bob','status':'accepted'}];expect(await model.refresh(),false);expect(model.calls,isEmpty);
 });
 test('retrying an old ambiguous call does not switch a newly selected conversation',() async {
  transport.loseCall=true;await model.invite('bob');model.selectThread('other');expect(await model.retryPending(),true);expect(model.threadId,'other');expect(model.calls,isEmpty);
 });
}
