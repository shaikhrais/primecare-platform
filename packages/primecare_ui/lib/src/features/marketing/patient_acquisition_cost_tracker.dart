// Governance - Category: service | Purpose: Core implementation file for the Patient Acquisition Cost Tracker platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final acquisitionCostProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/cac/tracker');
  return response.data as Map<String, dynamic>;
});

class PatientAcquisitionCostTrackerScreen extends GovernedConsumerWidget {
  const PatientAcquisitionCostTrackerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(acquisitionCostProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Patient Acquisition Cost (CAC)', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('patient_acquisition_cost_tracker_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(acquisitionCostProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (cacData) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: theme.colors.primary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _MetricCard('Overall CAC', '\$${cacData['overall_cac']}', theme),
                      _MetricCard('Total Spend', '\$${cacData['total_spend']}', theme),
                      _MetricCard('New Patients', '${cacData['new_patients']}', theme),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('CAC by Channel', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: (cacData['channels'] as List).length,
                  itemBuilder: (context, index) {
                    final channel = cacData['channels'][index];
                    return ListTile(
                      tileColor: theme.colors.surface,
                      title: Text(channel['name'] as String, style: theme.typography.h4),
                      trailing: Text('\$${channel['cac']}', style: theme.typography.h3.copyWith(color: theme.colors.primary)),
                      subtitle: Text('Spend: \$${channel['spend']} | Patients: ${channel['patients']}', style: theme.typography.bodyMedium),
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

  Widget _MetricCard(String label, String value, PrimeThemeData theme) {
    return Column(
      children: [
        Text(value, style: theme.typography.h1.copyWith(color: theme.colors.primary)),
        const SizedBox(height: 8),
        Text(label, style: theme.typography.labelSmall),
      ],
    );
  }
}
