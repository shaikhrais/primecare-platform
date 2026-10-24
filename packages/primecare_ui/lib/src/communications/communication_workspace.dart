import 'dart:async';
import 'dart:typed_data';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import '../components/cy.dart';
import '../components/prime_components.dart';
import '../theme/prime_theme.dart';

final communicationWorkspaceControllerProvider=Provider.autoDispose<CommunicationWorkspaceController?>((ref){
 // A role change invalidates presentation; it never grants a client-side right.
 final (signedIn,user,tenant,token,_)=ref.watch(authProvider.select((s)=>(s.isAuthenticated,s.userId,s.tenantId,s.token,s.role)));
 if(!signedIn||user==null||tenant==null||token==null||token.isEmpty)return null;
 final controller=CommunicationWorkspaceController(
  hub:ref.watch(apiClientProvider).communications(maxPictureBytes:CommunicationWorkspaceCatalog.limits['maxPictureBytes']!),userId:user,tenantId:tenant);
 ref.onDispose(controller.dispose);return controller;
});

final voiceContactControllerProvider=Provider.autoDispose<VoiceContactController?>((ref){
 final workspace=ref.watch(communicationWorkspaceControllerProvider);if(workspace==null)return null;
 final controller=VoiceContactController(hub:workspace.hub);ref.onDispose(controller.dispose);return controller;
});

/// Trusted host composition supplies a fresh configured platform media factory.
/// No credentials, servers or grants are inferred by the screen.
final communicationMediaFactoryProvider=Provider<CommunicationMediaFactory?>((ref)=>null);
final communicationMailControllerProvider=Provider.autoDispose<CommunicationMailController?>((ref){
 final workspace=ref.watch(communicationWorkspaceControllerProvider);if(workspace==null)return null;
 final controller=CommunicationMailController(hub:workspace.hub,userId:workspace.userId,tenantId:workspace.tenantId);
 ref.onDispose(controller.dispose);return controller;
});
final communicationCallControllerProvider=Provider.autoDispose<CommunicationCallController?>((ref){
 final workspace=ref.watch(communicationWorkspaceControllerProvider);if(workspace==null)return null;
 final controller=CommunicationCallController(hub:workspace.hub,userId:workspace.userId,tenantId:workspace.tenantId,mediaFactory:ref.watch(communicationMediaFactoryProvider));
 void select(){final id=workspace.thread?['id'] as String?;if(controller.threadId!=id){controller.selectThread(id);if(id!=null)unawaited(controller.refresh());}}
 workspace.addListener(select);select();ref.onDispose((){workspace.removeListener(select);controller.dispose();});return controller;
});

/// Existing role screens inherit presentation; neither views nor roles copy APIs.
abstract class CommunicationScreenBase extends ConsumerWidget {
 const CommunicationScreenBase({super.key,required this.screenId});
 final int screenId;
 static const implementationTags={'logic':'implemented-unverified','api':'registered-unmounted','productionReady':false};
 @override Widget build(BuildContext context,WidgetRef ref){
  if(!CommunicationWorkspaceCatalog.screenIds.contains(screenId))throw StateError('Unregistered communication screen');
  final language=Localizations.localeOf(context).languageCode;
  final controller=ref.watch(communicationWorkspaceControllerProvider);
  if(controller==null)return Scaffold(appBar:AppBar(title:Text(CommunicationWorkspaceCatalog.text(language,'title'))),body:Cy(id:CommunicationWorkspaceCatalog.id('status'),child:Text(CommunicationWorkspaceCatalog.text(language,'unauthenticated'))));
  return CommunicationWorkspaceView(key:ObjectKey(controller),controller:controller,language:language,mailController:ref.watch(communicationMailControllerProvider),callController:ref.watch(communicationCallControllerProvider),contactController:ref.watch(voiceContactControllerProvider));
 }
}

