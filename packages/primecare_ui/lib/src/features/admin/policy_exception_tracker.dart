// Governance - Category: service | Purpose: Core implementation file for the Policy Exception Tracker platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final policyExceptionsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/policy-exceptions');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class PolicyExceptionTrackerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display and manage policy exemptions, including functionality for refreshing, revoking, and extending exemptions, along with necessary API integrations.';

  @override
  List<String> get requiredComponents => const [
        'PolicyExemptionList',
        'PolicyExemptionDetails',
        'NotificationBanner',
        'SearchFilter',
        'ActionButtons',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchActiveExemptions',
        'refreshExemptions',
        'revokeException',
        'extendExpiration',
        'viewExceptionDetails',
      ];

  const PolicyExceptionTrackerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(policyExceptionsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Policy Exception Tracker',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('policy_exception_tracker_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(policyExceptionsProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load exceptions: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (exceptions) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Policy Exemptions', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: exceptions.length,
                  itemBuilder: (context, index) {
                    final exception = exceptions[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ExpansionTile(
                        leading: const Icon(Icons.gavel),
                        title: Text((exception['policyName'] as String?) ?? 'Unknown Policy', style: theme.typography.h4),
                        subtitle: Text('Requested by: ${(exception['requester'] as String?) ?? ''} | Expires: ${(exception['expiration'] as String?) ?? ''}'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Justification:', style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text((exception['justification'] as String?) ?? 'No justification provided.'),
                                const SizedBox(height: 16),
                                Text('Approver: ${exception['approver']}', style: theme.typography.labelSmall),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    OutlinedButton(key: const Key('policy_exception_tracker_outlinedbutton_button_1'), 
                                      onPressed: () {},
                                      child: const Text('Revoke Exception'),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(key: const Key('policy_exception_tracker_elevatedbutton_button_1'), 
                                      onPressed: () {},
                                      child: const Text('Extend Expiration'),
                                    ),
                                  ],
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
