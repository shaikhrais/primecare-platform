import 'package:primecare_ui/primecare_ui.dart';
import 'regional_manager_dashboard_controller.dart';
import 'regional_manager_dashboard_model.dart';

class RegionalManagerDashboardView extends ConsumerWidget {
  const RegionalManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalManagerDashboardAdapterProvider);
    final controller = ref.read(regionalManagerDashboardAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: controller.refresh,
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: controller.refresh,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalManagerDashboardViewModel viewModel,
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
                    'Regional Oversight Hub',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Territory performance, franchise health, and expansion telemetry',
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

          Text('Franchise Performance Matrix', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildFranchiseGrid(theme),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildGrowthMap(theme),
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

  Widget _buildFranchiseGrid(PrimeCareThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => PrimeCareCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colors.primary,
              child: const Icon(Icons.business, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Franchise #${100 + index}',
                  style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Active • 98% CSAT',
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthMap(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.dashboards_common_labels_territory_growth_map.tr(), style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: theme.colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.public, size: 64, color: theme.colors.primary.withValues(alpha: 0.5)),
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

class RegionalManagerDashboardIntent extends PrimeCareScreen {
  RegionalManagerDashboardIntent() : super(title: "RegionalManagerDashboard");

  @override
  Widget build(BuildContext context) => const RegionalManagerDashboardView();
}