/// Presentation only. Controller owns scope, versions, limits and pending commands.
class CommunicationWorkspaceView extends StatefulWidget {
 const CommunicationWorkspaceView({super.key,required this.controller,this.language='en',this.picturePicker,this.mailController,this.callController,this.contactController});
 final CommunicationWorkspaceController controller;
 final String language;
 final CommunicationPicturePicker? picturePicker;
 final CommunicationMailController? mailController;
 final CommunicationCallController? callController;
 final VoiceContactController? contactController;
 @override State<CommunicationWorkspaceView> createState()=>_CommunicationWorkspaceViewState();
}
class _CommunicationWorkspaceViewState extends State<CommunicationWorkspaceView> {
 final _members=TextEditingController(),_reference=TextEditingController(),_composer=TextEditingController();
 CommunicationWorkspaceController get model=>widget.controller;
 String text(String key)=>CommunicationWorkspaceCatalog.text(widget.language,key);
 String id(String key)=>CommunicationWorkspaceCatalog.id(key);
 @override void initState(){super.initState();WidgetsBinding.instance.addPostFrameCallback((_){if(mounted)unawaited(model.loadInbox());});}
 @override void dispose(){_members.dispose();_reference.dispose();_composer.dispose();super.dispose();}
 Future<CommunicationPictureSelection?> _pick() async {
  final file=await openFile(acceptedTypeGroups:[XTypeGroup(label:text('picturePick'),extensions:const ['png','jpg','jpeg'],mimeTypes:const ['image/png','image/jpeg'],uniformTypeIdentifiers:const ['public.png','public.jpeg'])]);
  if(file==null)return null;
  return CommunicationPictureSelection(length:await file.length(),bytes:file.openRead());
 }
 Future<void> _create() async {if(await model.createConversation(_members.text,_reference.text)&&mounted){_members.clear();_reference.clear();_composer.clear();}}
 Future<void> _send() async {if(await model.sendMessage(_composer.text)&&mounted)_composer.clear();}
 Future<void> _retry() async {if(await model.retryPending()&&mounted)_composer.clear();}
 Widget button(String key,VoidCallback? action,{String? testId})=>PrimeButton(label:text(key=='openThread'?'conversation':key),onPressed:action,dataCy:testId??id(key));
 Widget card(String key,Widget child)=>Cy(id:id(key),child:PrimeCareCard(color:Theme.of(context).colorScheme.surface,margin:const EdgeInsets.only(bottom:16),child:child));
 Widget field(String key,TextEditingController controller,{int lines=1,bool enabled=true})=>PrimeCareTextField(label:text(key),controller:controller,maxLines:lines,enabled:enabled,dataCy:id(key));
 Widget _inbox(){
  return card('inbox',Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
   Text(text('inbox'),style:Theme.of(context).textTheme.titleLarge),
   if(model.inbox.isEmpty)Text(text('emptyInbox')),
   for(var i=0;i<model.inbox.length;i++)Padding(padding:const EdgeInsets.only(top:12),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
    Text(model.inbox[i]['id'] as String,maxLines:2,overflow:TextOverflow.ellipsis),
    button('openThread',model.busy||model.hasPendingCommand?null:(){_composer.clear();unawaited(model.openThread(model.inbox[i]['id'] as String));},testId:'${id('openThread')}-$i'),
   ])),
   const SizedBox(height:16),field('members',_members,enabled:model.canMutate),const SizedBox(height:12),field('businessReference',_reference,enabled:model.canMutate),const SizedBox(height:12),button('create',model.canMutate?_create:null),
  ]));
 }
 Widget _conversation(){
  final thread=model.thread;
  return card('conversation',Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
   Text(text('conversation'),style:Theme.of(context).textTheme.titleLarge),
   if(thread==null)Text(text('emptyConversation')) else ...[
    Text(thread['id'] as String,maxLines:2,overflow:TextOverflow.ellipsis),
    for(var index=0;index<(thread['messages'] as List).length;index++)_message((thread['messages'] as List)[index] as Map,index),
   ],
    const SizedBox(height:12),field('composer',_composer,lines:4,enabled:model.canMutate&&thread!=null),const SizedBox(height:12),
    Wrap(spacing:12,runSpacing:12,children:[button('send',model.canMutate&&thread!=null?_send:null),button('markRead',model.canMutate&&thread!=null?()=>unawaited(model.markRead()):null),button('picturePick',model.canMutate&&thread!=null?()=>unawaited(model.pickPicture(widget.picturePicker??_pick)):null)]),
    if(model.draftPictureIds.isNotEmpty)card('attachments',Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[Text(text('attachments')),for(var i=0;i<model.draftPictureIds.length;i++)button('pictureRemove',model.canMutate?()=>model.removePicture(model.draftPictureIds[i]):null,testId:'${id('pictureRemove')}-$i')])),
    if(model.previewBytes case final Uint8List bytes)_PrivatePicturePreview(bytes:bytes,label:text('preview'),failure:text('unavailable')),
  ]));
 }
 Widget _message(Map message,int index){
  final pictures=message['pictureIds'] is List?message['pictureIds'] as List:const [];
  return Padding(padding:const EdgeInsets.symmetric(vertical:12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
   if(message['authorId'] is String)Text(message['authorId'] as String,style:Theme.of(context).textTheme.labelMedium),
   Text(message['text'] is String?message['text'] as String:''),
   for(var p=0;p<pictures.length;p++)button('pictureOpen',model.busy?null:()=>unawaited(model.openPicture(pictures[p] as String)),testId:'${id('pictureOpen')}-$index-$p'),
  ]));
 }
 @override Widget build(BuildContext context)=>ListenableBuilder(listenable:model,builder:(context,_)=>Scaffold(
  appBar:AppBar(title:Text(text('title'))),
  body:Cy(id:id('root'),child:SingleChildScrollView(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
   card('status',Semantics(liveRegion:true,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text(text(model.busy?'loading':model.failureKey??'ready')),
    const SizedBox(height:8),button('refresh',model.busy?null:()=>unawaited(model.loadInbox())),
    if(model.hasPendingCommand&&!model.busy)...[const SizedBox(height:8),Text(text('pending')),button('retry',_retry)],
   ]))),
   LayoutBuilder(builder:(context,constraints)=>constraints.maxWidth>=800?Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:_inbox()),const SizedBox(width:16),Expanded(child:_conversation())]):Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[_inbox(),_conversation()])),
   if(widget.contactController case final VoiceContactController contact)VoiceContactVerificationPanel(key:ObjectKey(contact),model:contact,language:widget.language),
   if(widget.callController case final CommunicationCallController calls)_CommunicationCallPanel(key:ObjectKey(calls),model:calls,language:widget.language),
   if(widget.mailController case final CommunicationMailController mail)_CommunicationMailPanel(key:ObjectKey(mail),model:mail,language:widget.language),
  ]))),
 ));
}

