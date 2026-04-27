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
      data: (data) => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Live System Health', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Icon(Icons.fiber_manual_record, color: Colors.green, size: 12)
                      .animate(onPlay: (controller) => controller.repeat())
                      .fade(duration: 500.ms)
                      .then()
                      .fade(duration: 500.ms),
                ],
              ),
              const SizedBox(height: 16),
              _buildStatRow('CPU Usage', '${data.cpuUsage.toStringAsFixed(1)}%', data.cpuUsage > 70 ? Colors.red : Colors.blue),
              const SizedBox(height: 8),
              _buildStatRow('Memory', '${data.memoryUsage.toStringAsFixed(1)}%', data.memoryUsage > 80 ? Colors.orange : Colors.green),
              const SizedBox(height: 8),
              _buildStatRow('Active Requests', '${data.activeRequests}', Colors.purple),
            ],
          ),
        ),
      ),
      loading: () => const Card(child: Padding(padding: EdgeInsets.all(32), child: Center(child: CircularProgressIndicator()))),
      error: (err, stack) => Card(child: Center(child: Text('Telemetry Offline: $err'))),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
