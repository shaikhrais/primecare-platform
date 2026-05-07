import 'package:primecare_ui/primecare_ui.dart';

class ClinicalReferenceView extends ConsumerStatefulWidget {
  const ClinicalReferenceView({super.key});

  @override
  ConsumerState<ClinicalReferenceView> createState() => _ClinicalReferenceViewState();
}

class _ClinicalReferenceViewState extends ConsumerState<ClinicalReferenceView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Anatomy', 'Conditions', 'Professional Practice', 'Techniques'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If there is a search query, use search API, otherwise use category filter
    final AsyncValue<List<ClinicalArticle>> articlesAsync;
    
    if (_searchQuery.isNotEmpty) {
      articlesAsync = ref.watch(clinicalArticlesSearchProvider(_searchQuery));
    } else {
      articlesAsync = ref.watch(_categoryArticlesProvider(_selectedCategory));
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search conditions, techniques, anatomy...',
                    prefixIcon: const Icon(LucideIcons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    isDense: true,
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    isDense: true,
                  ),
                  items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                        _searchQuery = ''; // Clear search when category changes
                        _searchController.clear();
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: articlesAsync.when(
            data: (articles) {
              if (articles.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.searchX, size: 48, color: Theme.of(context).disabledColor),
                      const SizedBox(height: 16),
                      Text('No articles found', style: Theme.of(context).textTheme.titleLarge),
                      Text('Try adjusting your search or category filter.', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                    child: ExpansionTile(
                      shape: const RoundedRectangleBorder(side: BorderSide.none),
                      collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
                      title: Text(article.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              article.category,
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.content.length > 300 
                                    ? '${article.content.substring(0, 300).trim()}...' 
                                    : article.content,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FilledButton.tonalIcon(
                                    onPressed: () {
                                      _showFullArticle(context, article);
                                    },
                                    icon: const Icon(LucideIcons.bookOpen, size: 16),
                                    label: const Text('Read Full Article'),
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
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.alertCircle, size: 48, color: Theme.of(context).colorScheme.error),
                  const SizedBox(height: 16),
                  Text('Error loading articles', style: Theme.of(context).textTheme.titleLarge),
                  Text(error.toString(), style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFullArticle(BuildContext context, ClinicalArticle article) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => ClinicalArticleDetailDialog(article: article),
    );
  }
}

// Temporary provider for fetching by category
final _categoryArticlesProvider = FutureProvider.family<List<ClinicalArticle>, String>((ref, category) async {
  final repo = ref.watch(clinicalEducationRepositoryProvider);
  if (category == 'All') {
    // Get a mixed list or search empty (which isn't supported, let's just search 'a' or get conditions)
    return repo.getArticlesByCategory('Conditions', limit: 50); // Fallback
  }
  return repo.getArticlesByCategory(category, limit: 50);
});
