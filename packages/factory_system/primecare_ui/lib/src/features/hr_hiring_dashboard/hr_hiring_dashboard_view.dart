// @governance: id=SCREEN_HR_HIRING_DASHBOARD
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

    hide isOnlineProvider, ProviderTTL;

// @governance: component=Candidate Pipeline
// @governance: component=Onboarding Checklist
// @governance: component=Recruitment KPI Grid
// @governance: component=Aura HUD (Pipeline Velocity)
// @governance: component=Candidate Pipeline View
class HrHiringDashboardView extends ConsumerWidget {
  const HrHiringDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(hrHiringDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(hrFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(hrFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HrHiringDashboardViewModel viewModel,
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
                    LocaleKeys.hr_hiring_dashboard_title.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    LocaleKeys.hr_hiring_dashboard_subtitle.tr(),
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          _buildHumanCapitalSummary(context, theme),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),

          SizedBox(height: theme.spacing.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildRecruitmentPipeline(context, theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildAdministrativeQueue(context, theme),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHumanCapitalSummary(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ORGANIZATIONAL HEALTH INDEX',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text('Status: Optimized', style: theme.typography.h1),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'Staffing levels are at 94% of capacity. Retention has improved by 8% following the Q1 incentive program.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          _buildGauge(theme, 0.94, 'Staff Capacity'),
        ],
      ),
    );
  }

  Widget _buildGauge(PrimeCareThemeData theme, double value, String label) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 12,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: theme.colors.primary,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                PrimeCareFormatters.formatPercentage(value),
                style: theme.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: theme.typography.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecruitmentPipeline(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recruitment Pipeline', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildPipelineRow(
            theme,
            'Nursing (RN/RPN)',
            0.85,
            theme.colors.primary,
          ),
          _buildPipelineRow(
            theme,
            'Support Staff (PSW)',
            0.92,
            theme.colors.success,
          ),
          _buildPipelineRow(
            theme,
            'Clinical Admin',
            0.45,
            theme.colors.warning,
          ),
          _buildPipelineRow(theme, 'Specialist Care', 0.30, theme.colors.error),
          _buildPipelineRow(
            theme,
            'Facility Operations',
            0.70,
            theme.colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineRow(
    PrimeCareThemeData theme,
    String role,
    double density,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                role,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                ' ${PrimeCareFormatters.formatPercentage(density)} Fulfilled',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: density,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildAdministrativeQueue(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pending Actions', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildQueueItem(
            theme,
            'Leave Requests',
            '12',
            LucideIcons.calendar,
            theme.colors.primary,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'Interviews Today',
            '5',
            LucideIcons.userCheck,
            theme.colors.success,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'Expiring Certs',
            '8',
            LucideIcons.alertTriangle,
            theme.colors.warning,
          ),
          const Divider(),
          _buildQueueItem(
            theme,
            'New Hires Onboarding',
            '3',
            LucideIcons.briefcase,
            theme.colors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(
    PrimeCareThemeData theme,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: theme.spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.typography.labelSmall),
              Text(value, style: theme.typography.h3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuraInsightsColumn(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.dashboards_common_labels_aura_intelligence.tr(),
          style: theme.typography.h4,
        ),
        SizedBox(height: theme.spacing.lg),
        ...insights.map(
          (insight) => Padding(
            padding: EdgeInsets.only(bottom: theme.spacing.md),
            child: IntelligenceInsightCard(insight: insight),
          ),
        ),
      ],
    );
  }
}

class HrHiringDashboardIntent extends PrimeCareScreen {
  HrHiringDashboardIntent()
      : super(
          name: 'hr_hiring_dashboard',
          title: LocaleKeys.hr_hiring_dashboard_title,
          route: '/offices/roles/hr/hiring',
          requiredRole: PlatformRole.hrHiring,
          form: PrimeCareForm.hrHiringDashboard,
          provider: hrHiringDashboardAdapterProvider,
          componentLabels: const ['Aura HUD', 'Human Capital Telemetry'],
        );

  @override
  Widget build(BuildContext context) => const HrHiringDashboardView();
}
