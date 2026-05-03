// @governance: id=SCREEN_HR_MANAGER_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Data Table

    hide isOnlineProvider, ProviderTTL;

// @governance: component=Operational DashboardMetrics
// @governance: component=HR Action Hub
// @governance: component=Staffing Velocity
// @governance: component=Compliance Audit
// @governance: component=Aura HUD
class HrManagerDashboardView extends ConsumerWidget {
  const HrManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(hrManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(hrManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(hrManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HumanResourcesManagerDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.hr_manager_dashboard_title.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    LocaleKeys.hr_manager_dashboard_subtitle.tr(),
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildStaffingVelocity(theme),
                    SizedBox(height: theme.spacing.xl),
                    const TrainingComplianceGrid(),
                    SizedBox(height: theme.spacing.xl),
                    const HiringFunnelGrid(),
                    SizedBox(height: theme.spacing.xl),
                    const HrActionHub(),
                  ],
                ),
              ),
              if (vm.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(child: _buildIntelligenceSection(theme, vm.insights)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStaffingVelocity(PrimeCareThemeData theme) {
    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_staffing_velocity_matrix.tr(),
      chart: PrimeCareLineChart(
        chart: AnalyticsChart(
          id: 'hiring_trend',
          title: LocaleKeys.dashboards_common_labels_velocity_score.tr(),
          type: ChartType.line,
          dataPoints: [
            ChartDataPoint(label: 'Jan', value: 42),
            ChartDataPoint(label: 'Feb', value: 38),
            ChartDataPoint(label: 'Mar', value: 54),
            ChartDataPoint(label: 'Apr', value: 62),
            ChartDataPoint(label: 'May', value: 58),
            ChartDataPoint(label: 'Jun', value: 71),
          ],
        ),
      ),
    );
  }

  Widget _buildIntelligenceSection(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Capital Intelligence', style: theme.typography.h4),
        SizedBox(height: theme.spacing.md),
        Column(
          children: insights
              .map(
                (insight) => Padding(
                  padding: EdgeInsets.only(bottom: theme.spacing.md),
                  child: IntelligenceInsightCard(insight: insight),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class HiringFunnelGrid extends StatelessWidget {
  const HiringFunnelGrid({super.key});
  @override
  Widget build(BuildContext context) => PrimeCareCard(
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(context.theme.spacing.xl),
        child: Text(
          LocaleKeys.dashboards_common_labels_active_hiring_funnel.tr(),
        ),
      ),
    ),
  );
}

class TrainingComplianceGrid extends StatelessWidget {
  const TrainingComplianceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Institutional Compliance', style: theme.typography.h3),
          Text(
            'Mandatory training and certification audit status',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          PrimeCareDataTable<Map<String, String>>(
            columns: const ['Certification', 'Certified', 'Expiring', 'Status'],
            rows: [
              _buildRow('First Aid / CPR', '92%', '8', 'STABLE'),
              _buildRow('Dementia Care', '85%', '12', 'CAUTION'),
              _buildRow('WHMIS 2026', '98%', '2', 'STABLE'),
              _buildRow('Privacy Policy', '75%', '24', 'CRITICAL'),
            ],
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String cert,
    String certified,
    String expiring,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(cert)),
        DataCell(
          Text(certified, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        DataCell(Text(expiring)),
        DataCell(PrimeCareBadge(text: status, type: _getBadgeType(status))),
      ],
    );
  }

  BadgeType _getBadgeType(String status) {
    switch (status) {
      case 'STABLE':
        return BadgeType.success;
      case 'CAUTION':
        return BadgeType.warning;
      case 'CRITICAL':
        return BadgeType.error;
      default:
        return BadgeType.neutral;
    }
  }
}

class HrActionHub extends StatelessWidget {
  const HrActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_post_job.tr(),
          icon: LucideIcons.briefcase,
          route: '/hr/jobs/new',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_approve_leave.tr(),
          icon: LucideIcons.calendarX,
          route: '/hr/leave',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_run_payroll.tr(),
          icon: LucideIcons.banknote,
          route: '/hr/payroll',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_audit_training.tr(),
          icon: LucideIcons.graduationCap,
          route: '/hr/training',
        ),
      ],
    );
  }
}

class HrManagerDashboardIntent extends PrimeCareScreen {
  HrManagerDashboardIntent()
      : super(
          name: 'hr_manager_dashboard',
          title: LocaleKeys.hr_manager_dashboard_title,
          route: '/offices/roles/hr/manager',
          requiredRole: PlatformRole.hrManager,
          form: PrimeCareForm.hrManagerDashboard,
          provider: hrManagerDashboardAdapterProvider,
          componentLabels: const ['Aura HUD', 'HR Telemetry'],
        );

  @override
  Widget build(BuildContext context) => const HrManagerDashboardView();
}
