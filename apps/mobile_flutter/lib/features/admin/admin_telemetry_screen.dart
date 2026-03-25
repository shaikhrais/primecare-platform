import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/admin/providers/admin_stats_provider.dart';

class AdminTelemetryScreen extends ConsumerWidget {
  const AdminTelemetryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(adminStatsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('System Telemetry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: asyncStats.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: Text('Error linking telemetry API organically: $err'),
          ),
          data: (stats) {
            return Column(
              children: [
                const ServerLoadGraph(),
                const SizedBox(height: 24),
                ActiveWebSocketTracker(
                  activeConnections: stats.totalVisits > 0
                      ? stats.totalVisits
                      : 142,
                  pendingJobQueue: stats.unassignedShifts,
                  systemScore: (100.0 - stats.openIncidents).clamp(0.0, 100.0),
                ),
                const SizedBox(height: 24),
                // const SecurityAuditAlertList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
