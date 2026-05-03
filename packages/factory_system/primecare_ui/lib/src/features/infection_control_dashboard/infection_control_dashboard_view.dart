// @governance: id=SCREEN_INFECTION_CONTROL_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Infection Velocity)
// @governance: component=Transmission Trend
// @governance: component=Outbreak Monitoring Grid
// @governance: component=Immunization Tracker
class InfectionControlDashboardView extends ConsumerWidget {
  const InfectionControlDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(infectionControlDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () =>
                ref.refresh(infectionControlDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(infectionControlDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    InfectionControlDashboardViewModel vm,
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
                  Text('Public Health Hub', style: theme.typography.h2),
                  Text(
                    'Infection telemetry, outbreak tracking, and immunization status',
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
                    InfectionTelemetryHeatmap(
                      chart: vm.metrics.charts.firstWhere(
                        (c) => c.id == 'infection-telemetry',
                        orElse: () => AnalyticsChart.empty(),
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    const OutbreakStatusGrid(),
                    SizedBox(height: theme.spacing.xl),
                    const InfectionActionHub(),
                  ],
                ),
              ),
              if (vm.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(child: _buildAuraInsightsColumn(theme, vm.insights)),
              ],
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

class InfectionTelemetryHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const InfectionTelemetryHeatmap({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Infection Telemetry', style: theme.typography.h3),
              const PrimeCareBadge(text: 'LIVE', type: BadgeType.info),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          AspectRatio(
            aspectRatio: 1.7,
            child: PrimeCareLineChart(chart: chart),
          ),
        ],
      ),
    );
  }
}

class OutbreakStatusGrid extends StatelessWidget {
  const OutbreakStatusGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Active Outbreak Monitoring', style: theme.typography.h3),
        SizedBox(height: theme.spacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 768 ? 2 : 1;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: theme.spacing.md,
              crossAxisSpacing: theme.spacing.md,
              childAspectRatio: 3,
              children: [
                _buildOutbreakCard(
                  context,
                  'Unit 4B - Influenza',
                  'Confirmed: 3 | Suspected: 5',
                  'QUARANTINE',
                  theme.colors.error,
                ),
                _buildOutbreakCard(
                  context,
                  'Sector 7 - MRSA',
                  'Confirmed: 1 | Suspected: 2',
                  'MONITORED',
                  theme.colors.warning,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildOutbreakCard(
    BuildContext context,
    String title,
    String subtitle,
    String tag,
    Color color,
  ) {
    final theme = context.theme;
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Row(
        children: [
          Container(
            width: 4,
            height: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: theme.typography.labelLarge),
                Text(subtitle, style: theme.typography.labelSmall),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
              vertical: theme.spacing.xs,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              tag,
              style: theme.typography.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfectionActionHub extends StatelessWidget {
  const InfectionActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Expanded(
          child: PrimeCareButton(
            label: 'Report Outbreak',
            onPressed: () {},
            type: PrimeCareButtonType.primary,
            icon: LucideIcons.alertTriangle,
          ),
        ),
        SizedBox(width: theme.spacing.md),
        Expanded(
          child: PrimeCareButton(
            label: 'Audit PPE',
            onPressed: () {},
            type: PrimeCareButtonType.secondary,
            icon: LucideIcons.shieldCheck,
          ),
        ),
      ],
    );
  }
}

class InfectionControlDashboardIntent extends PrimeCareScreen {
  InfectionControlDashboardIntent()
      : super(
          name: 'SCREEN_INFECTION_CONTROL_DASHBOARD',
          title: LocaleKeys.clinical_infection_control_dashboard_title,
          route: ClinicalRoutes.infectionControlDashboard,
          requiredRole: PlatformRole.clinicalDirector,
          provider: infectionControlDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Infection Velocity)',
            'Transmission Trend',
            'Outbreak Monitoring Grid',
            'Immunization Tracker',
          ],
        );

  @override
  Widget build(BuildContext context) => const InfectionControlDashboardView();
}
