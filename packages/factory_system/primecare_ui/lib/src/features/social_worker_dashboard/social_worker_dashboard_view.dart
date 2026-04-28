// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/src/components/primecare_app_bar.dart';
import 'package:primecare_ui/src/shared/src/components/primecare_scaffold.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class SocialWorkerDashboardView extends ConsumerWidget {
  const SocialWorkerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(socialWorkerDashboardAdapterProvider);

    return PrimeCareScaffold(
      color: theme.colors.background,
      appBar: PrimeCareAppBar(
        title: LocaleKeys.dashboards_common_labels_social_care_command_hud.tr(),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.fileText),
            onPressed: () {},
            tooltip: 'Download Reports',
          ),
          IconButton(icon: const Icon(LucideIcons.bell), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          const AuraDashboardHud(),
          Expanded(
            child: state.when(
              data: (result) => result.fold(
                (viewModel) => _buildContent(context, theme, viewModel, ref),
                (e) => DashboardErrorWidget(
                  message: 'Social Care Error: $e',
                  onRetry: () =>
                      ref.refresh(socialWorkerDashboardAdapterProvider),
                ),
              ),
              loading: () => const DashboardLoadingWidget(),
              error: (e, st) => DashboardErrorWidget(
                message: 'Connection Error: $e',
                onRetry: () =>
                    ref.refresh(socialWorkerDashboardAdapterProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    SocialWorkerDashboardViewModel viewModel,
    WidgetRef ref,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Command Hub Actions
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PrimeCareChip(
                  label: 'Add Client',
                  onPressed: () =>
                      ref.read(socialWorkerActionHandler)('BTN_ADD_CLIENT'),
                  color: theme.colors.primary,
                ),
                SizedBox(width: theme.spacing.sm),
                PrimeCareChip(
                  label: 'Crisis Override',
                  onPressed: () => ref.read(socialWorkerActionHandler)(
                    'BTN_CRISIS_OVERRIDE',
                  ),
                  color: theme.colors.error,
                ),
                SizedBox(width: theme.spacing.sm),
                PrimeCareChip(
                  label: 'Community Map',
                  onPressed: () =>
                      ref.read(socialWorkerActionHandler)('BTN_MAP_RESOURCE'),
                ),
              ],
            ),
          ),
          SizedBox(height: theme.spacing.xl),

          Text(
            'Social Care Health Pulse',
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: theme.spacing.md),
          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 1000;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        _buildMainChart(theme, viewModel.metrics),
                        SizedBox(height: theme.spacing.xl),
                        _buildEventLedger(theme, viewModel.metrics),
                      ],
                    ),
                  ),
                  if (isWide) ...[
                    SizedBox(width: theme.spacing.xl),
                    Expanded(
                      flex: 2,
                      child: _buildAuraInsightsColumn(
                        theme,
                        viewModel.insights,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainChart(PrimeCareThemeData theme, DashboardMetrics metrics) {
    final chart = metrics.charts.firstWhere(
      (c) => c.id == 'intervention-dynamics',
      orElse: () => AnalyticsChart.empty(),
    );

    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_intervention_stability_vector
          .tr(),
      chart: PrimeCareLineChart(chart: chart),
    );
  }

  Widget _buildAuraInsightsColumn(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.sparkles, color: theme.colors.primary, size: 20),
            SizedBox(width: theme.spacing.sm),
            Text('Aura Social Node', style: theme.typography.h4),
          ],
        ),
        SizedBox(height: theme.spacing.md),
        if (insights.isEmpty)
          Text(
            'No AI insights detected at this cycle.',
            style: theme.typography.bodySmall,
          )
        else
          ...insights.map(
            (i) => Padding(
              padding: EdgeInsets.only(bottom: theme.spacing.md),
              child: IntelligenceInsightCard(insight: i),
            ),
          ),
      ],
    );
  }

  Widget _buildEventLedger(PrimeCareThemeData theme, DashboardMetrics metrics) {
    return PrimeCareCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.dashboards_common_labels_social_event_ledger.tr(),
                  style: theme.typography.h4,
                ),
                SizedBox(height: theme.spacing.xs),
                Text(
                  LocaleKeys
                      .dashboards_common_labels_real_time_feed_of_patient_interactions_and_linkage_events
                      .tr(),
                  style: theme.typography.labelMedium,
                ),
              ],
            ),
          ),
          ...metrics.recentActivity.map(
            (activity) => Column(
              children: [
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getActivityColor(
                        activity.color,
                        theme,
                      ).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getActivityIcon(activity.icon),
                      color: _getActivityColor(activity.color, theme),
                      size: 18,
                    ),
                  ),
                  title: Text(
                    activity.title,
                    style: theme.typography.labelLarge,
                  ),
                  subtitle: Text(
                    activity.subtitle,
                    style: theme.typography.bodySmall,
                  ),
                  trailing: Text(
                    activity.timestamp,
                    style: theme.typography.labelSmall,
                  ),
                ),
                if (activity != metrics.recentActivity.last)
                  Divider(
                    height: 1,
                    indent: 72,
                    color: theme.colors.border.withValues(alpha: 0.5),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityColor(String? color, PrimeCareThemeData theme) {
    switch (color) {
      case 'green':
        return theme.colors.success;
      case 'blue':
        return theme.colors.primary;
      case 'orange':
        return theme.colors.warning;
      case 'red':
        return theme.colors.error;
      default:
        return theme.colors.textSecondary;
    }
  }

  IconData _getActivityIcon(String? icon) {
    switch (icon) {
      case 'users':
        return LucideIcons.users;
      case 'check-circle':
        return LucideIcons.checkCircle;
      case 'map-pin':
        return LucideIcons.mapPin;
      case 'alert-circle':
        return LucideIcons.alertCircle;
      default:
        return LucideIcons.activity;
    }
  }
}

class SocialWorkerDashboardIntent extends PrimeCareScreen {
  SocialWorkerDashboardIntent() : super(title: 'SocialWorkerDashboard');

  @override
  Widget build(BuildContext context) => const SocialWorkerDashboardView();
}
