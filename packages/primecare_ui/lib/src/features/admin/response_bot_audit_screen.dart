// Governance - Category: view | Purpose: UI Screen component rendering the Response Bot Audit Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final botAuditProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/bot-audits');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ResponseBotAuditScreen extends GovernedConsumerWidget {
  const ResponseBotAuditScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final auditState = ref.watch(botAuditProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'ResponseBot Safety Audit',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(botAuditProvider),
          ),
        ],
      ),
      body: auditState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load audits: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (audits) => Row(
          children: [
            // List of conversations needing review
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: theme.colors.surface,
                border: Border(right: BorderSide(color: theme.colors.border)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Transcripts...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: audits.length,
                      itemBuilder: (context, index) {
                        final audit = audits[index];
                        final needsReview = audit['flagged'] == true;
                        return ListTile(
                          leading: Icon(
                            needsReview ? Icons.warning : Icons.check_circle,
                            color: needsReview ? theme.colors.error : theme.colors.success,
                          ),
                          title: Text(audit['sessionID'] as String? ?? 'Unknown Session'),
                          subtitle: Text('Score: ${audit['safetyScore'] ?? '100'}%'),
                          selected: index == 0,
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Chat Viewer and Flagging
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Transcript Viewer', style: theme.typography.h2),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: ListView(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 8, left: 48),
                                decoration: BoxDecoration(
                                  color: theme.colors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('I am feeling dizzy and confused.'),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 8, right: 48),
                                decoration: BoxDecoration(
                                  color: theme.colors.background,
                                  border: Border.all(color: theme.colors.border),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('ResponseBot: It sounds like you are experiencing a medical emergency. Please call emergency services immediately.'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.thumb_up),
                          label: const Text('Approve Handling'),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton.icon(
                          icon: Icon(Icons.flag, color: theme.colors.error),
                          label: Text('Flag for Tuning', style: TextStyle(color: theme.colors.error)),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
