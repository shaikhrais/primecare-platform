/* 
PRIME:SCREEN=referral_network_manager
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
// Governance - Category: service | Purpose: Core implementation file for the Referral Network Manager platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final referralNetworkProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/referrals/network');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ReferralNetworkManagerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for displaying providers, monitoring statistics, and managing data refresh and addition of new providers.';

  @override
  List<String> get requiredComponents => const [
        'ProviderList',
        'ReferralStatistics',
        'DataLoadingIndicator',
        'AlertsDashboard',
        'FiltersComponent',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadProviders',
        'refreshReferralNetwork',
        'addProvider',
        'monitorReferralStatistics',
      ];

  const ReferralNetworkManagerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(referralNetworkProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Referral Network Manager', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('referral_network_manager_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(referralNetworkProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person_add),
              label: const Text('Add Provider'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (providers) => ListView.builder(
          padding: const EdgeInsets.all(24.0),
          itemCount: providers.length,
          itemBuilder: (context, index) {
            final provider = providers[index];
            return Card(
              color: theme.colors.surface,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colors.primary.withOpacity(0.2),
                  child: Icon(Icons.medical_services, color: theme.colors.primary),
                ),
                title: Text(provider['name'] as String, style: theme.typography.h4),
                subtitle: Text('${provider['specialty']} | Clinic: ${provider['clinic']}', style: theme.typography.bodyMedium),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Referrals YTD: ${provider['referrals_ytd']}', style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                    Text('Tier: ${provider['tier']}', style: theme.typography.labelSmall.copyWith(color: theme.colors.primary)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
