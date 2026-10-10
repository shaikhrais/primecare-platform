import 'package:flutter/material.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_models/primecare_models.dart';
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
    final email = TextEditingController(text: user?.email ?? '');
    final password = TextEditingController();
    var role = user?.role ?? controller.assignableRoles.first;
    var status = user?.status ?? 'active';
    final form = GlobalKey<FormState>();
    final accepted = await showDialog<bool>(context: context, builder: (context) => StatefulBuilder(builder: (context, update) => AlertDialog(
      title: Text(user == null ? 'Create user' : 'Edit user'),
      content: SizedBox(width: 420, child: SingleChildScrollView(child: Form(key: form, child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextFormField(controller: email, decoration: const InputDecoration(labelText: 'User email'), validator: (value) => value == null || !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim()) ? 'Enter a valid email' : null),
        DropdownButtonFormField<String>(initialValue: role, decoration: const InputDecoration(labelText: 'Role'), items: controller.assignableRoles.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(), onChanged: (value) { if (value != null) update(() => role = value); }),
        if (user == null) TextFormField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Initial password'), validator: (value) => (value?.length ?? 0) < 12 ? 'Use at least 12 characters' : null),
        if (user != null) DropdownButtonFormField<String>(initialValue: status, decoration: const InputDecoration(labelText: 'Account status'), items: ['active','inactive'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(), onChanged: (value) { if (value != null) update(() => status = value); }),
        if (user != null) const Text('Saving revokes this user’s current sessions.'),
      ])))),
      actions: [TextButton(onPressed: () => Navigator.pop(context,false), child: const Text('Cancel')), FilledButton(onPressed: () { if (form.currentState!.validate()) Navigator.pop(context,true); }, child: const Text('Save user'))],
    )));
    final emailValue = email.text, passwordValue = password.text;
    // Dialog route animations can still reference their controllers until the next frame.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    email.dispose(); password.dispose();
    if (accepted != true || !mounted) return;
    if (user == null) { await controller.create(emailValue,role,passwordValue); }
    else { await controller.update(user,emailValue,role,status); }
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
