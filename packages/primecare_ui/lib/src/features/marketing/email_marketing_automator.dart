// Governance - Category: service | Purpose: Core implementation file for the Email Marketing Automator platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final emailJourneysProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/email/journeys');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class EmailMarketingAutomatorScreen extends GovernedConsumerWidget {
  const EmailMarketingAutomatorScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(emailJourneysProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Email Marketing Automator', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('email_marketing_automator_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(emailJourneysProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_task),
              label: const Text('New Journey'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (journeys) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Email Journeys', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: journeys.length,
                  itemBuilder: (context, index) {
                    final journey = journeys[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(journey['name'] as String, style: theme.typography.h4),
                                const SizedBox(height: 4),
                                Text('Audience: ${journey['audience']} | Triggers: ${journey['triggers']}', style: theme.typography.bodyMedium),
                              ],
                            ),
                            Row(
                              children: [
                                _StatPill('Sent', '${journey['sent']}', theme),
                                const SizedBox(width: 8),
                                _StatPill('Open Rate', '${journey['open_rate']}%', theme),
                                const SizedBox(width: 8),
                                _StatPill('CTR', '${journey['ctr']}%', theme),
                                const SizedBox(width: 16),
                                Switch(
                                  value: journey['active'] as bool,
                                  onChanged: (val) {},
                                  activeThumbColor: theme.colors.primary,
                                )
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

  Widget _StatPill(String label, String value, PrimeThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(value, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.primary)),
          Text(label, style: theme.typography.labelSmall.copyWith(color: theme.colors.primary)),
        ],
      ),
    );
  }
}
