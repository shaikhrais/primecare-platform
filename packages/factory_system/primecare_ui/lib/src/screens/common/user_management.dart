import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UserManagementScreen extends ConsumerStatefulWidget {
  const UserManagementScreen({super.key});

  @override
  ConsumerState<UserManagementScreen> createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState extends ConsumerState<UserManagementScreen> {
  void _openUserModal(BuildContext context, {UserModel? user}) {
    final nameController = TextEditingController(text: user?.name ?? '');
    final emailController = TextEditingController(text: user?.email ?? '');
    
    String selectedRole = user?.role ?? 'PSW';
    String selectedOffice = user?.office ?? 'Global';

    final roles = ['Super Admin', 'Admin', 'CEO', 'CFO', 'COO', 'Doctor', 'Nurse', 'PSW', 'Manager', 'Provider'];
    if (!roles.contains(selectedRole)) roles.add(selectedRole);

    final offices = ['Global', 'Toronto West', 'Toronto East', 'Vancouver South', 'Remote', 'Montreal North', 'London Care Center'];
    if (!offices.contains(selectedOffice)) offices.add(selectedOffice);

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(user == null ? 'Invite User' : 'Edit User'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email Address'),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: selectedRole,
                      decoration: const InputDecoration(labelText: 'Role'),
                      items: roles.map((role) {
                        return DropdownMenuItem(value: role, child: Text(role));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => selectedRole = val);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: selectedOffice,
                      decoration: const InputDecoration(labelText: 'Office/Department'),
                      items: offices.map((office) {
                        return DropdownMenuItem(value: office, child: Text(office));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => selectedOffice = val);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final notifier = ref.read(userManagementProvider.notifier);
                    if (user == null) {
                      notifier.addUser(UserModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: nameController.text,
                        email: emailController.text,
                        role: selectedRole,
                        status: 'Active',
                        office: selectedOffice,
                      ));
                    } else {
                      notifier.updateUser(
                        user.id,
                        user.copyWith(
                          name: nameController.text,
                          email: emailController.text,
                          role: selectedRole,
                          office: selectedOffice,
                        ),
                      );
                    }
                    Navigator.pop(ctx);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text('Are you sure you want to delete ${user.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
              onPressed: () {
                ref.read(userManagementProvider.notifier).deleteUser(user.id);
                Navigator.pop(ctx);
              },
              child: Text('Delete', style: TextStyle(color: Theme.of(ctx).colorScheme.onError)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);
    final users = ref.watch(userManagementProvider);

    return PageTemplate(
      title: 'User Management',
      subtitle:
          'Manage roles, offices, and access settings for all PrimeCare personnel.',
      actionButton: ElevatedButton.icon(
        onPressed: () => _openUserModal(context),
        icon: const Icon(LucideIcons.userPlus, size: 18),
        label: const Text('Invite User'),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(
            horizontal: 16 * layout.scaleFactor,
            vertical: 12 * layout.scaleFactor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8 * layout.scaleFactor),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(12 * layout.scaleFactor),
        ),
        clipBehavior: Clip.antiAlias,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
            ),
            columnSpacing: 40 * layout.scaleFactor,
            columns: const [
              DataColumn(label: Text('User')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Office / Department')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: users.map((user) {
              final isActive = user.status == 'Active';
              return DataRow(
                cells: [
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14 * layout.scaleFactor,
                          ),
                        ),
                        Text(
                          user.email,
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontSize: 12 * layout.scaleFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8 * layout.scaleFactor,
                        vertical: 4 * layout.scaleFactor,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          6 * layout.scaleFactor,
                        ),
                      ),
                      child: Text(
                        user.role,
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontSize: 12 * layout.scaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataCell(Text(user.office)),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          color: isActive ? theme.colorScheme.tertiary : theme.colorScheme.onSurfaceVariant,
                          size: 10 * layout.scaleFactor,
                        ),
                        SizedBox(width: 6 * layout.scaleFactor),
                        Text(user.status),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            LucideIcons.edit2,
                            size: 18 * layout.scaleFactor,
                            color: theme.colorScheme.primary,
                          ),
                          onPressed: () => _openUserModal(context, user: user),
                          tooltip: 'Edit User',
                        ),
                        IconButton(
                          icon: Icon(
                            isActive
                                ? LucideIcons.userX
                                : LucideIcons.userCheck,
                            size: 18 * layout.scaleFactor,
                            color: isActive
                                ? theme.colorScheme.error
                                : theme.colorScheme.tertiary,
                          ),
                          onPressed: () => ref
                              .read(userManagementProvider.notifier)
                              .toggleStatus(user.id),
                          tooltip: isActive ? 'Deactivate' : 'Activate',
                        ),
                        IconButton(
                          icon: Icon(
                            LucideIcons.trash2,
                            size: 18 * layout.scaleFactor,
                            color: theme.colorScheme.error,
                          ),
                          onPressed: () => _confirmDelete(context, user),
                          tooltip: 'Delete User',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
