// Layer: 05_UI_PRESENTATION

import 'package:primecare_ui/primecare_ui.dart';

import 'package:primecare_ui/src/components/forms/domain_forms/01_I_create_user_form.dart';
import 'package:primecare_ui/src/components/forms/domain_forms/01_I_password_reset_form.dart';

class UserManagementScreen extends ConsumerStatefulWidget {
  const UserManagementScreen({super.key});

  @override
  ConsumerState<UserManagementScreen> createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState extends ConsumerState<UserManagementScreen> {
  void _showCreateUserForm(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) =>
          Dialog(child: SizedBox(width: 800, child: CreateUserForm())),
    );
  }

  void _showPasswordResetForm(BuildContext context, String userId) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        child: SizedBox(width: 600, child: PasswordResetForm(userId: userId)),
      ),
    );
  }

  void _confirmDelete(BuildContext context, UserModel user) {
    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            LocaleKeys.dashboards_common_labels_delete_user.tr(),
          ),
          content: Text(
            LocaleKeys
                .dashboards_common_labels_are_you_sure_you_want_to_delete___user_name
                .tr(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                LocaleKeys.dashboards_common_labels_cancel.tr(),
              ),
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
      title: LocaleKeys.dashboards_common_labels_user_management.tr(),
      subtitle:
          'Manage roles, offices, and access settings for all PrimeCare personnel.',
      actions: [
        PrimeCareButton(
          onPressed: () => _showCreateUserForm(context),
          text: 'Invite User',
          icon: LucideIcons.userPlus,
          isPrimary: true,
        ),
      ],
      body: Container(
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
              columns: [
                DataColumn(
                  label: Text(LocaleKeys.dashboards_common_labels_user.tr()),
                ),
                DataColumn(
                  label: Text(LocaleKeys.dashboards_common_labels_role.tr()),
                ),
                DataColumn(
                  label: Text(
                    LocaleKeys.dashboards_common_labels_office___department
                        .tr(),
                  ),
                ),
                DataColumn(
                  label: Text(LocaleKeys.dashboards_common_labels_status.tr()),
                ),
                DataColumn(
                  label: Text(LocaleKeys.dashboards_common_labels_actions.tr()),
                ),
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
