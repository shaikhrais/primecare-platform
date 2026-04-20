import 'package:flutter/material.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../components/forms/domain_forms/create_user_form.dart';
import '../../components/forms/domain_forms/password_reset_form.dart';

class UserManagementScreen extends ConsumerStatefulWidget {
  const UserManagementScreen({super.key});

  @override
  ConsumerState<UserManagementScreen> createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState extends ConsumerState<UserManagementScreen> {
  void _showCreateUserForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) =>
          const Dialog(child: SizedBox(width: 800, child: CreateUserForm())),
    );
  }

  void _showPasswordResetForm(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: SizedBox(width: 600, child: PasswordResetForm(userId: userId)),
      ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error,
              ),
              onPressed: () {
                ref.read(userManagementProvider.notifier).deleteUser(user.id);
                Navigator.pop(ctx);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Theme.of(ctx).colorScheme.onError),
              ),
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
        onPressed: () => _showCreateUserForm(context),
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
        child: users.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (err, st) => Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'Error loading users: $err',
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ),
          data: (userList) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.2,
                ),
              ),
              columnSpacing: 40 * layout.scaleFactor,
              columns: const [
                DataColumn(label: Text('User')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Office / Department')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: userList.map((user) {
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
                            color: isActive
                                ? theme.colorScheme.tertiary
                                : theme.colorScheme.onSurfaceVariant,
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
                              LucideIcons.key,
                              size: 18 * layout.scaleFactor,
                              color: theme.colorScheme.primary,
                            ),
                            onPressed: () =>
                                _showPasswordResetForm(context, user.id),
                            tooltip: 'Reset Password',
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
      ),
    );
  }
}
