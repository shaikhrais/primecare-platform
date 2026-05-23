// Governance - Category: service | Purpose: Core implementation file for the Security Incident Logger platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final securityIncidentsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/security-incidents');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class SecurityIncidentLoggerScreen extends GovernedConsumerWidget {
  const SecurityIncidentLoggerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(securityIncidentsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Security Incident Logger',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(securityIncidentsProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Log Incident'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load security incidents: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (incidents) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reported Security Events', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: incidents.length,
                  itemBuilder: (context, index) {
                    final incident = incidents[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text((incident['title'] as String?) ?? 'Security Incident', style: theme.typography.h4),
                                Chip(
                                  label: Text((incident['severity'] as String?) ?? 'Unknown'),
                                  backgroundColor: _getSeverityColor(theme, incident['severity'] as String?),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text((incident['description'] as String?) ?? 'No description provided.', style: theme.typography.bodyLarge),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text('Logged: ${incident['timestamp']}', style: theme.typography.labelSmall.copyWith(color: theme.colors.textSecondary)),
                                const Spacer(),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: const Text('Update Status'),
                                ),
                              ],
                            ),
                          ],
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

  Color _getSeverityColor(PrimeThemeData theme, String? severity) {
    switch (severity?.toLowerCase()) {
      case 'critical':
      case 'high':
        return theme.colors.error.withOpacity(0.2);
      case 'medium':
        return theme.colors.warning.withOpacity(0.2);
      case 'low':
      default:
        return theme.colors.success.withOpacity(0.2);
    }
  }
}
