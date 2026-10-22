import 'dart:async';
import 'dart:typed_data';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import '../components/cy.dart';
import '../components/prime_components.dart';

final communicationWorkspaceControllerProvider=Provider.autoDispose<CommunicationWorkspaceController?>((ref){
 // A role change invalidates presentation; it never grants a client-side right.
 final (signedIn,user,tenant,token,_)=ref.watch(authProvider.select((s)=>(s.isAuthenticated,s.userId,s.tenantId,s.token,s.role)));
 if(!signedIn||user==null||tenant==null||token==null||token.isEmpty)return null;
 final controller=CommunicationWorkspaceController(
  hub:ref.watch(apiClientProvider).communications(maxPictureBytes:CommunicationWorkspaceCatalog.limits['maxPictureBytes']!),userId:user,tenantId:tenant);
 ref.onDispose(controller.dispose);return controller;
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
  return CommunicationWorkspaceView(key:ObjectKey(controller),controller:controller,language:language);
 }
}

/// Presentation only. Controller owns scope, versions, limits and pending commands.
class CommunicationWorkspaceView extends StatefulWidget {
 const CommunicationWorkspaceView({super.key,required this.controller,this.language='en',this.picturePicker});
 final CommunicationWorkspaceController controller;
 final String language;
 final CommunicationPicturePicker? picturePicker;
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
