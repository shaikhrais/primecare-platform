// Governance - Category: service | Purpose: Core implementation file for the System Event Monitor platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final systemEventsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/system-events');
  return response.data is Map<String, dynamic> 
      ? response.data as Map<String, dynamic>
      : {};
});

class SystemEventMonitor extends GovernedConsumerWidget {
  const SystemEventMonitor({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(systemEventsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'System Event Monitor',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('system_event_monitor_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () {
              ref.invalidate(systemEventsProvider);
            },
            tooltip: 'Refresh Queues',
          ),
        ],
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load system events: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (eventData) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Async Event & Webhook Monitoring',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Real-time monitoring of webhook events, message queues, and Dead Letter Queues (DLQ).',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 400,
                maxItemWidth: 600,
                spacing: 16.0,
                children: [
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Message Queue Throughput', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          Container(
                            height: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Queue Graph Component Placeholder'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dead Letter Queue (DLQ) Manager', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          if (eventData['dlq'] == null || (eventData['dlq'] as List).isEmpty)
                            const Text('No messages in DLQ. System is healthy.')
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: (eventData['dlq'] as List).length,
                              itemBuilder: (context, index) {
                                final dlqItem = (eventData['dlq'] as List)[index];
                                return ListTile(
                                  leading: Icon(Icons.error_outline, color: theme.colors.error),
                                  title: Text(dlqItem['eventType'] as String? ?? 'Unknown Event', style: theme.typography.bodyLarge),
                                  subtitle: Text('Retries: ${dlqItem['retryCount'] ?? 0}', style: theme.typography.bodyMedium),
                                  trailing: IconButton(key: const Key('system_event_monitor_iconbutton_button_2'), 
                                    icon: const Icon(Icons.replay),
                                    onPressed: () {},
                                    tooltip: 'Retry Event',
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                      Text('Recent Events Log', style: theme.typography.h4),
                      const SizedBox(height: 16),
                      if (eventData['recentEvents'] == null || (eventData['recentEvents'] as List).isEmpty)
                        const Text('No recent events.')
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (eventData['recentEvents'] as List).length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final eventItem = (eventData['recentEvents'] as List)[index];
                            return ListTile(
                              leading: Icon(Icons.webhook, color: theme.colors.primary),
                              title: Text(eventItem['type'] as String? ?? 'Webhook', style: theme.typography.bodyLarge),
                              subtitle: Text(eventItem['status'] as String? ?? 'Processed', style: theme.typography.bodyMedium),
                              trailing: Text(eventItem['time'] as String? ?? 'Now', style: theme.typography.labelSmall),
                            );
                          },
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
