// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A specialized institutional dashboard for monitoring real-time structural compliance
/// across the entire PrimeCare platform.
class CorporateGovernanceDashboardScreen extends ConsumerWidget {
  const CorporateGovernanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(corporateGovernanceDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, ref, theme, viewModel),
        loading: () => const DashboardLoadingWidget(),
        error: (Object e, StackTrace st) => DashboardErrorWidget(
          message: 'Telemetry Exception: $e',
          onRetry: () =>
              ref.refresh(corporateGovernanceDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    PrimeCareThemeData theme,
    CorporateGovernanceDashboardViewModel vm,
  ) {
    final auditReports = ScreenRegistry.auditRegistry();
    final healthyCount = auditReports.where((r) => r.isHealthy).length;
    final totalCount = auditReports.length;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (vm.isOfflineFallback)
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: PrimeCareBanner(
                message:
                    'Viewing cached governance snapshots. Real-time audit suspended.',
                type: BannerType.warning,
              ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Institutional Integrity HUD',
                        style: theme.typography.h1,
                      ),
                      const SizedBox(width: 16),
                      const PrimeCareStatusBadge(
                        label: 'Registry Healthy',
                        type: BadgeType.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Global platform governance, architectural compliance, and structural audit',
                    style: theme.typography.labelLarge.copyWith(
                      color: theme.colors.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.shieldCheck,
                      size: 16,
                      color: theme.colors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text('V4 Compliant', style: theme.typography.labelBold),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Command Row
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              PrimeCareChip(
                label: 'Audit Registry',
                // icon: LucideIcons.search,
                onPressed: () => ScreenRegistry.auditRegistry(),
                color: theme.colors.primary,
              ),
              PrimeCareChip(
                label: 'Fix Drift',
                // icon: LucideIcons.wrench,
                onPressed: () => ref
                    .read(corporateGovernanceDashboardAdapterProvider.notifier)
                    .triggerRemediation(),
                color: theme.colors.warning,
              ),
              PrimeCareChip(
                label: 'Update Blueprints',
                // icon: LucideIcons.fileEdit,
                onPressed: () {},
                color: theme.colors.info,
              ),
            ],
          ),
          const SizedBox(height: 32),

          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          const SizedBox(height: 32),

          if (vm.insights.isNotEmpty) ...[
            Text('Governance Intelligence', style: theme.typography.h3),
            const SizedBox(height: 16),
            ...vm.insights.map(
              (insight) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: IntelligenceInsightCard(insight: insight),
              ),
            ),
            const SizedBox(height: 32),
          ],

          if (vm.metrics.charts.isNotEmpty) ...[
            Text('Integrity Analytics', style: theme.typography.h3),
            const SizedBox(height: 16),
            ...vm.metrics.charts.map(
              (AnalyticsChart chart) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: PrimeCareChartCard(
                  title: chart.title,
                  chart: PrimeCareLineChart(chart: chart),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],

          Text('Structural Integrity Audit Log', style: theme.typography.h3),
          const SizedBox(height: 4),
          Text(
            'Real-time audit of $totalCount routes ($healthyCount verified)',
            style: theme.typography.labelMedium.copyWith(
              color: theme.colors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          PrimeCareDataTable(
            columns: const ['Role Path', 'Status', 'Message', 'Drift Details'],
            data: auditReports,
            rowBuilder: (report) {
              return [
                DataCell(
                  Text(report.route, style: theme.typography.labelSmall),
                ),
                DataCell(
                  PrimeCareStatusBadge(
                    label: report.isHealthy ? 'Verified' : 'Drifted',
                    type: report.isHealthy
                        ? BadgeType.success
                        : BadgeType.danger,
                  ),
                ),
                DataCell(
                  Text(
                    report.isHealthy ? 'Compliant' : report.message,
                    style: theme.typography.labelSmall.copyWith(
                      color: report.isHealthy
                          ? theme.colors.success
                          : theme.colors.error,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    !report.isHealthy && report.compliance != null
                        ? 'Missing: ${report.compliance!.missingLabels.join(", ")}'
                        : 'N/A',
                    style: theme.typography.labelSmall.copyWith(
                      color: theme.colors.textSecondary,
                    ),
                  ),
                ),
              ];
            },
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}
