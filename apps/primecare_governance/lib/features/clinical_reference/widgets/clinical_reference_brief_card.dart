import 'package:primecare_ui/primecare_ui.dart';

class ClinicalReferenceBriefCard extends StatelessWidget {
  final ClinicalArticle article;
  final VoidCallback? onTap;

  const ClinicalReferenceBriefCard({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colors.divider),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getCategoryIcon(article.category),
                    size: 16,
                    color: theme.colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    article.category,
                    style: theme.typography.labelMedium.copyWith(
                      color: theme.colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                article.title,
                style: theme.typography.h3.copyWith(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                article.content,
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Read more',
                    style: theme.typography.labelSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colors.secondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    LucideIcons.chevronRight,
                    size: 14,
                    color: theme.colors.secondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Anatomy':
        return LucideIcons.layers;
      case 'Conditions':
        return LucideIcons.stethoscope;
      case 'Techniques':
        return LucideIcons.activity;
      case 'Professional Practice':
        return LucideIcons.briefcase;
      default:
        return LucideIcons.bookOpen;
    }
  }
}
