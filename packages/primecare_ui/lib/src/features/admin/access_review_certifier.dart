// Governance - Category: view | Purpose: Core implementation file for the Access Review Certifier platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final accessReviewsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/compliance/access-reviews');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class AccessReviewCertifierScreen extends GovernedConsumerWidget {
  const AccessReviewCertifierScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(accessReviewsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Access Review & Certification',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(accessReviewsProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load access reviews: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (reviews) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pending Manager Certifications', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Employee: ${review['employeeName']}', style: theme.typography.h4),
                            Text('Role: ${review['role']} | Department: ${review['department']}', style: theme.typography.bodyMedium),
                            const SizedBox(height: 16),
                            const Divider(),
                            Text('Assigned Privileges:', style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: (review['privileges'] as List? ?? []).map((privilege) {
                                return Chip(
                                  label: Text(privilege.toString()),
                                  backgroundColor: theme.colors.primary.withOpacity(0.1),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.cancel, color: theme.colors.error),
                                  label: Text('Revoke Selected', style: TextStyle(color: theme.colors.error)),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.check_circle),
                                  label: const Text('Certify Access'),
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
