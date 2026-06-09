// Governance - Category: service | Purpose: Core implementation file for the Consent Management Console platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final consentsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/consents');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ConsentManagementConsoleScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display consent records, summary statistics, and trends, along with buttons for refreshing data and viewing details.';

  @override
  List<String> get requiredComponents => const [
        'ConsentRecordList',
        'ConsentSummaryCard',
        'ConsentTrendChart',
        'ErrorAlert',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadConsentRecords',
        'refreshConsentRecords',
        'viewConsentDetails',
      ];

  const ConsentManagementConsoleScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(consentsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Consent Management Console',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('consent_management_console_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(consentsProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load consent records: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (consents) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Patient Consent & Preference Records', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: consents.length,
                  itemBuilder: (context, index) {
                    final consent = consents[index];
                    final isRevoked = consent['status'] == 'revoked';
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: Icon(
                          isRevoked ? Icons.cancel_presentation : Icons.assignment_turned_in,
                          color: isRevoked ? theme.colors.error : theme.colors.success,
                          size: 32,
                        ),
                        title: Text('Patient: ${consent['patientName']} (ID: ${consent['patientId']})', style: theme.typography.h4),
                        subtitle: Text('Type: ${consent['type']} | Status: ${consent['status']} | Date: ${consent['updatedAt']}'),
                        trailing: OutlinedButton(key: const Key('consent_management_console_outlinedbutton_button_1'), 
                          onPressed: () {},
                          child: const Text('View Details'),
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
