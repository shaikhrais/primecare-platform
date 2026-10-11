import 'admin_account_filters.dart';
import 'platform_admin_screen.dart';
import '../layout/base_primecare_layout.dart';
import 'admin_tasks_screen.dart';
import 'admin_audit_screen.dart';
import '../localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import '../screens/base_primecare_screen.dart';
import 'admin_controller.dart';

/// Thin inherited screen: business operations stay in BaseAdminWorkflow.
class AdminScreen extends BasePrimecareScreen {
  final AuthorizedRequest request;
  const AdminScreen({super.key, required this.request});
  @override
  String get title => 'Admin workspace';
  @override
  String get titleKey => 'admin.workspace';
  @override
  Widget buildContent(BuildContext context) => _AdminWorkspace(request: request);
}

class _AdminWorkspace extends StatefulWidget {
  final AuthorizedRequest request;
  const _AdminWorkspace({required this.request});
  @override
  State<_AdminWorkspace> createState() => _AdminWorkspaceState();
}
class _AdminWorkspaceState extends State<_AdminWorkspace> {
  late final AdminController controller;
  final search = TextEditingController();
  AppStrings get strings => AppStrings.of(context);
  @override
  void initState() {
    super.initState();
    controller = AdminController(widget.request, () { if (mounted) setState(() {}); });
    WidgetsBinding.instance.addPostFrameCallback((_) { if (mounted) controller.load(); });
  }
  @override
  void dispose() { search.dispose(); super.dispose(); }
  Future<void> edit([AdminUser? user]) async {
    final result = await showDialog<_UserEdit>(
      context: context,
      builder: (_) => _AdminUserEditor(user: user, roles: controller.assignableRoles),
    );
    if (result == null || !mounted) return;
    if (user == null) { await controller.create(result.email,result.role,result.password); }
    else { await controller.update(user,result.email,result.role,result.status); }
  }
  @override
  Widget build(BuildContext context) => ListView(padding: PrimecareLayoutData.of(context).pageInsets, children: [
    Text(controller.organization.isEmpty ? strings.text('admin.organization') : controller.organization, style: Theme.of(context).textTheme.headlineSmall),
    Text(strings.text(controller.search.isEmpty && controller.accountStatus.isEmpty ? 'admin.counts' : 'admin.matchingCounts', {'total': controller.total, 'active': controller.active})),
    if (controller.busy) const LinearProgressIndicator(),
    if (controller.error != null) Text(strings.text(controller.errorCode ?? 'error.unavailable'), style: TextStyle(color: Theme.of(context).colorScheme.error)),
    TextButton(onPressed:controller.busy?null:()=>Navigator.push(context,MaterialPageRoute<void>(builder:(_)=>PlatformAdminScreen(request:widget.request))),child:Text(strings.text('control.title'))),
    TextButton(onPressed:controller.busy||controller.tasks.isEmpty?null:()=>Navigator.push(context,MaterialPageRoute<void>(builder:(_)=>AdminTasksScreen(tasks:controller.tasks))),child:Text(strings.text('admin.tasks'))),
    TextButton(onPressed: () => Navigator.push(context,MaterialPageRoute<void>(builder: (_) => AdminAuditScreen(request:widget.request))),child:Text(strings.text('audit.title'))),
    AdminAccountFilters(search:search,busy:controller.busy,status:controller.accountStatus,revision:controller.stateRevision,onSearch:()=>controller.load(query:search.text),onStatus:(value)=>controller.load(statusFilter:value),onClear:(){search.clear();controller.load(query:'');}),
    Wrap(spacing: 12, children: [
      OutlinedButton(onPressed: controller.busy ? null : () => controller.load(pageOffset: controller.offset), child: Text(strings.text('admin.refresh'))),
      FilledButton(onPressed: controller.busy || controller.assignableRoles.isEmpty ? null : () => edit(), child: Text(strings.text('admin.create'))),
    ]),
    if (!controller.busy && controller.error == null && controller.users.isEmpty) Text(strings.text('admin.empty')),
    ...controller.users.map((user) => Card(child: Semantics(container: true, explicitChildNodes: true, child: Padding(
      padding: const EdgeInsets.all(16),
      child: PrimecareDetailLayout(
        details: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(user.email), Text('${strings.role(user.role)} · ${strings.text(user.status)}')]),
        actions: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
        IconButton(tooltip:strings.text('audit.viewAccount',{'email':user.email}),onPressed:controller.busy?null:()=>Navigator.push(context,MaterialPageRoute<void>(builder:(_)=>AdminAuditScreen(request:widget.request,account:user))),icon:const Icon(Icons.history)),
        if (controller.assignableRoles.contains(user.role)) IconButton(tooltip: strings.text('admin.editAccount', {'email': user.email}), onPressed: controller.busy ? null : () => edit(user), icon: const Icon(Icons.edit)) else Text(strings.text('admin.protected')),
      ]),
      ),
    )))),
    Wrap(spacing: 12, children: [
      TextButton(onPressed: controller.busy || controller.offset == 0 ? null : () => controller.load(pageOffset: controller.offset - 25), child: Text(strings.text('previous'))),
      TextButton(onPressed: controller.busy || !controller.hasNext ? null : () => controller.load(pageOffset: controller.offset + 25), child: Text(strings.text('next'))),
    ]),
  ]);
}