class _PrivatePicturePreview extends StatefulWidget {
 const _PrivatePicturePreview({required this.bytes,required this.label,required this.failure});
 final Uint8List bytes;final String label,failure;
 @override State<_PrivatePicturePreview> createState()=>_PrivatePicturePreviewState();
}
class _PrivatePicturePreviewState extends State<_PrivatePicturePreview> {
 late ImageProvider<Object> _image;
 void _create(){_image=ResizeImage.resizeIfNeeded(512,512,MemoryImage(widget.bytes));}
 void _evict(){unawaited(_image.evict().then<void>((_){},onError:(Object _,StackTrace __){}));}
 @override void initState(){super.initState();_create();}
 @override void didUpdateWidget(covariant _PrivatePicturePreview oldWidget){super.didUpdateWidget(oldWidget);if(!listEquals(oldWidget.bytes,widget.bytes)){_evict();_create();}}
 @override void dispose(){_evict();super.dispose();}
 @override Widget build(BuildContext context)=>Image(image:_image,width:256,height:256,fit:BoxFit.contain,semanticLabel:widget.label,errorBuilder:(context,error,stack)=>Text(widget.failure));
}


/// Shared registered channel presentation; controllers own transitions and scope.
class _CommunicationMailPanel extends StatefulWidget {
 const _CommunicationMailPanel({super.key,required this.model,required this.language});
 final CommunicationMailController model;final String language;
 @override State<_CommunicationMailPanel> createState()=>_CommunicationMailPanelState();
}
class _CommunicationMailPanelState extends State<_CommunicationMailPanel> {
 final _mailbox=TextEditingController(),_to=TextEditingController(),_subject=TextEditingController(),_body=TextEditingController();
 CommunicationMailController get model=>widget.model;
 String text(String key)=>CommunicationWorkspaceCatalog.text(widget.language,key);
 String id(String key)=>CommunicationWorkspaceCatalog.id(key);
 PrimeSpacing get spacing=>PrimeTheme.of(context).spacing;
 @override void dispose(){_mailbox.dispose();_to.dispose();_subject.dispose();_body.dispose();super.dispose();}
 void _clear(){_to.clear();_subject.clear();_body.clear();}
 Future<void> _queue() async {if(await model.queue(_to.text,_subject.text,_body.text)&&mounted)_clear();}
 Future<void> _retry() async {final queued=model.pendingAction=='queue';if(await model.retryPending()&&mounted&&queued)_clear();}
 Widget button(String key,VoidCallback? action,{String? testId})=>PrimeButton(label:text(key),onPressed:action,dataCy:testId??id(key));
 Widget field(String key,TextEditingController controller,{int lines=1})=>Padding(padding:EdgeInsets.only(top:spacing.md),child:PrimeCareTextField(label:text(key),controller:controller,maxLines:lines,enabled:model.canMutate,dataCy:id(key)));
 String status(Object? value)=>switch(value){'queued'=>'mailQueued','sending'=>'mailSending','accepted'=>'mailAccepted','unknown'=>'mailUnknown','quarantined'=>'mailQuarantined',_=>'unavailable'};
 @override Widget build(BuildContext context)=>ListenableBuilder(listenable:model,builder:(context,_)=>Cy(id:id('mail'),child:PrimeCareCard(color:Theme.of(context).colorScheme.surface,margin:EdgeInsets.only(bottom:spacing.cardGap),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
  Text(text('mail'),style:Theme.of(context).textTheme.titleLarge),
  Cy(id:id('mailStatus'),child:Semantics(liveRegion:true,child:Text(text(model.busy?'loading':model.failureKey??'ready')))),
  if(model.hasPendingCommand)...[Text(text('mailPending')),button('mailRetry',model.busy?null:_retry)],
  field('mailbox',_mailbox),SizedBox(height:spacing.md),
  Wrap(spacing:spacing.md,runSpacing:spacing.md,children:[button('mailInbound',model.busy?null:()=>unawaited(model.loadInbox(direction:'inbound',mailboxId:_mailbox.text))),button('mailOutbound',model.busy?null:()=>unawaited(model.loadInbox(direction:'outbound'))),button('mailRefresh',model.busy?null:()=>unawaited(model.refreshInbox()))]),
  Cy(id:id('mailItems'),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
   if(model.items.isEmpty)Text(text('mailEmpty')),
   for(var index=0;index<model.items.length;index++)Padding(padding:EdgeInsets.only(top:spacing.md),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
    Text(model.items[index]['subject'] as String? ?? model.items[index]['id'] as String),Text(text(status(model.items[index]['status']))),button('mailOpen',model.busy?null:()=>unawaited(model.openMail(model.items[index]['id'] as String)),testId:'${id('mailOpen')}-$index'),
   ])),
   if(model.hasMore)button('mailMore',model.busy?null:()=>unawaited(model.loadMore())),
  ])),
  if(model.selected case final Map<String,Object?> mail)Cy(id:id('mailDetail'),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
   Text(mail['id'] as String),Text(mail['from'] as String),Text(mail['to'] as String),
   if(mail['subject'] case final String subject)Text(subject),
   Text(text(status(mail['status']))),
   if(mail['previewStatus'] case final String previewStatus)Text(text(previewStatus=='available'?'mailPreview':'mailPreviewUnavailable')),
   if(mail['text'] case final String body)Text(body),
  ])),
  field('mailTo',_to),field('mailSubject',_subject),field('mailBody',_body,lines:5),SizedBox(height:spacing.md),
  Wrap(spacing:spacing.md,runSpacing:spacing.md,children:[button('mailQueue',model.canMutate?_queue:null),button('mailDeliver',model.canDeliver?()=>unawaited(model.deliver()):null)]),
 ]))));
}
class _CommunicationCallPanel extends StatefulWidget {
 const _CommunicationCallPanel({super.key,required this.model,required this.language});
 final CommunicationCallController model;final String language;
 @override State<_CommunicationCallPanel> createState()=>_CommunicationCallPanelState();
}
class _CommunicationCallPanelState extends State<_CommunicationCallPanel> {
 final _recipient=TextEditingController();
 CommunicationCallController get model=>widget.model;
 String text(String key)=>CommunicationWorkspaceCatalog.text(widget.language,key);
 String id(String key)=>CommunicationWorkspaceCatalog.id(key);
 PrimeSpacing get spacing=>PrimeTheme.of(context).spacing;
 @override void dispose(){_recipient.dispose();super.dispose();}
 Widget button(String key,VoidCallback? action,{String? testId})=>PrimeButton(label:text(key),onPressed:action,dataCy:testId??id(key));
 String status(Object? value)=>switch(value){'ringing'=>'callRinging','accepted'=>'callAccepted','declined'=>'callDeclined','ended'=>'callEnded','missed'=>'callExpired',_=>'unavailable'};
 @override Widget build(BuildContext context)=>ListenableBuilder(listenable:model,builder:(context,_)=>Cy(id:id('calls'),child:PrimeCareCard(color:Theme.of(context).colorScheme.surface,margin:EdgeInsets.only(bottom:spacing.cardGap),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
  Text(text('calls'),style:Theme.of(context).textTheme.titleLarge),
  Cy(id:id('callStatus'),child:Semantics(liveRegion:true,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(text(model.busy?'loading':model.failureKey??model.mediaState)),if(!model.mediaConfigured)Text(text('mediaUnavailable'))]))),
  if(model.hasPendingCommand)...[Text(text('callPending')),button('retry',model.busy?null:()=>unawaited(model.retryPending()),testId:'${id('retry')}-call')],
  if(model.calls.isEmpty)Text(text('callEmpty')),
  for(var index=0;index<model.calls.length;index++)Padding(padding:EdgeInsets.symmetric(vertical:spacing.md),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
   Text(model.calls[index]['id'] as String),Text(text(status(model.calls[index]['status']))),
   Wrap(spacing:spacing.md,runSpacing:spacing.md,children:[
    button('callAccept',model.canAccept(model.calls[index])?()=>unawaited(model.act('accept',model.calls[index]['id'] as String)):null,testId:'${id('callAccept')}-$index'),
    button('callDecline',model.canAccept(model.calls[index])?()=>unawaited(model.act('decline',model.calls[index]['id'] as String)):null,testId:'${id('callDecline')}-$index'),
    button('callEnd',model.canEnd(model.calls[index])?()=>unawaited(model.act('end',model.calls[index]['id'] as String)):null,testId:'${id('callEnd')}-$index'),
    button('callConnect',model.canConnect(model.calls[index])?()=>unawaited(model.connect(model.calls[index]['id'] as String)):null,testId:'${id('callConnect')}-$index'),
   ]),
  ])),
  PrimeCareTextField(label:text('callRecipient'),controller:_recipient,enabled:model.canInvite,dataCy:id('callRecipient')),SizedBox(height:spacing.md),
  Wrap(spacing:spacing.md,runSpacing:spacing.md,children:[button('callInvite',model.canInvite?()=>unawaited(model.invite(_recipient.text)):null),button('callRefresh',model.busy||model.threadId==null?null:()=>unawaited(model.refresh())),button('callMute',model.mediaActive&&!model.busy?model.toggleMute:null)]),
 ]))));
}

