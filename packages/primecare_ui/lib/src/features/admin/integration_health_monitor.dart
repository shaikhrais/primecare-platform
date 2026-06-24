/* 
PRIME:SCREEN=integration_health_monitor
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
// Governance - Category: service | Purpose: Core implementation file for the Integration Health Monitor platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final integrationHealthProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/integrations/health');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class IntegrationHealthMonitorScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display integration health status, latency metrics, and sync times, along with buttons for refreshing data and viewing logs.';

  @override
  List<String> get requiredComponents => const [
        'IntegrationHealthCard',
        'IntegrationLatencyMetric',
        'IntegrationSyncTime',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshIntegrationHealth',
        'viewIntegrationLogs',
      ];

  const IntegrationHealthMonitorScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(integrationHealthProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Integration Health Monitor',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('integration_health_monitor_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(integrationHealthProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load integration health: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (integrations) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('External Third-Party Service Status', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: integrations.length,
                  itemBuilder: (context, index) {
                    final integration = integrations[index];
                    final isHealthy = integration['status'] == 'healthy';
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor: isHealthy ? theme.colors.success.withOpacity(0.1) : theme.colors.error.withOpacity(0.1),
                          child: Icon(
                            isHealthy ? Icons.link : Icons.link_off,
                            color: isHealthy ? theme.colors.success : theme.colors.error,
                          ),
                        ),
                        title: Text((integration['name'] as String?) ?? 'Unknown Service', style: theme.typography.h4),
                        subtitle: Text('Last sync: ${(integration['lastSync'] as String?) ?? 'N/A'} | Latency: ${integration['latency']}ms'),
                        trailing: OutlinedButton(key: const Key('integration_health_monitor_outlinedbutton_button_1'), 
                          onPressed: () {},
                          child: const Text('View Logs'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
