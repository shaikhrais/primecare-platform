// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/components/01_I_audit_log_tile.dart';
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:primecare_ui/src/components/forms/admin/01_I_audit_system_logs_form_adapter.dart';

class AuditSystemLogsForm extends ConsumerStatefulWidget {
  const AuditSystemLogsForm({super.key});

  @override
  ConsumerState<AuditSystemLogsForm> createState() => _AuditSystemLogsFormState();
}

class _AuditSystemLogsFormState extends ConsumerState<AuditSystemLogsForm> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedAction;
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(auditSystemLogsFormAdapterProvider.notifier).loadLogs();
    });
  }

  void _onFilterChanged() {
    ref.read(auditSystemLogsFormAdapterProvider.notifier).loadLogs(
      action: _selectedAction,
      resourceType: _searchController.text.isEmpty ? null : _searchController.text,
    );
  }

  IconData _getIconForAction(String action) {
    if (action.contains('VOID')) return Icons.undo;
    if (action.contains('CREATE')) return Icons.add_circle_outline;
    if (action.contains('UPDATE')) return Icons.edit_note;
    if (action.contains('DELETE')) return Icons.delete_outline;
    if (action.contains('PERMISSION')) return Icons.security;
    return Icons.history;
  }

  Color _getColorForAction(String action) {
    if (action.contains('VOID')) return Colors.orange;
    if (action.contains('CREATE')) return Colors.green;
    if (action.contains('DELETE')) return Colors.red;
    if (action.contains('PERMISSION')) return Colors.blue;
    return PrimeCareColors.slate600;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(auditSystemLogsFormAdapterProvider);

    return Column(
      children: [
        // Filter Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search resource type...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _onFilterChanged(),
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: _selectedAction,
                hint: const Text('All Actions'),
                items: ['VOID_TRANSACTION', 'UPDATE_PERMISSIONS', 'LOGIN', 'LOGOUT']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() => _selectedAction = val);
                  _onFilterChanged();
                },
              ),
            ],
          ),
        ),

        // Logs List
        Expanded(
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.error != null
                  ? Center(child: Text('Error: ${state.error}'))
                  : state.logs.isEmpty
                      ? const Center(child: Text('No audit logs found.'))
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.logs.length,
                          separatorBuilder: (_, _) => const Divider(),
                          itemBuilder: (context, index) {
                            final log = state.logs[index] as Map<String, dynamic>;
                            final actorData = log['actor'] as Map<String, dynamic>?;
                            final actor = actorData != null 
                                ? actorData['name'] ?? actorData['email'] 
                                : 'System';
                            
                            return AuditLogTile(title: (log['action'] as String?) ?? 'Unknown Action',
                              subtitle: '$actor performed ${log['action']} on ${log['resourceType']}',
                              timestamp: log['createdAt']?.toString().split('T').first ?? '',
                              icon: _getIconForAction((log['action'] as String?) ?? ''),
                              iconColor: _getColorForAction((log['action'] as String?) ?? ''),
                            );
                          },
                        ),
        ),
      ],
    );
  }
}
