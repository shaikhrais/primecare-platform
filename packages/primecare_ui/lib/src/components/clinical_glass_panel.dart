// Governance - Category: view | Purpose: A premium glassmorphism container for clinical and governance dashboards.
import 'package:primecare_ui/primecare_ui.dart';

/// A premium glassmorphism container for clinical and governance dashboards.
class ClinicalGlassPanel extends StatelessWidget {
  final Widget child;
  final String? title;
  final IconData? icon;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const ClinicalGlassPanel({
    super.key,
    required this.child,
    this.title,
    this.icon,
    this.padding = const EdgeInsets.all(24),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      decoration: BoxDecoration(
        color: color ?? theme.colors.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colors.border.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.colors.border.withValues(alpha: 0.3),
                  ),
                ),
                gradient: LinearGradient(
                  colors: [
                    theme.colors.primary.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: theme.colors.primary, size: 20),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    title!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}
