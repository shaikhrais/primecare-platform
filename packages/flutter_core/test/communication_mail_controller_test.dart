import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/business_core.dart';
import 'fixtures/communication_channels_transport.dart';
import 'fixtures/communication_workspace_transport.dart';

void main(){
 late ChannelsTransport transport;late CommunicationMailController model;var serial=0;
 setUp((){transport=ChannelsTransport();model=CommunicationMailController(hub:CommunicationHub(transport),userId:'alice',tenantId:'tenant-a',key:()=> 'mail-${serial++}');});
 tearDown(()=>model.dispose());
 Future<void> queue() async {expect(await model.queue('recipient@example.invalid','Test subject','Hello'),true);}
 test('queue and delivery are two explicit inherited commands, accepted is not delivered',() async {
  expect(model,isA<CommunicationCommandControllerBase>());await queue();expect(model.selected!['status'],'queued');expect(transport.deliveries,0);expect(model.canDeliver,true);
  expect(await model.deliver(),true);expect(model.selected!['status'],'accepted');expect(transport.deliveries,1);expect(model.canDeliver,false);expect(await model.deliver(),false);expect(transport.deliveries,1);
 });
 test('ambiguous queue preserves the exact command and cannot create a replacement',() async {
  transport.loseMailQueue=true;expect(await model.queue('recipient@example.invalid','Subject','Draft'),false);expect(model.hasPendingCommand,true);expect(model.failureKey,'mailPending');
  final first=Map.of(transport.requests.firstWhere((r)=>r['action']=='queue'));
  expect(await model.queue('other@example.invalid','Replacement','Other'),false);expect(transport.mail.length,1);
  expect(await model.retryPending(),true);expect(transport.requests.where((r)=>r['action']=='queue').last,first);expect(transport.mail.length,1);
 });
 test('ambiguous delivery retries original receipt without another provider send',() async {
  await queue();transport.loseMailDeliver=true;expect(await model.deliver(),false);expect(model.hasPendingCommand,true);
  final first=Map.of(transport.requests.firstWhere((r)=>r['action']=='deliver'));expect(await model.retryPending(),true);
  expect(transport.requests.where((r)=>r['action']=='deliver').last,first);expect(transport.deliveries,1);expect(model.selected!['status'],'accepted');
 });
 test('unknown provider acceptance disables subsequent delivery',() async {
  await queue();transport.deliveryStatus='unknown';expect(await model.deliver(),true);expect(model.selected!['status'],'unknown');expect(model.canDeliver,false);expect(await model.deliver(),false);expect(transport.deliveries,1);
 });
 test('received mail requires a mailbox and never retains raw MIME or verification flags',() async {
  transport.received('received');expect(await model.loadInbox(direction:'inbound'),false);expect(transport.requests,isEmpty);
  expect(await model.loadInbox(direction:'inbound',mailboxId:'owned-box'),true);expect(await model.openMail('received'),true);
  expect(model.selected!['status'],'quarantined');expect(model.selected!.containsKey('rawBase64'),false);expect(model.selected!.containsKey('senderIdentityVerified'),false);expect(model.items.single.containsKey('rawBase64'),false);
 });
 test('cross-tenant, wrong owner and wrong mailbox details fail closed',() async {
  await queue();final id=model.selected!['id'] as String;
  transport.mail[id]!['tenantId']='tenant-b';expect(await model.openMail(id),false);expect(model.selected,isNull);
  transport.mail[id]!['tenantId']='tenant-a';transport.mail[id]!['ownerId']='bob';expect(await model.openMail(id),false);
  transport.received('foreign',mailbox:'other-box');await model.loadInbox(direction:'inbound',mailboxId:'owned-box');expect(await model.openMail('foreign'),false);expect(model.selected,isNull);
 });
 test('outbound scope never accepts a mailbox or user override and rejects header injection',() async {
  expect(await model.loadInbox(direction:'outbound',mailboxId:'other'),false);expect(await model.queue('recipient@example.invalid','Injected\r\nBcc: other','Text'),false);expect(await model.queue('bad address','Subject','Text'),false);expect(transport.requests,isEmpty);
 });
 test('mail byte bounds count UTF-8 bytes before dispatch',() async {
  expect(await model.queue('recipient@example.invalid','Subject','é'*40000),false);expect(model.failureKey,'mailInvalid');expect(transport.requests,isEmpty);
 });
 test('permission loss clears visible mail but retains an ambiguous original command',() async {
  transport.loseMailQueue=true;await model.queue('recipient@example.invalid','Subject','Draft');transport.nextFailure=denied(403);
  expect(await model.loadInbox(direction:'outbound'),false);expect(model.failureKey,'forbidden');expect(model.items,isEmpty);expect(model.selected,isNull);expect(model.hasPendingCommand,true);expect(await model.retryPending(),true);
 });
 test('pagination retains scope and bounded records',() async {
  for(var n=0;n<60;n++){transport.received('received-${n.toString().padLeft(2,'0')}');}
  expect(await model.loadInbox(direction:'inbound',mailboxId:'owned-box'),true);expect(model.items.length,25);expect(model.hasMore,true);
  expect(await model.loadMore(),true);expect(model.items.length,50);expect(await model.loadMore(),true);expect(model.items.length,50);expect(model.hasMore,false);
  expect(transport.requests.where((r)=>r['action']=='inbox').every((r)=>r['mailboxId']=='owned-box'&&r['direction']=='inbound'),true);
 });
 test('late mail response cannot restore private state after disposal',() async {
  final waiting=Completer<Map<String,Object?>>();transport.deferred=waiting;final read=model.loadInbox(direction:'outbound');model.dispose();waiting.complete({'items':[],'nextAfter':null});expect(await read,false);expect(model.items,isEmpty);
 });
 test('rapid queue clicks are ignored while the original command is running',() async {
  final waiting=Completer<Map<String,Object?>>();transport.deferred=waiting;final first=model.queue('recipient@example.invalid','Subject','Text');await Future<void>.delayed(Duration.zero);
  expect(await model.queue('recipient@example.invalid','Other','Other'),false);expect(transport.requests.length,1);waiting.completeError(denied(503));expect(await first,false);expect(model.hasPendingCommand,true);
 });
 test('received text preview is bounded, immutable and never promotes sender identity',() async {
  transport.received('received');transport.mail['received']!['contentPreview']={'status':'available','text':'Unverified body','subject':'Unverified subject'};
  await model.loadInbox(direction:'inbound',mailboxId:'owned-box');expect(await model.openMail('received'),true);
  expect(model.selected!['text'],'Unverified body');expect(model.selected!['subject'],'Unverified subject');expect(model.selected!['previewStatus'],'available');expect(model.selected!['status'],'quarantined');
  expect(model.selected!.containsKey('senderIdentityVerified'),false);expect(model.selected!.containsKey('rawBase64'),false);expect(()=>model.selected!['text']='changed',throwsUnsupportedError);
 });
 test('legacy and unavailable preview responses retain only a safe quarantine envelope',() async {
  transport.received('received');transport.mail['received']!['text']='UNAPPROVED RAW BODY';
  await model.loadInbox(direction:'inbound',mailboxId:'owned-box');expect(await model.openMail('received'),true);expect(model.selected!['previewStatus'],'unavailable');expect(model.selected!.containsKey('text'),false);
  transport.mail['received']!['contentPreview']={'status':'unavailable'};expect(await model.openMail('received'),true);expect(model.selected!.containsKey('text'),false);
 });
 test('malformed oversized or partial previews clear private view state',() async {
  transport.received('received');
  for(final preview in [<String,Object?>{'status':'wrong','text':'Private'},{'status':'available','text':7},{'status':'available','text':'é'*40000},{'status':'available','text':'Safe','subject':'x'*201},{'status':'unavailable','text':'Private partial'},{'status':'available','text':'Safe','html':'<script>private</script>'}]){
   transport.mail['received']!['contentPreview']=preview;await model.loadInbox(direction:'inbound',mailboxId:'owned-box');expect(await model.openMail('received'),false);expect(model.selected,isNull);expect(model.items,isEmpty);
  }
 });
 test('inbound verification flags cannot turn untrusted content into a trusted message',() async {
  transport.received('received');transport.mail['received']!['senderIdentityVerified']=true;transport.mail['received']!['contentPreview']={'status':'available','text':'PRIVATE'};
  await model.loadInbox(direction:'inbound',mailboxId:'owned-box');expect(await model.openMail('received'),false);expect(model.selected,isNull);
 });

}
