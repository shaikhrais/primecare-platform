// Governance - Category: view | Purpose: UI Screen component rendering the Faq Manager Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

final faqManagerProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/faqs');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class FAQManagerScreen extends GovernedConsumerWidget {
  const FAQManagerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final faqState = ref.watch(faqManagerProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'FAQ & Knowledge Base Manager',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, color: theme.colors.primary),
            onPressed: () {},
            tooltip: 'Add New FAQ Entry',
          ),
        ],
      ),
      body: faqState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load FAQs: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (faqs) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help Center Content Management',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage articles and knowledge base used by the PrimeCare ResponseBot.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 350,
                maxItemWidth: 600,
                spacing: 24.0,
                children: [
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FAQ Category Tree', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          if (faqs.isEmpty)
                            const Text('No FAQs found.')
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: faqs.length,
                              itemBuilder: (context, index) {
                                final faq = faqs[index];
                                return ExpansionTile(
                                  title: Text((faq['question'] as String?) ?? 'Untitled Question'),
                                  subtitle: Text('Category: ${(faq['category'] as String?) ?? 'General'}'),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text((faq['answer'] as String?) ?? 'No answer provided.'),
                                    ),
                                    OverflowBar(
                                      children: [
                                        TextButton(onPressed: () {}, child: const Text('Edit')),
                                        TextButton(onPressed: () {}, child: const Text('Delete')),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: theme.colors.surface,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Content Analytics', style: theme.typography.h4),
                          const SizedBox(height: 16),
                          Container(
                            height: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('Usage Analytics Graph Placeholder'),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.trending_up, color: theme.colors.primary),
                            title: const Text('Most Viewed Category'),
                            trailing: const Text('Billing Support'),
                          ),
                          ListTile(
                            leading: Icon(Icons.search, color: theme.colors.primary),
                            title: const Text('Top Searched Term'),
                            trailing: const Text('Reset Password'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
