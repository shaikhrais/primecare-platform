// Governance - Category: view | Purpose: Core implementation file for the Peer Review Conference Room platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final peerReviewProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/peer_review/cases');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class PeerReviewConferenceRoomScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for displaying active cases, submitting new cases, and joining discussions, along with necessary APIs and responsive design.';

  @override
  List<String> get requiredComponents => const [
        'ActiveCasesList',
        'CaseStatusIndicator',
        'NotificationsPanel',
        'CaseStatusChart',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshCaseList',
        'submitNewCase',
        'joinDiscussion',
      ];

  const PeerReviewConferenceRoomScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(peerReviewProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('M&M Peer Review Room', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('peer_review_conference_room_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(peerReviewProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Submit Case'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (cases) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Discussion Cases', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: cases.length,
                  itemBuilder: (context, index) {
                    final prCase = cases[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.gavel, color: theme.colors.primary, size: 32),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(prCase['case_title'] as String, style: theme.typography.h4),
                                  const SizedBox(height: 8),
                                  Text('Department: ${prCase['department']}', style: theme.typography.bodyMedium),
                                  Text('Review Date: ${prCase['scheduled_date']}', style: theme.typography.labelSmall),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Chip(
                                label: Text(prCase['status'] as String, style: const TextStyle(color: Colors.white)),
                                backgroundColor: (prCase['status'] as String) == 'Pending Review' ? Colors.orange : Colors.green,
                                ),
                                const SizedBox(height: 8),
                                OutlinedButton(key: const Key('peer_review_conference_room_outlinedbutton_button_1'), 
                                  onPressed: () {},
                                  child: const Text('Join Discussion'),
                                ),
                              ],
                            )
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
