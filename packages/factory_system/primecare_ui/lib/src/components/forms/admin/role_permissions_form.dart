import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/components/forms/base_form.dart';

class RolePermissionsForm extends ConsumerStatefulWidget {
  RolePermissionsForm({super.key});

  @override
  ConsumerState<RolePermissionsForm> createState() =>
      _RolePermissionsFormState();
}

class _RolePermissionsFormState extends ConsumerState<RolePermissionsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rolePermissionsFormAdapterProvider);
    final adapter = ref.read(rolePermissionsFormAdapterProvider.notifier);

    return BaseForm(
      formKey: _formKey,
      title: LocaleKeys.dashboards_common_labels_role_permissions_matrix.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_manage_granular_access_control_for_system_roles_and_screens
          .tr(),
      onSubmit: () async {
        final sm = ScaffoldMessenger.of(context);
        final success = await adapter.submit();
        if (success && mounted) {
          sm.showSnackBar(
            SnackBar(
              content: Text(
                LocaleKeys
                    .dashboards_common_labels_permissions_updated_successfully
                    .tr(),
              ),
            ),
          );
        }
      },
      isLoading: state.isLoading,
      children: [
        // Role Selection
        DropdownButtonFormField<String>(
          key: ValueKey(state.selectedRoleId),
          initialValue: state.selectedRoleId,
          decoration: const InputDecoration(
            labelText: 'Selected Role',
            border: OutlineInputBorder(),
          ),
          items: state.roles.map((dynamic r) {
            final role = r as Map<String, dynamic>;
            return DropdownMenuItem<String>(
              value: (role['id'] as String?),
              child: Text(role['name'] as String),
            );
          }).toList(),
          onChanged: (roleId) {
            if (roleId != null) {
              adapter.loadPermissions(roleId);
            }
          },
        ),
        const SizedBox(height: 24),

        if (state.selectedRoleId != null) ...[
          const Text(
            'Access Matrix',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.permissions.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final route = state.permissions.keys.elementAt(index);
              final perm = state.permissions[route]!;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            perm.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            route,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text(
                          'Read',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: perm.canRead,
                        dense: true,
                        onChanged: (val) =>
                            adapter.toggleRead(route, val ?? false),
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text(
                          'Write',
                          style: TextStyle(fontSize: 14),
                        ),
                        value: perm.canWrite,
                        dense: true,
                        onChanged: (val) =>
                            adapter.toggleWrite(route, val ?? false),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ] else
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                LocaleKeys
                    .dashboards_common_labels_select_a_role_to_modify_permissions
                    .tr(),
              ),
            ),
          ),
      ],
    );
  }
}
