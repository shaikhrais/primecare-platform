// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'role_permissions_form_adapter.dart';
import '../base_form.dart';

class RolePermissionsForm extends ConsumerStatefulWidget {
  const RolePermissionsForm({super.key});

  @override
  ConsumerState<RolePermissionsForm> createState() => _RolePermissionsFormState();
}

class _RolePermissionsFormState extends ConsumerState<RolePermissionsForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rolePermissionsFormAdapterProvider);
    final adapter = ref.read(rolePermissionsFormAdapterProvider.notifier);

    return BaseForm(
      formKey: _formKey,
      title: 'Role Permissions Matrix',
      subtitle: 'Manage granular access control for system roles and screens.',
      onSubmit: () async {
        final sm = ScaffoldMessenger.of(context);
        final success = await adapter.submit();
        if (success && mounted) {
          sm.showSnackBar(
            const SnackBar(content: Text('Permissions updated successfully.')),
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
          items: state.roles.map((role) {
            return DropdownMenuItem<String>(
              value: role['id'],
              child: Text(role['name']),
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
                        title: const Text('Read', style: TextStyle(fontSize: 14)),
                        value: perm.canRead,
                        dense: true,
                        onChanged: (val) => adapter.toggleRead(route, val ?? false),
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text('Write', style: TextStyle(fontSize: 14)),
                        value: perm.canWrite,
                        dense: true,
                        onChanged: (val) => adapter.toggleWrite(route, val ?? false),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ] else
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('Select a role to modify permissions'),
            ),
          ),
      ],
    );
  }
}
