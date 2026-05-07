import 'package:primecare_ui/primecare_ui.dart' hide ScreenRegistry;
import 'clinical_reference_brief_card.dart';
import 'package:primecare_governance/core/governance/screen_registry.dart';
import 'package:go_router/go_router.dart';

class ClinicalEducationDashboardWidget extends ConsumerWidget {
  const ClinicalEducationDashboardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch some random or recent articles
    // For now, let's just fetch "Conditions" as a sample
    final articlesAsync = ref.watch(_featuredArticlesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Precision Clinical Reference',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: () {
                final screen = ScreenRegistry.getById('CLINICAL_REFERENCE');
                if (screen != null) {
                  context.go(screen.routePath);
                }
              },
              icon: const Icon(LucideIcons.arrowRight, size: 16),
              label: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        articlesAsync.when(
          data: (articles) {
            return SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: articles.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return SizedBox(
                    width: 300,
                    child: ClinicalReferenceBriefCard(
                      article: article,
                      onTap: () => _showFullArticle(context, article),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error: $error'),
        ),
      ],
    );
  }

  void _showFullArticle(BuildContext context, ClinicalArticle article) {
    showDialog<void>(
      context: context,
      builder: (context) => ClinicalArticleDetailDialog(article: article),
    );
  }
}

final _featuredArticlesProvider = FutureProvider<List<ClinicalArticle>>((ref) async {
  final repo = ref.watch(clinicalEducationRepositoryProvider);
  // Get a few articles from different categories to show variety
  final conditions = await repo.getArticlesByCategory('Conditions', limit: 2);
  final techniques = await repo.getArticlesByCategory('Techniques', limit: 2);
  final anatomy = await repo.getArticlesByCategory('Anatomy', limit: 1);
  
  return [...conditions, ...techniques, ...anatomy];
});
