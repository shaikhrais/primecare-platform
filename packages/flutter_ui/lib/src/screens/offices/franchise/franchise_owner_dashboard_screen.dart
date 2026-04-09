import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/flutter_ui.dart';

class FranchiseOwnerDashboardScreen extends ConsumerWidget {
  const FranchiseOwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Subscribe to live data using the specific route metric.
    final metricsAsyncValue = ref.watch(dashboardMetricsProvider(FranchiseRoutes.franchiseOwnerDashboard));

    return ProviderLayout(
      child: metricsAsyncValue.when(
        data: (metrics) => DashboardView(
          header: DashboardHeader(
            title: 'FranchiseOwnerDashboardScreen',
            subtitle: 'Real-time metrics and alerts',
          ),
          kpiCards: metrics.kpis.map((kpi) => 
            PlatformKpiCard(
              title: kpi.label,
              value: kpi.value,
              trend: kpi.trend,
            )
          ).toList(),
          recentActivity: metrics.recentActivity.map((log) => 
            ActivityLogItem(
              title: log.title,
              timestamp: log.timestamp.toString(),
            )
          ).toList(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
