// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../theme/01_I_primecare_theme.dart';
import '../01_I_primecare_skeleton.dart';

/// Standard loading state for high-fidelity dashboards.
class DashboardLoadingWidget extends StatelessWidget {
  const DashboardLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        children: [
          _buildSkeletonHeader(theme),
          SizedBox(height: theme.spacing.xl),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.5,
              ),
              itemCount: 6,
              itemBuilder: (_, __) => const PrimeCareSkeleton(
                width: double.infinity,
                height: double.infinity,
                borderRadius: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonHeader(PrimeCareThemeData theme) {
    return Row(
      children: [
        const PrimeCareSkeleton(width: 300, height: 40, borderRadius: 8),
        const Spacer(),
        const PrimeCareSkeleton(width: 120, height: 40, borderRadius: 12),
      ],
    );
  }
}

/// Standard error state for high-fidelity dashboards.
class DashboardErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const DashboardErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Container(
          padding: EdgeInsets.all(theme.spacing.xl),
          decoration: BoxDecoration(
            color: theme.colors.error.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.colors.error.withValues(alpha: 0.2)),
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colors.error),
            SizedBox(height: theme.spacing.lg),
            Text(
              'Dashboard Sync Failure',
              style: theme.typography.h3.copyWith(color: theme.colors.error),
            ),
            SizedBox(height: theme.spacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.error),
            ),
             if (onRetry != null) ...[
              SizedBox(height: theme.spacing.xl),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Retry Synchronization'),
              ),
            ],
          ],
        ),
      ),
    ),
    );
  }
}

/// A premium placeholder widget for dashboards when the Aura pulse is stable and no anomalies are present.
class AuraEventStableWidget extends StatelessWidget {
  const AuraEventStableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(theme.spacing.xl),
      decoration: BoxDecoration(
        color: theme.colors.primary.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(theme.radii.lg),
        border: Border.all(color: theme.colors.primary.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.shieldCheck,
            color: theme.colors.primary.withValues(alpha: 0.4),
            size: 32,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            'SYSTEM STABLE',
            style: theme.typography.labelMedium.copyWith(
              color: theme.colors.primary.withValues(alpha: 0.6),
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: theme.spacing.xs),
          Text(
            'Aura Pulse monitoring active • No critical anomalies detected',
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.slateGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
