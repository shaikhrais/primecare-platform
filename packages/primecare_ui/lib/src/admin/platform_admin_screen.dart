import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import '../screens/base_primecare_screen.dart';
import '../layout/base_primecare_layout.dart';
import '../localization/app_localizations.dart';

class PlatformAdminScreen extends BasePrimecareScreen {
 final AuthorizedRequest request;
 const PlatformAdminScreen({super.key,required this.request});
 @override String get title=>'Platform administration';
 @override String get titleKey=>'control.title';
 @override Widget buildContent(BuildContext context)=>_PlatformContent(request:request);
}
class _Controller extends BasePlatformAdminWorkflow {
 final VoidCallback notify;
 _Controller(super.request,this.notify);
 @override void changed()=>notify();
}
class _PlatformContent extends StatefulWidget {
 final AuthorizedRequest request;
 const _PlatformContent({required this.request});
 @override State<_PlatformContent> createState()=>_PlatformState();
}
class _PlatformState extends State<_PlatformContent> {
 late final _Controller controller;
 String section='control.monitor';
 AppStrings get strings=>AppStrings.of(context);
 @override void initState(){super.initState();controller=_Controller(widget.request,(){if(mounted)setState((){});});WidgetsBinding.instance.addPostFrameCallback((_){if(mounted)controller.refresh();});}
 Future<Map<String,String>?> editor(String mode,{AdminMasterRecord? record})=>showDialog<Map<String,String>>(context:context,builder:(_)=>_ControlEditor(mode:mode,roles:controller.assignableRoles,record:record));
 Future<void> tenant() async {final data=await editor('tenant');if(data!=null&&mounted)await controller.provisionTenant(data['name']!,data['slug']!);}
 Future<void> account() async {final data=await editor('account');if(data!=null&&mounted)await controller.provisionAccount(data['email']!,data['role']!,data['password']!);}
 Future<void> master([AdminMasterRecord? record]) async {final data=await editor('master',record:record);if(data!=null&&mounted)await controller.saveMaster(data['code']!,{for(final language in ['en','es','fr'])language:data[language]!},data['status']!,record:record);}
 Widget heading(String key)=>Padding(padding:const EdgeInsets.symmetric(vertical:16),child:Text(strings.text(key),style:Theme.of(context).textTheme.titleLarge));
 Widget pages(int offset,int count,int total,void Function(int) load)=>Wrap(children:[TextButton(onPressed:controller.busy||offset==0?null:()=>load(offset-25),child:Text(strings.text('previous'))),TextButton(onPressed:controller.busy||offset+count>=total?null:()=>load(offset+25),child:Text(strings.text('next')))]);
 @override Widget build(BuildContext context)=>ListView(padding:PrimecareLayoutData.of(context).pageInsets,children:[
  Text(strings.text('control.scopeNotice')),
  if(controller.busy)const LinearProgressIndicator(),
  if(controller.error!=null)Text(strings.text(controller.errorCode??'error.unavailable'),style:TextStyle(color:Theme.of(context).colorScheme.error)),
  OutlinedButton(onPressed:controller.busy?null:controller.refresh,child:Text(strings.text('control.refresh'))),
  Wrap(spacing:8,runSpacing:8,children:[for(final key in ['control.monitor','control.tenants','control.accounts','control.masters','control.audit'])TextButton(onPressed:()=>setState(()=>section=key),child:Text(strings.text(key)))]),
  if(section=='control.monitor')...[
  heading('control.monitor'),
  if(controller.snapshot!=null)...[
   Text(strings.text('control.sampled',{'time':controller.snapshot!.sampledAt.toLocal().toString()})),
   Wrap(spacing:16,runSpacing:8,children:controller.snapshot!.counts.entries.map((entry)=>SizedBox(width:240,child:Card(child:Padding(padding:const EdgeInsets.all(12),child:Text('${strings.text('metric.${entry.key}')}: ${entry.value}'))))).toList()),
  ],
  ],
  if(section=='control.tenants')...[
  heading('control.tenants'),
  FilledButton(onPressed:controller.busy||controller.snapshot==null?null:tenant,child:Text(strings.text('control.createTenant'))),
  ...controller.tenants.map((item)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:PrimecareDetailLayout(details:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(item.name),Text('${item.slug} · ${strings.containsKey(item.status)?strings.text(item.status):item.status}')]),actions:TextButton(onPressed:controller.busy?null:(){setState(()=>section='control.accounts');controller.selectTenant(item);},child:Text(strings.text('control.manageTenant'))))))),
  pages(controller.tenantOffset,controller.tenants.length,controller.tenantTotal,controller.loadTenants),
  ],
  if(section=='control.accounts')...[
  heading('control.accounts'),
  Text(controller.selectedTenant==null?strings.text('control.selectTenant'):strings.text('control.selectedTenant',{'name':controller.selectedTenant!.name})),
  FilledButton(onPressed:controller.busy||controller.selectedTenant==null||controller.assignableRoles.isEmpty?null:account,child:Text(strings.text('admin.create'))),
  ...controller.accounts.map((user)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(user.email),Text('${strings.role(user.role)} · ${strings.text(user.status)}')])))),
  pages(controller.accountOffset,controller.accounts.length,controller.accountTotal,controller.loadAccounts),
  ],
  if(section=='control.masters')...[
  heading('control.masters'),
  Text(controller.selectedTenant==null?strings.text('control.globalMasters'):strings.text('control.selectedTenant',{'name':controller.selectedTenant!.name})),
  TextButton(onPressed:controller.busy?null:()=>controller.selectTenant(null),child:Text(strings.text('control.globalMasters'))),
  if(controller.categories.isNotEmpty)DropdownButtonFormField<String>(key:ValueKey((controller.category,controller.stateRevision)),initialValue:controller.category,isExpanded:true,decoration:InputDecoration(labelText:strings.text('control.category')),items:controller.categories.map((code)=>DropdownMenuItem(value:code,child:Text(strings.text('master.$code'),overflow:TextOverflow.ellipsis))).toList(),onChanged:controller.busy?null:(value){if(value!=null)controller.selectCategory(value);}),
  FilledButton(onPressed:controller.busy||controller.snapshot==null?null:()=>master(),child:Text(strings.text('control.createMaster'))),
  Text(strings.text('control.referenceNotice')),
  ...controller.records.map((item)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:PrimecareDetailLayout(details:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(item.label(strings.languageCode)),Text('${item.code} · ${strings.text(item.status)}')]),actions:IconButton(tooltip:strings.text('control.editMaster'),onPressed:controller.busy?null:()=>master(item),icon:const Icon(Icons.edit)))))),
  pages(controller.masterOffset,controller.records.length,controller.masterTotal,controller.loadMasters),
  ],
  if(section=='control.audit')...[
  heading('control.audit'),
  ...controller.controlEvents.map((event)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(strings.text('control.event.${event.action}')),Text(event.createdAt.toLocal().toString()),Text(strings.text('audit.actor',{'id':event.actor})),Text(strings.text('audit.target',{'id':event.target}))])))),
  pages(controller.eventOffset,controller.controlEvents.length,controller.eventTotal,controller.loadEvents),
  ],
 ]);
}
class _ControlEditor extends StatefulWidget {
 final String mode;
 final List<String> roles;
 final AdminMasterRecord? record;
 const _ControlEditor({required this.mode,required this.roles,this.record});
 @override State<_ControlEditor> createState()=>_ControlEditorState();
}
class _ControlEditorState extends State<_ControlEditor> {
 final form=GlobalKey<FormState>();
 late final Map<String,TextEditingController> fields;
 late String role,status;
 @override void initState(){super.initState();fields={for(final key in widget.mode=='tenant'?['name','slug']:widget.mode=='account'?['email','password']:['code','en','es','fr'])key:TextEditingController(text:key=='code'?widget.record?.code:widget.record?.labels[key])};role=widget.roles.isEmpty?'client':widget.roles.first;status=widget.record?.status??'active';}
 @override void dispose(){for(final value in fields.values){value.dispose();}super.dispose();}
 @override Widget build(BuildContext context){final strings=AppStrings.of(context);return PrimecareFormDialog(title:Text(strings.text(widget.mode=='tenant'?'control.createTenant':widget.mode=='account'?'admin.create':widget.record==null?'control.createMaster':'control.editMaster')),content:Form(key:form,child:Column(mainAxisSize:MainAxisSize.min,children:[
  for(final entry in fields.entries)TextFormField(controller:entry.value,enabled:!(entry.key=='code'&&widget.record!=null),obscureText:entry.key=='password',decoration:InputDecoration(labelText:strings.text('control.field.${entry.key}')),validator:(value)=>value==null||value.trim().isEmpty?strings.text('required',{'field':strings.text('control.field.${entry.key}')}):null),
  if(widget.mode=='account')DropdownButtonFormField<String>(initialValue:role,isExpanded:true,decoration:InputDecoration(labelText:strings.text('admin.role')),items:widget.roles.map((value)=>DropdownMenuItem(value:value,child:Text(strings.role(value),overflow:TextOverflow.ellipsis))).toList(),onChanged:(value){if(value!=null)setState(()=>role=value);}),
  if(widget.mode=='master')DropdownButtonFormField<String>(initialValue:status,isExpanded:true,decoration:InputDecoration(labelText:strings.text('admin.status')),items:['active','inactive'].map((value)=>DropdownMenuItem(value:value,child:Text(strings.text(value)))).toList(),onChanged:(value){if(value!=null)setState(()=>status=value);}),
 ])),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:Text(strings.text('cancel'))),FilledButton(onPressed:(){if(!form.currentState!.validate())return;FocusManager.instance.primaryFocus?.unfocus();Navigator.pop(context,{for(final entry in fields.entries)entry.key:entry.value.text,'role':role,'status':status});},child:Text(strings.text('control.save')))]);}
}
