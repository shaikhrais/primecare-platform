import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/communications/communication_core.dart';
import 'package:flutter_core/communications/communication_workspace_catalog.dart';
import 'package:flutter_core/communications/communication_workspace_controller.dart';
import 'fixtures/communication_workspace_transport.dart';


void main(){
 late FixtureTransport transport;late CommunicationWorkspaceController controller;int key=0;
 setUp((){transport=FixtureTransport();controller=CommunicationWorkspaceController(hub:CommunicationHub(transport),userId:'alice',tenantId:'tenant-a',key:()=> 'command-${key++}');});
 tearDown(()=>controller.dispose());
 test('catalog uses registered controls and all three locales',(){
  expect(CommunicationWorkspaceCatalog.screenIds,[234,331,559,578]);expect(CommunicationWorkspaceCatalog.id('send'),'communication-send');
  expect(CommunicationWorkspaceCatalog.text('fr-CA','send'),'Envoyer le message');expect(CommunicationWorkspaceCatalog.text('es','title'),'Mensajes');expect(CommunicationWorkspaceCatalog.text('unknown','title'),'Messages');
 });
 test('inbox, conversation and message reload use one shared inherited controller',() async {
  expect(controller,isA<CommunicationWorkspaceControllerBase>());expect(await controller.loadInbox(),true);expect(controller.inbox.single['id'],'thread');
  expect(await controller.openThread('thread'),true);expect(await controller.sendMessage('Hello'),true);
  expect((controller.thread!['messages'] as List).single['text'],'Hello');expect(controller.thread!['version'],2);expect(controller.hasPendingCommand,false);
  expect(()=>controller.thread!['id']='changed',throwsUnsupportedError);
 });
 test('creation deduplicates self and recipients and uses the registered general scope',() async {
  expect(await controller.createConversation('bob, alice, bob',''),true);
  final request=transport.requests.firstWhere((r)=>r['action']=='create');expect(request['members'],['alice','bob']);expect(request['businessReference'],CommunicationWorkspaceCatalog.generalReference);
 });
 test('invalid members and empty messages fail before transport',() async {
  expect(await controller.createConversation('alice',''),false);expect(controller.failureKey,'invalidInput');expect(transport.requests,isEmpty);
  await controller.openThread('thread');final before=transport.requests.length;expect(await controller.sendMessage(' '),false);expect(transport.requests.length,before);
 });
 test('explicit retry preserves the original key, version and content after an ambiguous send',() async {
  await controller.openThread('thread');transport.loseSendReceipt=true;
  expect(await controller.sendMessage('Keep this draft'),false);expect(controller.hasPendingCommand,true);expect(controller.failureKey,'uncertain');
  final first=Map<String,Object?>.from(transport.requests.firstWhere((r)=>r['action']=='send'));
  expect(await controller.sendMessage('A different message'),false);expect(transport.requests.where((r)=>r['action']=='send').length,1);
  expect(await controller.retryPending(),true);final sends=transport.requests.where((r)=>r['action']=='send').toList();expect(sends.last,first);
  expect((controller.thread!['messages'] as List).length,1);expect(controller.hasPendingCommand,false);
 });
 test('a confirmed mutation whose reload fails is also reconciled by the same command',() async {
  await controller.openThread('thread');
  // Fail the read after the fixture confirms the command by intercepting that read.
  final delayed=Completer<Map<String,Object?>>();transport.pendingRead=delayed;
  final sending=controller.sendMessage('Confirmed but unread');await Future<void>.delayed(Duration.zero);delayed.completeError(denied(503));
  expect(await sending,false);expect(controller.hasPendingCommand,true);expect(await controller.retryPending(),true);expect((controller.thread!['messages'] as List).length,1);
 });
 test('a malformed acknowledgement cannot clear the draft or original command',() async {
  await controller.openThread('thread');transport.badAcknowledgement=true;
  expect(await controller.sendMessage('Malformed receipt'),false);expect(controller.hasPendingCommand,true);expect(controller.failureKey,'uncertain');
  transport.badAcknowledgement=false;expect(await controller.retryPending(),true);expect((controller.thread!['messages'] as List).length,1);
 });
 test('permission failures clear private records and do not leak provider text',() async {
  await controller.loadInbox();await controller.openThread('thread');transport.nextFailure=denied(403);
  expect(await controller.loadInbox(),false);expect(controller.inbox,isEmpty);expect(controller.thread,isNull);expect(controller.previewBytes,isNull);expect(controller.failureKey,'forbidden');
 });
 test('a denied read cannot discard an earlier ambiguous command',() async {
  await controller.openThread('thread');transport.loseSendReceipt=true;await controller.sendMessage('Already committed');
  transport.nextFailure=denied(403);expect(await controller.loadInbox(),false);expect(controller.failureKey,'forbidden');expect(controller.hasPendingCommand,true);
  expect(await controller.retryPending(),true);expect((controller.thread!['messages'] as List).length,1);
 });
 test('version conflicts do not silently resubmit with a fresh command',() async {
  await controller.openThread('thread');transport.record['version']=2;
  expect(await controller.sendMessage('stale'),false);expect(controller.failureKey,'conflict');expect(controller.hasPendingCommand,false);expect(transport.requests.where((r)=>r['action']=='send').length,1);
 });
 test('late responses cannot restore private state or notify after disposal',() async {
  var notifications=0;controller.addListener(()=>notifications++);final waiting=Completer<Map<String,Object?>>();transport.pendingRead=waiting;
  final reading=controller.openThread('thread');controller.dispose();final before=notifications;waiting.complete(clone(transport.record));
  expect(await reading,false);expect(notifications,before);expect(controller.thread,isNull);expect(controller.inbox,isEmpty);
 });
 test('concurrent actions are not queued behind a pending read',() async {
  final waiting=Completer<Map<String,Object?>>();transport.pendingRead=waiting;final reading=controller.openThread('thread');
  expect(await controller.createConversation('bob',''),false);expect(transport.requests.length,1);waiting.complete(clone(transport.record));expect(await reading,true);
 });
 test('a second click during a write cannot overwrite a confirmed success status',() async {
  await controller.openThread('thread');final waiting=Completer<Map<String,Object?>>();transport.pendingRead=waiting;
  final sending=controller.sendMessage('One click');await Future<void>.delayed(Duration.zero);
  expect(await controller.sendMessage('Second click'),false);waiting.complete(clone(transport.record));
  expect(await sending,true);expect(controller.failureKey,isNull);expect(transport.requests.where((r)=>r['action']=='send').length,1);
 });
 test('cross-session response scope is rejected before becoming visible',() async {
  transport.record['tenantId']='tenant-b';expect(await controller.openThread('thread'),false);expect(controller.thread,isNull);
 });
 test('bounded selected pictures attach only after a clean scoped response',() async {
  await controller.openThread('thread');
  expect(await controller.pickPicture(() async=>CommunicationPictureSelection(length:8,bytes:Stream.value(transport.png))),true);
  expect(controller.draftPictureIds,['picture']);expect(await controller.sendMessage(''),true);
  expect((transport.record['messages'] as List).single['pictureIds'],['picture']);expect(controller.draftPictureIds,isEmpty);
 });
 test('oversized or mismatched file streams do not reach upload transport',() async {
  await controller.openThread('thread');final before=transport.requests.length;
  expect(await controller.pickPicture(() async=>CommunicationPictureSelection(length:CommunicationWorkspaceCatalog.limits['maxPictureBytes']!+1,bytes:const Stream.empty())),false);
  expect(transport.requests.length,before);
  await controller.openThread('thread');final after=transport.requests.length;
  expect(await controller.pickPicture(() async=>CommunicationPictureSelection(length:7,bytes:Stream.value(transport.png))),false);expect(transport.requests.length,after);
 });
 test('cancelled selection and removing a draft attachment never send a message',() async {
  await controller.openThread('thread');expect(await controller.pickPicture(() async=>null),true);
  await controller.pickPicture(() async=>CommunicationPictureSelection(length:8,bytes:Stream.value(transport.png)));controller.removePicture('picture');
  expect(controller.draftPictureIds,isEmpty);expect(transport.requests.where((r)=>r['action']=='send'),isEmpty);
 });
 test('private picture preview is bounded, copied and cleared on permission loss',() async {
  await controller.openThread('thread');expect(await controller.openPicture('picture'),true);final original=controller.previewBytes!;original.fillRange(0,original.length,0);expect(controller.previewBytes!.first,137);
  transport.nextFailure=denied(403);expect(await controller.openPicture('picture'),false);expect(controller.previewBytes,isNull);
 });
 test('read receipts use the current record version and last message sequence',() async {
  await controller.openThread('thread');await controller.sendMessage('Read this');expect(await controller.markRead(),true);
  final request=transport.requests.firstWhere((r)=>r['action']=='mark_read');expect(request['version'],2);expect(request['sequence'],1);expect((controller.thread!['readThrough'] as Map)['alice'],1);
 });
 test('refresh updates the selected conversation without dropping unsent attachment references',() async {
  await controller.openThread('thread');await controller.pickPicture(() async=>CommunicationPictureSelection(length:8,bytes:Stream.value(transport.png)));
  (transport.record['messages'] as List).add({'id':'incoming','text':'New reply','authorId':'bob','sequence':1,'pictureIds':<String>[]});transport.record['version']=2;
  expect(await controller.loadInbox(),true);expect((controller.thread!['messages'] as List).single['text'],'New reply');expect(controller.thread!['version'],2);expect(controller.draftPictureIds,['picture']);
 });
}
