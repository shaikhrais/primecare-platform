// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

// @governance: component=Aura HUD (Lead Conversion)
// @governance: component=Marketing KPI Grid
// @governance: component=Lead Conversion Funnel
// @governance: component=Brand Awareness DashboardMetrics
class MarketingManagerDashboardView extends ConsumerWidget {
  const MarketingManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(marketingManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () =>
                ref.refresh(marketingManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(marketingManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    MarketingManagerDashboardViewModel viewModel,
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
                  Text('Growth & Branding Hub', style: theme.typography.h2),
                  Text(
                    'Global campaign performance and brand intelligence telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(children: [_buildCampaignFunnel(context, theme)]),
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

  Widget _buildCampaignFunnel(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.dashboards_common_labels_campaign_conversion_funnel.tr(),
            style: theme.typography.titleLarge,
          ),
          SizedBox(height: theme.spacing.xl),
          _buildFunnelStage(
            theme,
            'Awareness',
            '1.2M',
            1.0,
            theme.colors.primary.withValues(alpha: 0.2),
          ),
          _buildFunnelStage(
            theme,
            'Interest',
            '450K',
            0.37,
            theme.colors.primary.withValues(alpha: 0.4),
          ),
          _buildFunnelStage(
            theme,
            'Consideration',
            '120K',
            0.10,
            theme.colors.primary.withValues(alpha: 0.6),
          ),
          _buildFunnelStage(
            theme,
            'Conversion',
            '12.5K',
            0.01,
            theme.colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelStage(
    PrimeCareThemeData theme,
    String label,
    String value,
    double factor,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: factor,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
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
        Text('Brand Intelligence', style: theme.typography.h4),
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

class MarketingManagerDashboardIntent extends PrimeCareScreen {
  MarketingManagerDashboardIntent()
      : super(
          title: LocaleKeys.dashboards_common_labels_marketing_manager_dashboard,
          name: 'marketing_manager_dashboard',
          route: '/roles/marketing_manager/dashboard',
          requiredRole: PlatformRole.headOfMarketing,
          form: PrimeCareForm.marketingManagerDashboard,
          provider: marketingManagerDashboardAdapterProvider,
        );

  @override
  Widget build(BuildContext context) => const MarketingManagerDashboardView();
}
