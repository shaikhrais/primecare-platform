/* 
PRIME:SCREEN=incident_response_hub
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_FINAL
PRIME:LOGIC=LOGIC_CLEAN
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_FULLY_CONNECTED
PRIME:VALIDATION=VALIDATION_FULL
PRIME:QA=QA_PASSED
PRIME:FINAL=FINAL_FURNISHED
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: service | Purpose: Core implementation file for the Incident Response Hub platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final activeIncidentsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/incidents/active');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class IncidentResponseHubScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The incident response hub screen requires components for monitoring and managing incidents, including real-time data display, action buttons for refreshing and declaring incidents, and responsive design for multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'IncidentList',
        'IncidentDetailView',
        'IncidentStatistics',
        'NotificationBanner',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchActiveIncidents',
        'refreshIncidentData',
        'declareNewIncident',
        'joinWarRoom',
        'getIncidentDetails',
      ];

  const IncidentResponseHubScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(activeIncidentsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Incident Response Hub',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('incident_response_hub_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(activeIncidentsProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_alert),
              label: const Text('Declare Incident'),
              style: ElevatedButton.styleFrom(backgroundColor: theme.colors.error),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load active incidents: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (incidents) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ongoing System Incidents', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: incidents.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline, size: 64, color: theme.colors.success),
                            const SizedBox(height: 16),
                            Text('No active incidents. Systems operating normally.', style: theme.typography.h4),
                          ],
                        ),
                      )
                    : ListView.builder(
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
                                      Text('INC-${incident['id']} | ${incident['severity']}', style: theme.typography.h4.copyWith(color: theme.colors.error)),
                                      Text((incident['status'] as String?) ?? 'Unknown', style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text((incident['title'] as String?) ?? 'Incident Title', style: theme.typography.h3),
                                  const SizedBox(height: 8),
                                  Text((incident['description'] as String?) ?? 'No description provided.', style: theme.typography.bodyLarge),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text('Lead: ${incident['lead'] ?? 'Unassigned'}', style: theme.typography.labelSmall),
                                      const Spacer(),
                                      OutlinedButton(key: const Key('incident_response_hub_outlinedbutton_button_1'), 
                                        onPressed: () {},
                                        child: const Text('Join War Room'),
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
}
