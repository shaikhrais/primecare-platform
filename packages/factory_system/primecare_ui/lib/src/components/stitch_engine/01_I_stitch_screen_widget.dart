// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/design_system/01_I_clinical_glass.dart';

/// A bridge widget that represents a high-fidelity screen orchestrated by the Stitch engine.
class StitchScreenWidget extends StatelessWidget {
  final String screenId;

  const StitchScreenWidget({super.key, required this.screenId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: ClinicalGlass(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'High-Fidelity Executive Module',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Hydrated via Stitch Blueprint Engine',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.primary.withValues(alpha: 0.7),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _buildStatusBadge('PRODUCTION READY'),
              ],
            ),
            const SizedBox(height: 32),
            _buildMetricsPreview(context),
            const SizedBox(height: 24),
            Text(
              'Stitch ID: $screenId',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: PrimeCareColors.emerald.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: PrimeCareColors.emerald.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: PrimeCareColors.emerald,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMetricsPreview(BuildContext context) {
    return Row(
      children: [
        _buildMiniMetric(
          context,
          'Operational Efficiency',
          '98.4%',
          Icons.speed,
        ),
        const SizedBox(width: 24),
        _buildMiniMetric(context, 'Resource Allocation', 'High', Icons.hub),
        const SizedBox(width: 24),
        _buildMiniMetric(context, 'Risk Assessment', 'Nominal', Icons.shield),
      ],
    );
  }

  Widget _buildMiniMetric(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
