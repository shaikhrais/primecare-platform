import 'package:primecare_ui/primecare_ui.dart';
import 'clinical_reference_brief_card.dart';

class ClinicalReferenceDrawer extends ConsumerStatefulWidget {
  const ClinicalReferenceDrawer({super.key});

  @override
  ConsumerState<ClinicalReferenceDrawer> createState() =>
      _ClinicalReferenceDrawerState();
}

class _ClinicalReferenceDrawerState
    extends ConsumerState<ClinicalReferenceDrawer> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Drawer(
      width: 400,
      backgroundColor: theme.colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          _buildSearchField(context),
          Expanded(child: _buildResultsList(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 64, 16, 24),
      decoration: BoxDecoration(
        color: theme.colors.primary.withValues(alpha: 0.05),
        border: Border(bottom: BorderSide(color: theme.colors.divider)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.bookOpen, color: theme.colors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text('Clinical Reference', style: theme.typography.h3),
          ),
          IconButton(
            icon: const Icon(LucideIcons.x),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search conditions, techniques...',
          prefixIcon: const Icon(LucideIcons.search),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  icon: const Icon(LucideIcons.xCircle),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                )
              : null,
          filled: true,
          fillColor: theme.colors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() => _query = value);
        },
      ),
    );
  }

  Widget _buildResultsList(BuildContext context) {
    if (_query.isEmpty) {
      return const EmptyState(
        icon: LucideIcons.library,
        title: 'Quick Reference Library',
        subtitle:
            'Search the Precision Clinical database for evidence-based conditions and techniques.',
      );
    }

    final searchResults = ref.watch(clinicalArticlesSearchProvider(_query));

    return searchResults.when(
      data: (articles) {
        if (articles.isEmpty) {
          return const EmptyState(
            icon: LucideIcons.searchX,
            title: 'No results found',
            subtitle: 'Try searching for a different term',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: articles.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final article = articles[index];
            return ClinicalReferenceBriefCard(
              article: article,
              onTap: () => _showFullArticle(context, article),
            );
          },
        );
      },
      loading: () => const EmptyState(
        icon: LucideIcons.loader2,
        title: 'Searching Database...',
        subtitle: 'Retrieving evidence-based data from the repository.',
      ),
      error: (err, stack) => EmptyState(
        icon: LucideIcons.alertCircle,
        title: 'Error searching library',
        subtitle: err.toString(),
      ),
    );
  }

  void _showFullArticle(BuildContext context, ClinicalArticle article) {
    showDialog(
      context: context,
      builder: (context) => ClinicalArticleDetailDialog(article: article),
    );
  }
}