/// Registered presentation only: the controller owns validation and request state.
class VoiceContactVerificationPanel extends StatefulWidget {
 const VoiceContactVerificationPanel({super.key,required this.model,this.language='en'});
 final VoiceContactController model;final String language;
 @override State<VoiceContactVerificationPanel> createState()=>_VoiceContactVerificationPanelState();
}
class _VoiceContactVerificationPanelState extends State<VoiceContactVerificationPanel> {
 final _phone=TextEditingController(),_code=TextEditingController();
 String text(String key)=>CommunicationWorkspaceCatalog.text(widget.language,key);
 String id(String key)=>CommunicationWorkspaceCatalog.id(key);
 @override void initState(){super.initState();WidgetsBinding.instance.addPostFrameCallback((_){if(mounted)unawaited(widget.model.refresh());});}
 @override void didUpdateWidget(covariant VoiceContactVerificationPanel oldWidget){super.didUpdateWidget(oldWidget);if(oldWidget.model!=widget.model){_phone.clear();_code.clear();WidgetsBinding.instance.addPostFrameCallback((_){if(mounted)unawaited(widget.model.refresh());});}}
 @override void dispose(){_phone.clear();_code.clear();_phone.dispose();_code.dispose();super.dispose();}
 void _send(){final value=_phone.text;_phone.clear();_code.clear();unawaited(widget.model.send(value));}
 void _check(){final value=_code.text;_code.clear();unawaited(widget.model.check(value));}
 @override Widget build(BuildContext context)=>ListenableBuilder(listenable:widget.model,builder:(context,_)=>Cy(id:id('phoneVerification'),child:PrimeCareCard(child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
  Text(text('phoneVerification'),style:Theme.of(context).textTheme.titleLarge),
  Cy(id:id('phoneStatus'),child:Semantics(liveRegion:true,child:Text(text(widget.model.statusKey)))),
  PrimeCareTextField(label:text('phoneNumber'),controller:_phone,enabled:widget.model.canSend,dataCy:id('phoneNumber')),
  PrimeButton(label:text('phoneSend'),onPressed:widget.model.canSend?_send:null,dataCy:id('phoneSend')),
  PrimeCareTextField(label:text('phoneCode'),controller:_code,isPassword:true,enabled:widget.model.canCheck,dataCy:id('phoneCode')),
  PrimeButton(label:text('phoneCheck'),onPressed:widget.model.canCheck?_check:null,dataCy:id('phoneCheck')),
  PrimeButton(label:text('phoneRefresh'),onPressed:widget.model.busy?null:()=>unawaited(widget.model.refresh()),dataCy:id('phoneRefresh')),
 ]))));
}
