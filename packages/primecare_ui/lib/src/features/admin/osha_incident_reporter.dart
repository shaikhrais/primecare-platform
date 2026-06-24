/* 
PRIME:SCREEN=osha_incident_reporter
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
// Governance - Category: service | Purpose: Core implementation file for the Osha Incident Reporter platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final oshaIncidentsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/osha-incidents');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class OshaIncidentReporterScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for viewing and filing OSHA incident reports, along with functionality for refreshing data and viewing details, while ensuring responsive design across devices.';

  @override
  List<String> get requiredComponents => const [
        'IncidentList',
        'IncidentDetailView',
        'IncidentForm',
        'NotificationBanner',
        'IncidentFilter',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchIncidents',
        'refreshIncidentList',
        'fileIncidentReport',
        'viewIncidentDetails',
      ];

  const OshaIncidentReporterScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(oshaIncidentsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'OSHA Incident Reporter',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('osha_incident_reporter_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(oshaIncidentsProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('File New Report'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load OSHA incidents: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (incidents) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Workplace Safety Incident Log (Form 300)', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: incidents.length,
                  itemBuilder: (context, index) {
                    final incident = incidents[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: const Icon(Icons.medical_information, size: 32),
                        title: Text('Case No. ${incident['caseNumber']} - ${incident['employeeName']}', style: theme.typography.h4),
                        subtitle: Text('Date: ${incident['date']} | Location: ${incident['location']}'),
                        trailing: OutlinedButton(key: const Key('osha_incident_reporter_outlinedbutton_button_1'), 
                          onPressed: () {},
                          child: const Text('View Form 301'),
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
