import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/telemetry_service.dart';

class TelemetryHud extends ConsumerWidget {
  const TelemetryHud({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthAsync = ref.watch(systemHealthProvider);

    return healthAsync.when(
      data: (data) => PrimeCareCard(
        title: 'Live System Health',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'STABLE',
                  style: theme.typography.labelBold.copyWith(color: theme.colors.primary),
                ),
                const Icon(Icons.fiber_manual_record, color: Colors.green, size: 12)
                    .animate(onPlay: (controller) => controller.repeat())
                    .fade(duration: 500.ms)
                    .then()
                    .fade(duration: 500.ms),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatRow(context, 'CPU Usage', '${data.cpuUsage.toStringAsFixed(1)}%', data.cpuUsage > 70 ? theme.colors.error : theme.colors.primary),
            const SizedBox(height: 12),
            _buildStatRow(context, 'Memory', '${data.memoryUsage.toStringAsFixed(1)}%', data.memoryUsage > 80 ? theme.colors.tertiary : theme.colors.secondary),
            const SizedBox(height: 12),
            _buildStatRow(context, 'Active Requests', '${data.activeRequests}', theme.colors.primary),
          ],
        ),
      ),
      loading: () => const PrimeCareCard(child: Padding(padding: EdgeInsets.all(32), child: Center(child: CircularProgressIndicator()))),
      error: (err, stack) => PrimeCareCard(child: Center(child: Text('Telemetry Offline: $err'))),
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value, Color color) {
    final theme = context.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
        Text(value, style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
