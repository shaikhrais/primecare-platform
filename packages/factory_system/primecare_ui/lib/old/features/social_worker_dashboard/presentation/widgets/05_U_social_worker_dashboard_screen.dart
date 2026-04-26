// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// Target 212: Social Worker Dashboard (UI Remediate)
/// High-fidelity dashboard for the Social Worker.
/// Hydrates real-time field intelligence and Aura AI psychosocial modeling.
class SocialWorkerDashboardScreen extends ConsumerWidget {
  SocialWorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final state = ref.watch(socialWorkerDashboardAdapterProvider);

    return PrimeCareScaffold(
      backgroundColor: theme.colors.background,
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
            child: state.whenResult(
              (viewModel) =>
                  _buildHydratedDashboard(context, theme, viewModel, ref),
              loading: () => const DashboardLoadingWidget(),
              error: (e, st) => DashboardErrorWidget(
                message: 'Field Intelligence Failure: $e',
                onRetry: () =>
                    ref.refresh(socialWorkerDashboardAdapterProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHydratedDashboard(
    BuildContext context,
    PrimeCareThemeData theme,
    SocialWorkerDashboardViewModel viewModel,
    WidgetRef ref,
  ) {
    final metrics = viewModel.metrics;
    final insights = viewModel.insights;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Command Hub: Social Actions
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                PrimeCareChip(
                  label: 'Add Client',
                  icon: LucideIcons.userPlus,
                  onPressed: () =>
                      ref.read(socialWorkerActionHandler)('BTN_ADD_CLIENT'),
                  color: theme.colors.primary,
                ),
                SizedBox(width: theme.spacing.sm),
                PrimeCareChip(
                  label: 'Crisis Override',
                  icon: LucideIcons.alertCircle,
                  onPressed: () => ref.read(socialWorkerActionHandler)(
                    'BTN_CRISIS_OVERRIDE',
                  ),
                  color: theme.colors.error,
                ),
                SizedBox(width: theme.spacing.sm),
                PrimeCareChip(
                  label: 'Community Map',
                  icon: LucideIcons.mapPin,
                  onPressed: () =>
                      ref.read(socialWorkerActionHandler)('BTN_MAP_RESOURCE'),
                ),
                SizedBox(width: theme.spacing.sm),
                PrimeCareChip(
                  label: 'Escalate Case',
                  icon: LucideIcons.shield,
                  onPressed: () =>
                      ref.read(socialWorkerActionHandler)('BTN_ESCALATE_CASE'),
                ),
              ],
            ),
          ),
          SizedBox(height: theme.spacing.xl),

          // Core Field Intelligence Grid
          Text(
            'Social Care Health Pulse',
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: theme.spacing.md),
          PrimeCareResponsiveKpiGrid(metrics: metrics),
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
                        _buildMainChart(theme, metrics),
                        SizedBox(height: theme.spacing.xl),
                        _buildEventLedger(theme, metrics),
                      ],
                    ),
                  ),
                  if (isWide) ...[
                    SizedBox(width: theme.spacing.xl),
                    Expanded(
                      flex: 2,
                      child: _buildAuraInsightsColumn(theme, insights),
                    ),
                  ],
                ],
              );
            },
          ),

          // Mobile Insights (shown if not wide)
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 1000) {
                return Column(
                  children: [
                    SizedBox(height: theme.spacing.xl),
                    _buildAuraInsightsColumn(theme, insights),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainChart(PrimeCareThemeData theme, DashboardMetrics metrics) {
    final chart = metrics.charts.firstWhere(
      (c) => c.id == 'intervention-dynamics',
      orElse: () => AnalyticsChart(
        id: 'placeholder',
        title: LocaleKeys.dashboards_common_labels_intervention_impact_analysis
            .tr(),
        type: ChartType.line,
        dataPoints: [],
      ),
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
          Column(
            children: insights
                .map(
                  (i) => Padding(
                    padding: EdgeInsets.only(bottom: theme.spacing.md),
                    child: IntelligenceInsightCard(insight: i),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _buildEventLedger(PrimeCareThemeData theme, DashboardMetrics metrics) {
    return PrimeCareCard(
      title: LocaleKeys.dashboards_common_labels_social_event_ledger.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_real_time_feed_of_patient_interactions_and_linkage_events
          .tr(),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
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
