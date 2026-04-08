import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_v4/shared/components/page_template.dart';
import 'package:go_router/go_router.dart';
import '../../../../providers/dashboard_providers.dart';

class ScrumMasterDashboard extends ConsumerWidget {
  const ScrumMasterDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Operations Terminal',
      subtitle: 'Technical audit and real-time backend orchestration.',
      metricsProvider: dashboardMetricsProvider,
      sections: const [
        _SystemAuditLogSection(),
      ],
      actions: [
        _buildPulseIndicator('SYSTEM_HEALTH: NOMINAL'),
      ],
    );
  }

  static Widget _buildPulseIndicator(String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.greenAccent,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _SystemAuditLogSection extends ConsumerWidget {
  const _SystemAuditLogSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const SizedBox(),
      data: (metrics) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('36-Role Data Sync Matrix', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const SizedBox(height: 16),
                ClinicalGlassPanel(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(36, (index) => _buildStatusDot(index)),
                  ),
                ),
                const SizedBox(height: 32),
                const Text('System Audit Log', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const SizedBox(height: 16),
                ClinicalGlassPanel(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: metrics.recentActivity.map((log) => _buildLogEntry(log.timestamp, log.title, log.subtitle, _getStatusColor(log.color))).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dead Letter Queue (DLQ)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const SizedBox(height: 16),
                ClinicalGlassPanel(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(Icons.dangerous, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 16),
                      const Text('34 Orphaned Payloads', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      const Text('Waiting in queue [worker-dlq-01]', style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.flash_on),
                          label: const Text('Flush Dead Letter Queue'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.tealAccent.withValues(alpha: 0.1),
                            foregroundColor: Colors.tealAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text('110 Master Archetypes UI Index', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
                const SizedBox(height: 16),
                ClinicalGlassPanel(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(110, (index) => _buildFeatureDot(context, index + 1)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDot(int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.tealAccent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text('R${index + 1}', style: const TextStyle(color: Colors.tealAccent, fontSize: 9, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildFeatureDot(BuildContext context, int index) {
    return InkWell(
      onTap: () => context.go('/provider/feature/stitch_feature_$index'),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text('F$index', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildLogEntry(String ts, String type, String details, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('[$ts]', style: const TextStyle(color: Colors.blueGrey, fontSize: 11, fontFamily: 'monospace')),
              const SizedBox(width: 8),
              Text(type, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Text(details, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
      case 'green':
      case 'teal':
        return Colors.tealAccent;
      case 'warning':
      case 'orange':
        return Colors.orangeAccent;
      case 'danger':
      case 'red':
        return Colors.redAccent;
      case 'info':
      case 'blue':
        return Colors.blueAccent;
      default:
        return Colors.blueGrey;
    }
  }
}
