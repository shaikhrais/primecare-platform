// @governance: id=SCREEN_LOCAL_MARKETING_MANAGER_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Lead Velocity)
// @governance: component=Campaign Performance Grid
// @governance: component=Referral Source Tracking
// @governance: component=Outreach Event Calendar
class LocalMarketingManagerDashboardView extends ConsumerWidget {
  const LocalMarketingManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(localMarketingManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel as LocalMarketingManagerDashboardViewModel),
          (e) => DashboardErrorWidget(
            message: 'Marketing Governance Error: $e',
            onRetry: () =>
                ref.refresh(localMarketingManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(localMarketingManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    LocalMarketingManagerDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Local Marketing Manager Command Center',
                style: theme.typography.h2,
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
                child: Column(
                  children: [
                    _buildCampaignPerformance(theme, viewModel.campaigns),
                    SizedBox(height: theme.spacing.xl),
                    _buildReferralSources(theme, viewModel.referrals),
                  ],
                ),
              ),
              SizedBox(width: theme.spacing.xl),
              Expanded(
                child: _buildAuraInsights(theme, viewModel.insights),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignPerformance(
    PrimeCareThemeData theme,
    List<MarketingCampaign> campaigns,
  ) {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Campaign Performance', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: campaigns.length,
            separatorBuilder: (_, __) => Divider(height: theme.spacing.xl),
            itemBuilder: (context, index) {
              final campaign = campaigns[index];
              return ListTile(
                title: Text(campaign.title, style: theme.typography.bodyLarge),
                subtitle: Text('Conversion Rate: ${campaign.conversionRate}%'),
                trailing: Text(
                  campaign.status,
                  style: theme.typography.labelMedium.copyWith(
                    color: campaign.status == 'Active' ? Colors.green : Colors.orange,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReferralSources(
    PrimeCareThemeData theme,
    List<ReferralSource> referrals,
  ) {
    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Referral Sources', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          ...referrals.map((ref) => Padding(
            padding: EdgeInsets.only(bottom: theme.spacing.md),
            child: Row(
              children: [
                Text(ref.source, style: theme.typography.bodyMedium),
                const Spacer(),
                Text('${ref.count} leads', style: theme.typography.labelLarge),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAuraInsights(
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

class LocalMarketingManagerDashboardIntent extends PrimeCareScreen {
  static const kName = 'local-marketing-manager-dashboard';
  static const kRoute = '/offices/corporate/roles/local-marketing-manager/dashboard';

  @override
  String get title => LocaleKeys.local_marketing_manager_dashboard_title;

  @override
  PlatformRole get requiredRole => PlatformRole.localMarketingManager;

  @override
  PrimeCareForm get form => PrimeCareForm.localMarketingManagerDashboard;

  LocalMarketingManagerDashboardIntent()
      : super(
          name: kName,
          title: LocaleKeys.local_marketing_manager_dashboard_title,
          route: kRoute,
          requiredRole: PlatformRole.localMarketingManager,
          form: PrimeCareForm.localMarketingManagerDashboard,
          provider: localMarketingManagerDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Lead Velocity)',
            'Campaign Performance Grid',
            'Referral Source Tracking',
            'Outreach Event Calendar',
          ],
        );

  @override
  Widget build(BuildContext context) =>
      const LocalMarketingManagerDashboardView();
}
