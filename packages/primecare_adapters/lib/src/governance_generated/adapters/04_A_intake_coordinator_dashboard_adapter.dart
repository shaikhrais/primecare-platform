import 'package:primecare_adapters/primecare_adapters.dart';

final intakeCoordinatorDashboardAdapterProvider =
    FutureProvider<Result<IntakeCoordinatorDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);

      // In a real scenario, we'd fetch from an infrastructure provider
      // For now, we hydrate with high-fidelity synthetic data that matches the Auditor's Blueprint

      final metrics = DashboardMetrics(
        kpis: [
          const KpiMetric(
            title: 'Active Referrals',
            value: '42',
            trend: '+12%',
            status: 'warning',
          ),
          const KpiMetric(
            title: 'Avg. Intake Time',
            value: '18m',
            trend: '-2m',
            status: 'positive',
          ),
          const KpiMetric(
            title: 'Waitlist Depth',
            value: '156',
            trend: '+5',
            status: 'neutral',
          ),
        ],
        recentActivity: [
          DashboardActivity(
            title: 'New Referral',
            subtitle: 'John Doe - North General Hospital',
            timestamp: '10m ago',
            icon: 'user_plus',
            color: 'blue',
          ),
          DashboardActivity(
            title: 'Intake Completed',
            subtitle: 'Jane Smith - Sector 4',
            timestamp: '45m ago',
            icon: 'check_circle',
            color: 'green',
          ),
        ],
        charts: [
          AnalyticsChart(
            id: 'referral_volume',
            title: 'Referral Volume (7d)',
            type: ChartType.line,
            dataPoints: [
              ChartDataPoint(label: 'Mon', value: 12),
              ChartDataPoint(label: 'Tue', value: 15),
              ChartDataPoint(label: 'Wed', value: 8),
              ChartDataPoint(label: 'Thu', value: 22),
              ChartDataPoint(label: 'Fri', value: 19),
              ChartDataPoint(label: 'Sat', value: 5),
              ChartDataPoint(label: 'Sun', value: 4),
            ],
          ),
        ],
        insights: [
          DashboardInsight(
            title: 'Capacity Bottleneck',
            description:
                'Waitlist in Sector B exceeds 20% of target. Additional review needed.',
            type: 'CAPACITY',
            impact: InsightImpact.caution,
          ),
        ],
      );

      final viewModel = IntakeCoordinatorDashboardViewModel(
        metrics: metrics,
        insights:
            const [], // Insights are now embedded in metrics or provided separately if needed
      );

      telemetry.passGate(
        ExecutionGateCategory.auraEngine,
        'Intake Coordinator Dashboard Hydrated',
      );

      return Success(viewModel);
    });
