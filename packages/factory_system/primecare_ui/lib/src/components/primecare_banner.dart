// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';

enum BannerType { info, warning, error, success }

class PrimeCareBanner extends StatelessWidget {
  final String message;
  final BannerType type;

  const PrimeCareBanner({
    super.key,
    required this.message,
    this.type = BannerType.info,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);

    final color = switch (type) {
      BannerType.info => theme.colors.primary,
      BannerType.warning => Colors.orange,
      BannerType.error => theme.colors.error,
      BannerType.success => Colors.green,
    };

    final icon = switch (type) {
      BannerType.info => LucideIcons.info,
      BannerType.warning => LucideIcons.alertTriangle,
      BannerType.error => LucideIcons.shieldAlert,
      BannerType.success => LucideIcons.checkCircle,
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.typography.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
