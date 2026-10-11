import '../layout/base_primecare_layout.dart';
import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import '../localization/app_localizations.dart';
import '../screens/base_primecare_screen.dart';
import 'admin_controller.dart';

class AdminAuditScreen extends BasePrimecareScreen {
  final AuthorizedRequest request;
  final AdminUser? account;
  const AdminAuditScreen({super.key,required this.request,this.account});
  @override
  String get title => 'Audit history';
  @override
  String get titleKey => 'audit.title';
  @override
  Widget buildContent(BuildContext context) => _AuditHistory(request:request,account:account);
}
class _AuditHistory extends StatefulWidget {
  final AuthorizedRequest request;
  final AdminUser? account;
  const _AuditHistory({required this.request,this.account});
  @override
  State<_AuditHistory> createState() => _AuditHistoryState();
}
class _AuditHistoryState extends State<_AuditHistory> {
  late final AdminController controller;
  @override
  void initState() {
    super.initState();controller=AdminController(widget.request,(){if(mounted)setState((){});});
    WidgetsBinding.instance.addPostFrameCallback((_){if(mounted)controller.loadAudit(userId:widget.account?.id ?? '');});
  }
  @override
  Widget build(BuildContext context) {
    final strings=AppStrings.of(context);
    String state(Map<String,String> data) => data.entries.map((entry) => switch(entry.key){'role'=>strings.role(entry.value),'status'=>['active','inactive'].contains(entry.value)?strings.text(entry.value):entry.value,_=>entry.value}).join(' · ');
    return ListView(padding:PrimecareLayoutData.of(context).pageInsets,children:[
      if(controller.auditUserId.isNotEmpty && widget.account != null)Text(strings.text('audit.accountHistory',{'email':widget.account!.email})),
      if(controller.auditUserId.isNotEmpty)TextButton(onPressed:controller.busy?null:()=>controller.loadAudit(userId:''),child:Text(strings.text('audit.clearFilter'))),
      Text(strings.text('audit.count',{'total':controller.auditTotal})),
      if(controller.busy)const LinearProgressIndicator(),
      if(controller.error!=null)Text(strings.text(controller.errorCode??'error.unavailable')),
      OutlinedButton(onPressed:controller.busy?null:()=>controller.loadAudit(pageOffset:controller.auditOffset),child:Text(strings.text('audit.refresh'))),
      if(!controller.busy&&controller.error==null&&controller.events.isEmpty)Text(strings.text('audit.empty')),
      ...controller.events.map((event)=>Card(child:Semantics(container:true,explicitChildNodes:true,child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(strings.text('audit.${event.action}')),
        Text('${MaterialLocalizations.of(context).formatMediumDate(event.createdAt.toLocal())} ${TimeOfDay.fromDateTime(event.createdAt.toLocal()).format(context)}'),
        Text(strings.text('audit.actor',{'id':event.actor})),Text(strings.text('audit.target',{'id':event.target})),
        if(event.before.isNotEmpty)Text(strings.text('audit.before',{'state':state(event.before)})),
        if(event.after.isNotEmpty)Text(strings.text('audit.after',{'state':state(event.after)})),
      ]))))),
      Wrap(children:[
        TextButton(onPressed:controller.busy||controller.auditOffset==0?null:()=>controller.loadAudit(pageOffset:controller.auditOffset-25),child:Text(strings.text('previous'))),
        TextButton(onPressed:controller.busy||!controller.hasNextAudit?null:()=>controller.loadAudit(pageOffset:controller.auditOffset+25),child:Text(strings.text('next'))),
      ]),
    ]);
  }
}
