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
  // Temporary mocked user list for demonstration. This can be integrated with provider later.
  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Mohammed',
      'email': 'itpro.mohammed@gmail.com',
      'role': 'Super Admin',
      'status': 'Active',
      'office': 'Global',
    },
    {
      'name': 'Sarah CEO',
      'email': 'ceo@primecare.com',
      'role': 'CEO',
      'status': 'Active',
      'office': 'Global',
    },
    {
      'name': 'Alex Clinical',
      'email': 'clinician@primecare.com',
      'role': 'PSW',
      'status': 'Inactive',
      'office': 'Toronto West',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    return PageTemplate(
      title: 'User Management',
      subtitle:
          'Manage roles, offices, and access settings for all PrimeCare personnel.',
      actionButton: ElevatedButton.icon(
        onPressed: () {
          // Invite user modal trigger
        },
        icon: const Icon(LucideIcons.userPlus, size: 18),
        label: const Text('Invite User'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
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
            rows: _users.map((user) {
              final isActive = user['status'] == 'Active';
              return DataRow(
                cells: [
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14 * layout.scaleFactor,
                          ),
                        ),
                        Text(
                          user['email'],
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
                        user['role'],
                        style: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontSize: 12 * layout.scaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataCell(Text(user['office'])),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          color: isActive ? Colors.green : Colors.grey,
                          size: 10 * layout.scaleFactor,
                        ),
                        SizedBox(width: 6 * layout.scaleFactor),
                        Text(user['status']),
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
                          onPressed: () {},
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
                                : Colors.green,
                          ),
                          onPressed: () {},
                          tooltip: isActive ? 'Deactivate' : 'Activate',
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
