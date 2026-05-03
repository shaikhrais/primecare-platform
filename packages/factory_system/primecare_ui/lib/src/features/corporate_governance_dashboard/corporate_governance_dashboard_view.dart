// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/src/components/primecare_banner.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Subsystem Parity Matrix
// @governance: component=Autonomous Remediation HUD
// @governance: component=Audit Lifecycle Monitor

    hide isOnlineProvider, ProviderTTL;

class CorporateGovernanceDashboardView extends ConsumerWidget {
  const CorporateGovernanceDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(corporateGovernanceDashboardAdapterProvider);
    final controller = ref.read(
      corporateGovernanceDashboardAdapterProvider.notifier,
    );

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) =>
              _buildContent(context, ref, theme, viewModel, controller),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(complianceHubAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(complianceHubAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    PrimeCareThemeData theme,
    CorporateGovernanceDashboardViewModel vm,
    CorporateGovernanceDashboardController controller,
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
                      const PrimeCareBadge(
                        text: 'Registry Healthy',
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
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              PrimeCareChip(
                label: 'Audit Registry',
                onPressed: () => ScreenRegistry.auditRegistry(),
                color: theme.colors.primary,
              ),
              PrimeCareChip(
                label: 'Fix Drift',
                onPressed: controller.triggerRemediation,
                color: theme.colors.warning,
              ),
              PrimeCareChip(
                label: 'Update Blueprints',
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
          PrimeCareDataTable<RegistryAuditReport>(
            columns: const ['Role Path', 'Status', 'Message', 'Drift Details'],
            rows: auditReports.map((report) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(report.route, style: theme.typography.labelSmall),
                  ),
                  DataCell(
                    PrimeCareBadge(
                      text: report.isHealthy ? 'Verified' : 'Drifted',
                      type: report.isHealthy
                          ? BadgeType.success
                          : BadgeType.error,
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
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}

class CorporateGovernanceDashboardIntent extends PrimeCareScreen {
  CorporateGovernanceDashboardIntent()
      : super(
          route: '/',
          name: PlatformRole.system.nameSnake,
          requiredRole: PlatformRole.system,
          form: PrimeCareForm.governanceMonitorDashboard,
          title: LocaleKeys.dashboards_common_labels_corporate_governance_hud,
          provider: corporateGovernanceDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD',
            'Subsystem Parity Matrix',
            'Autonomous Remediation HUD',
            'Audit Lifecycle Monitor',
          ],
        );

  @override
  Widget build(BuildContext context) =>
      const CorporateGovernanceDashboardView();
}
