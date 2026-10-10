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
  @override
  void initState() {
    super.initState();
    controller = AdminController(widget.request, () { if (mounted) setState(() {}); });
    WidgetsBinding.instance.addPostFrameCallback((_) { if (mounted) controller.load(); });
  }
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
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(24), children: [
    Text(controller.organization.isEmpty ? 'Organization' : controller.organization, style: Theme.of(context).textTheme.headlineSmall),
    Text('${controller.total} users · ${controller.active} active'),
    if (controller.busy) const LinearProgressIndicator(),
    if (controller.error != null) Text(controller.error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
    Wrap(spacing: 12, children: [
      OutlinedButton(onPressed: controller.busy ? null : () => controller.load(pageOffset: controller.offset), child: const Text('Refresh users')),
      FilledButton(onPressed: controller.busy || controller.assignableRoles.isEmpty ? null : () => edit(), child: const Text('Create user')),
    ]),
    if (!controller.busy && controller.error == null && controller.users.isEmpty) const Text('No users on this page.'),
    ...controller.users.map((user) => Card(child: ListTile(title: Text(user.email), subtitle: Text('${user.role} · ${user.status}'), trailing: controller.assignableRoles.contains(user.role) ? IconButton(tooltip: 'Edit ${user.email}', onPressed: controller.busy ? null : () => edit(user), icon: const Icon(Icons.edit)) : const Text('Protected')))),
    Wrap(spacing: 12, children: [
      TextButton(onPressed: controller.busy || controller.offset == 0 ? null : () => controller.load(pageOffset: controller.offset - 25), child: const Text('Previous page')),
      TextButton(onPressed: controller.busy || !controller.hasNext ? null : () => controller.load(pageOffset: controller.offset + 25), child: const Text('Next page')),
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
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.user == null ? 'Create user' : 'Edit user'),
    content: SizedBox(width: 420, child: SingleChildScrollView(child: Form(key: form, child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextFormField(controller: email, decoration: const InputDecoration(labelText: 'User email'), validator: (value) => value == null || !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim()) ? 'Enter a valid email' : null),
      DropdownButtonFormField<String>(initialValue: role, decoration: const InputDecoration(labelText: 'Role'), items: widget.roles.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(), onChanged: (value) { if (value != null) setState(() => role = value); }),
      if (widget.user == null) TextFormField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Initial password'), validator: (value) => (value?.length ?? 0) < 12 ? 'Use at least 12 characters' : null),
      if (widget.user != null) DropdownButtonFormField<String>(initialValue: status, decoration: const InputDecoration(labelText: 'Account status'), items: ['active','inactive'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(), onChanged: (value) { if (value != null) setState(() => status = value); }),
      if (widget.user != null) const Text('Saving revokes this user’s current sessions.'),
    ])))),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: save, child: const Text('Save user'))],
  );
}
