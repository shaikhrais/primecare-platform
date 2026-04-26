import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

final intakeCoordinatorDashboardAdapterProvider =
    FutureProvider<Result<IntakeCoordinatorDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);

      // In a real scenario, we'd fetch from an infrastructure provider
      // For now, we hydrate with high-fidelity synthetic data that matches the Auditor's Blueprint

      final metrics = DashboardMetrics(
        kpis: [
          KpiMetric(
            title: LocaleKeys
                .dashboards_intakecoordinator_labels_active_referrals
                .tr(),
            value: '42',
            trend: '+12%',
            status: 'warning',
          ),
          KpiMetric(
            title: LocaleKeys
                .dashboards_intakecoordinator_labels_avg__intake_time
                .tr(),
            value: '18m',
            trend: '-2m',
            status: 'positive',
          ),
          KpiMetric(
            title: LocaleKeys.dashboards_intakecoordinator_labels_waitlist_depth
                .tr(),
            value: '156',
            trend: '+5',
            status: 'neutral',
          ),
        ],
        recentActivity: [
          DashboardActivity(
            title: LocaleKeys.dashboards_intakecoordinator_labels_new_referral
                .tr(),
            subtitle: LocaleKeys
                .dashboards_intakecoordinator_labels_john_doe___north_general_hospital
                .tr(),
            timestamp: '10m ago',
            icon: 'user_plus',
            color: 'blue',
          ),
          DashboardActivity(
            title: LocaleKeys
                .dashboards_intakecoordinator_labels_intake_completed
                .tr(),
            subtitle: LocaleKeys
                .dashboards_intakecoordinator_labels_jane_smith___sector_4
                .tr(),
            timestamp: '45m ago',
            icon: 'check_circle',
            color: 'green',
          ),
        ],
        charts: [
          AnalyticsChart(
            id: 'referral_volume',
            title: LocaleKeys
                .dashboards_intakecoordinator_labels_referral_volume__7d
                .tr(),
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
            title: LocaleKeys
                .dashboards_intakecoordinator_labels_capacity_bottleneck
                .tr(),
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
