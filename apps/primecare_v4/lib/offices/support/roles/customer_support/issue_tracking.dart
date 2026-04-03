import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../providers/dashboard_providers.dart';

class IssueTrackingView extends ConsumerWidget {
  const IssueTrackingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Issue Tracking & Resolution', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildIssueRow('Arthur Dent', 'Medication Delivery Delay', 'URGENT', Colors.red),
                    const Divider(height: 32, thickness: 0.1),
                    _buildIssueRow('Ford Prefect', 'Billing inquiry: Extra hour', 'PENDING', Colors.orange),
                    const Divider(height: 32, thickness: 0.1),
                    _buildIssueRow('Tricia McMillan', 'Access to Health Portal', 'RESOLVED', Colors.teal),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIssueRow(String user, String subject, String status, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 18, backgroundColor: color.withValues(alpha: 0.1), child: Text(user[0], style: TextStyle(color: color, fontWeight: FontWeight.bold))),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subject, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
          child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
        ),
      ],
    );
  }
}
