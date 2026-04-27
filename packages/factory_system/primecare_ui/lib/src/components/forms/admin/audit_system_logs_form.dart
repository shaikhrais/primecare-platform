import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE

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
                  decoration: InputDecoration(
                    hintText: 'Search resource type...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _onFilterChanged(),
                ),
              ),
              SizedBox(width: 16),
              DropdownButton<String>(
                value: _selectedAction,
                hint: Text(LocaleKeys.dashboards_common_labels_all_actions.tr()),
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
              ? Center(child: CircularProgressIndicator())
              : state.error != null
                  ? Center(child: Text(LocaleKeys.dashboards_common_labels_error____state_error.tr()))
                  : state.logs.isEmpty
                      ? Center(child: Text(LocaleKeys.dashboards_common_labels_no_audit_logs_found.tr()))
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: state.logs.length,
                          separatorBuilder: (_, _) => Divider(),
                          itemBuilder: (context, index) {
                            final log = state.logs[index] as Map<String, dynamic>;
                            final actorData = log['actor'] as Map<String, dynamic>?;
                            final actor = actorData != null 
                                ? actorData['name'] ?? actorData['email'] 
                                : 'System';
                            
                            return AuditLogTile(
                              title: (log['action'] as String?) ?? 'Unknown Action',
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
