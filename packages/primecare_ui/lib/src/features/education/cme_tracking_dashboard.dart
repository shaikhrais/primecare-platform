// Governance - Category: view | Purpose: UI Screen component rendering the Cme Tracking Dashboard workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final cmeTrackingProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/cme/tracking');
  return response.data as Map<String, dynamic>;
});

class CMETrackingDashboardScreen extends GovernedConsumerWidget {
  const CMETrackingDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(cmeTrackingProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('CME Tracking Dashboard', style: theme.typography.h3),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(cmeTrackingProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_task),
              label: const Text('Log CME Credits'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (cmeData) => Padding(
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
                      _ProgressMetric('Earned Credits', '${cmeData['earned']}', theme),
                      _ProgressMetric('Required Credits', '${cmeData['required']}', theme),
                      _ProgressMetric('Renewal Deadline', '${cmeData['deadline']}', theme),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Recent CME Activities', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: (cmeData['activities'] as List).length,
                  itemBuilder: (context, index) {
                    final activity = cmeData['activities'][index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        tileColor: theme.colors.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        leading: Icon(Icons.school, color: theme.colors.primary),
                        title: Text(activity['course_name'] as String, style: theme.typography.h4),
                        subtitle: Text('Provider: ${activity['provider']} | Date: ${activity['date']}', style: theme.typography.bodyMedium),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text('+${activity['credits']} Credits', style: theme.typography.labelSmall.copyWith(color: Colors.white)),
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

  Widget _ProgressMetric(String label, String value, PrimeThemeData theme) {
    return Column(
      children: [
        Text(value, style: theme.typography.h1.copyWith(color: theme.colors.primary)),
        const SizedBox(height: 8),
        Text(label, style: theme.typography.labelSmall),
      ],
    );
  }
}
