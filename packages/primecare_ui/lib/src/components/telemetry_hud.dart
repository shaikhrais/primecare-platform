// Governance - Category: view | Purpose: Core implementation file for the Telemetry Hud platform logic.
import 'package:flutter_animate/flutter_animate.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TelemetryHud extends ConsumerWidget {
  const TelemetryHud({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthAsync = ref.watch(systemHealthProvider);
    final theme = context.theme;

    return healthAsync.when(
      data: (data) => PrimeCareCard(
        padding: EdgeInsets.all(theme.spacing * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Live System Health', style: theme.typography.h3),
                _buildLiveIndicator(theme),
              ],
            ),
            SizedBox(height: theme.spacing * 4),

            // Primary Metrics Grid
            GridView.extent(
              maxCrossAxisExtent: 160,
              crossAxisSpacing: theme.spacing * 2,
              mainAxisSpacing: theme.spacing * 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              children: [
                _buildMetricSegment(
                  context,
                  'CPU',
                  '${data.cpuUsage.toStringAsFixed(1)}%',
                  data.cpuUsage > 70
                      ? theme.colors.error
                      : theme.colors.primary,
                ),
                _buildMetricSegment(
                  context,
                  'RAM',
                  '${data.memoryUsage.toStringAsFixed(1)}%',
                  data.memoryUsage > 80
                      ? theme.colors.tertiary
                      : theme.colors.secondary,
                ),
              ],
            ),

            SizedBox(height: theme.spacing * 3),

            // Secondary Metrics List
            Container(
              padding: EdgeInsets.all(theme.spacing * 2),
              decoration: BoxDecoration(
                color: theme.colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(theme.radiusMd),
              ),
              child: Column(
                children: [
                  _buildStatRow(
                    context,
                    'Active Requests',
                    '${data.activeRequests}',
                    theme.colors.primary,
                  ),
                  Divider(height: 16, color: theme.colors.outlineVariant),
                  _buildStatRow(
                    context,
                    'Net Latency',
                    '14ms',
                    theme.colors.success,
                  ),
                  Divider(height: 16, color: theme.colors.outlineVariant),
                  _buildStatRow(
                    context,
                    'Uptime',
                    '14d 6h 22m',
                    theme.colors.primary,
                  ),
                ],
              ),
            ),

            SizedBox(height: theme.spacing * 3),

            Text(
              'Last update: ${data.timestamp.toIso8601String().substring(11, 19)}',
              style: theme.typography.labelMedium.copyWith(
                color: theme.colors.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      loading: () => PrimeCareCard(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: CircularProgressIndicator(color: theme.colors.primary),
          ),
        ),
      ),
      error: (err, stack) => PrimeCareCard(
        child: Center(
          child: Text(
            'Telemetry Offline: $err',
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.error,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiveIndicator(PrimeThemeData theme) {
    return Row(
      children: [
        Text(
          'STABLE',
          style: theme.typography.labelBold.copyWith(
            color: theme.colors.success,
            fontSize: 10,
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.fiber_manual_record, color: theme.colors.success, size: 8)
            .animate(onPlay: (controller) => controller.repeat())
            .fade(duration: 500.ms)
            .then()
            .fade(duration: 500.ms),
      ],
    );
  }

  Widget _buildMetricSegment(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing * 2,
        vertical: theme.spacing * 1.5,
      ),
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(theme.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: theme.typography.labelMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          Text(value, style: theme.typography.h3.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    final theme = context.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.typography.bodySmall.copyWith(
            color: theme.colors.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.typography.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
