/* 
PRIME:SCREEN=protocol_resolution_log
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
// Governance - Category: view | Purpose: UI Screen component rendering the Protocol Resolution Log Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final protocolLogsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/protocols/logs');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ProtocolResolutionLogScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for viewing and managing protocol resolution logs, including functionalities for refreshing data, downloading reports, and handling errors.';

  @override
  List<String> get requiredComponents => const [
        'ProtocolLogTable',
        'LogDetailView',
        'LoadingIndicator',
        'NotificationBanner',
        'SearchFilter',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchProtocolLogs',
        'expandLogDetails',
        'downloadReport',
        'handleLoadingError',
        'filterLogs',
      ];

  const ProtocolResolutionLogScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final logState = ref.watch(protocolLogsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Protocol Resolution & Post-Mortem Log',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('protocol_resolution_log_screen_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(protocolLogsProvider),
          ),
        ],
      ),
      body: logState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load logs: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (logs) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Incident Timeline & After Action Reports', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ExpansionTile(
                        leading: Icon(Icons.history, color: theme.colors.primary),
                        title: Text((log['protocolName'] as String?) ?? 'Unknown Protocol'),
                        subtitle: Text('Resolved: ${(log['resolutionDate'] as String?) ?? 'N/A'}'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Incident Summary', style: theme.typography.h5),
                                const SizedBox(height: 8),
                                Text((log['summary'] as String?) ?? 'No summary provided.'),
                                const SizedBox(height: 16),
                                Text('After Action Items', style: theme.typography.h5),
                                const SizedBox(height: 8),
                                if (log['actionItems'] != null)
                                  ...(log['actionItems'] as List).map((item) => ListTile(
                                    leading: const Icon(Icons.check_box_outline_blank),
                                    title: Text(item as String),
                                  )),
                                const SizedBox(height: 16),
                                ElevatedButton(key: const Key('protocol_resolution_log_screen_elevatedbutton_button_1'), 
                                  onPressed: () {},
                                  child: const Text('Download Full Report PDF'),
                                ),
                              ],
                            ),
                          ),
                        ],
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