class _UserEdit {
  final String email, role, password, status;
  const _UserEdit(this.email,this.role,this.password,this.status);
}
class _AdminUserEditor extends StatefulWidget {
  final AdminUser? user;
  final List<String> roles;
  const _AdminUserEditor({required this.user,required this.roles});
  @override
  State<_AdminUserEditor> createState() => _AdminUserEditorState();
}
class _AdminUserEditorState extends State<_AdminUserEditor> {
  final form = GlobalKey<FormState>();
  AppStrings get strings => AppStrings.of(context);
  late final TextEditingController email;
  final password = TextEditingController();
  late String role, status;
  @override
  void initState() {
    super.initState();
    email = TextEditingController(text: widget.user?.email ?? '');
    role = widget.user?.role ?? widget.roles.first;
    status = widget.user?.status ?? 'active';
  }
  @override
  void dispose() { email.dispose(); password.dispose(); super.dispose(); }
  void save() {
    if (!form.currentState!.validate()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pop(context,_UserEdit(email.text,role,password.text,status));
  }
  @override
  Widget build(BuildContext context) => PrimecareFormDialog(
    title: Text(widget.user == null ? strings.text('admin.create') : strings.text('admin.edit')),
    content: Form(key: form, child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextFormField(controller: email, decoration: InputDecoration(labelText: strings.text('admin.email')), validator: (value) => value == null || !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim()) ? strings.text('error.email') : null),
      DropdownButtonFormField<String>(isExpanded: true, initialValue: role, decoration: InputDecoration(labelText: strings.text('admin.role')), items: widget.roles.map((value) => DropdownMenuItem(value: value, child: Text(strings.role(value),overflow:TextOverflow.ellipsis))).toList(), onChanged: (value) { if (value != null) setState(() => role = value); }),
      if (widget.user == null) TextFormField(controller: password, obscureText: true, decoration: InputDecoration(labelText: strings.text('admin.password')), validator: (value) => (value?.length ?? 0) < 12 ? strings.text('error.minimumPassword') : null),
      if (widget.user != null) DropdownButtonFormField<String>(isExpanded: true, initialValue: status, decoration: InputDecoration(labelText: strings.text('admin.status')), items: ['active','inactive'].map((value) => DropdownMenuItem(value: value, child: Text(strings.text(value)))).toList(), onChanged: (value) { if (value != null) setState(() => status = value); }),
      if (widget.user != null) Text(strings.text('admin.revokes')),
    ])),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(strings.text('cancel'))), FilledButton(onPressed: save, child: Text(strings.text('admin.save')))],
  );
}
