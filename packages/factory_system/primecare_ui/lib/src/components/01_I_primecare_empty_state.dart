import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE

/// A standardized empty state component for PrimeCare dashboards and lists.
class PrimeCareEmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? title;
  final VoidCallback? onAction;
  final String? actionLabel;

  const PrimeCareEmptyState({
    super.key,
    required this.message,
    this.icon = LucideIcons.inbox,
    this.title,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(theme.spacing.lg),
              decoration: BoxDecoration(
                color: theme.colors.surfaceContainerHighest.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: theme.colors.slate400,
              ),
            ),
            SizedBox(height: theme.spacing.lg),
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: theme.typography.h3.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: theme.spacing.xs),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.slateGray,
              ),
            ),
            if (onAction != null && actionLabel != null) ...[
              SizedBox(height: theme.spacing.xl),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(LucideIcons.plus, size: 18),
                label: Text(actionLabel!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing.xl,
                    vertical: theme.spacing.md,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
