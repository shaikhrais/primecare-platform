/* 
PRIME:SCREEN=hipaa_audit_dashboard
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_QUERY_READY
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=60
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the Hipaa Audit Dashboard workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final hipaaAuditProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/hipaa-audit');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class HipaaAuditDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display PHI access logs, buttons for refreshing and exporting logs, and functions to handle these actions.';

  @override
  List<String> get requiredComponents => const [
        'PHIAccessLogList',
        'ViolationHighlight',
        'LoadingIndicator',
        'ErrorMessage',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshAuditLogs',
        'exportAuditReport',
      ];

  const HipaaAuditDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(hipaaAuditProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'HIPAA Audit Dashboard',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('hipaa_audit_dashboard_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(hipaaAuditProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Export Report'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load audit logs: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (logs) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PHI Access Logs', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: Card(
                  color: theme.colors.surface,
                  child: ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      final isViolation = log['violationFlag'] == true;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isViolation ? theme.colors.error.withOpacity(0.1) : theme.colors.primary.withOpacity(0.1),
                          child: Icon(
                            isViolation ? Icons.warning : Icons.security,
                            color: isViolation ? theme.colors.error : theme.colors.primary,
                          ),
                        ),
                        title: Text('User: ${log['userId']} accessed PHI of Patient: ${log['patientId']}', style: theme.typography.h4),
                        subtitle: Text('Action: ${log['action']} | Resource: ${log['resource']} | Time: ${log['timestamp']}'),
                        trailing: isViolation ? const Chip(label: Text('Violation'), backgroundColor: Colors.redAccent) : null,
                      );
                    },
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
