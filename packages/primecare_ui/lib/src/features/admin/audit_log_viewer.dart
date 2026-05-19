import 'package:primecare_ui/primecare_ui.dart';

final auditLogsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/audit-logs');
  return response.data is List 
      ? List<Map<String, dynamic>>.from(response.data as Iterable<dynamic>) 
      : [];
});

class AuditLogViewer extends GovernedConsumerWidget {
  const AuditLogViewer({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(auditLogsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Audit Log Viewer',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: theme.colors.primary),
            onPressed: () {
              // Action to export logs
            },
            tooltip: 'Export Logs (CSV/PDF)',
          ),
        ],
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load audit logs: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (logs) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Transaction Ledger',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Immutable ledger of all system transactions for HIPAA/SOC2 compliance.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              Card(
                color: theme.colors.surface,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Recent Audit Events', style: theme.typography.h4),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search logs...',
                                prefixIcon: const Icon(Icons.search),
                                filled: true,
                                fillColor: theme.colors.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (logs.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(child: Text('No audit logs available.')),
                        )
                      else
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Timestamp')),
                              DataColumn(label: Text('Event Type')),
                              DataColumn(label: Text('User / Actor')),
                              DataColumn(label: Text('IP Address')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Details')),
                            ],
                            rows: logs.map((log) {
                              return DataRow(cells: [
                                DataCell(Text((log['timestamp'] as String?) ?? 'Unknown')),
                                DataCell(Text((log['eventType'] as String?) ?? 'Unknown')),
                                DataCell(Text((log['actor'] as String?) ?? 'System')),
                                DataCell(Text((log['ip'] as String?) ?? '0.0.0.0')),
                                DataCell(Text((log['status'] as String?) ?? 'Success')),
                                DataCell(
                                  TextButton(
                                    onPressed: () {
                                      // Open EventDetailDrawer
                                    },
                                    child: const Text('View Details'),
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
