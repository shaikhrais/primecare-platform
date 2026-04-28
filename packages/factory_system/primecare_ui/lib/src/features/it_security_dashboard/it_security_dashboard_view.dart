// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class ITSecurityDashboardView extends ConsumerWidget {
  const ITSecurityDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(itSecurityDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(itSecurityDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(itSecurityDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ITSecurityDashboardViewModel vm,
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
                  Text('Cyber Shield Command', style: theme.typography.h2),
                  Text(
                    'Real-time threat telemetry and system integrity surveillance',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          // Command HUD
          Row(
            children: [
              PrimeCareChip(label: 'Threat Scan', onPressed: () {}),
              SizedBox(width: theme.spacing.sm),
              PrimeCareChip(label: 'Rotate Keys', onPressed: () {}),
              SizedBox(width: theme.spacing.sm),
              PrimeCareChip(label: 'Purge Cache', onPressed: () {}),
              const Spacer(),
              PrimeCareChip(
                label: 'Emergency Lockdown',
                color: theme.colors.error,
                onPressed: () {},
              ),
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
                    PrimeCareChartCard(
                      title: LocaleKeys
                          .dashboards_common_labels_security_matrix__block_velocity
                          .tr(),
                      chart: PrimeCareLineChart(
                        chart: AnalyticsChart(
                          id: 'block-velocity',
                          title: LocaleKeys
                              .dashboards_common_labels_block_velocity
                              .tr(),
                          type: ChartType.line,
                          dataPoints: [
                            ChartDataPoint(label: '00:00', value: 45),
                            ChartDataPoint(label: '04:00', value: 52),
                            ChartDataPoint(label: '08:00', value: 48),
                            ChartDataPoint(label: '12:00', value: 61),
                            ChartDataPoint(label: '16:00', value: 55),
                            ChartDataPoint(label: '20:00', value: 68),
                            ChartDataPoint(label: '23:59', value: 72),
                          ],
                        ),
                        lineColor: Colors.cyanAccent,
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    PrimeCareSectionHeader(
                      title: LocaleKeys
                          .dashboards_common_labels_security_audit_trail
                          .tr(),
                    ),
                    SizedBox(height: theme.spacing.md),
                    PrimeCareDataTable<dynamic>(
                      columns: const ['Timestamp', 'Event', 'Origin', 'Status'],
                      rows:
                          [
                                [
                                  '10:45 AM',
                                  'SSL Handshake Success',
                                  'ONT-NODE-04',
                                  'Verified',
                                ],
                                [
                                  '10:42 AM',
                                  'Brute Force Blocked',
                                  '192.168.1.104',
                                  'Neutralized',
                                ],
                                [
                                  '10:38 AM',
                                  'Kernel Patch Applied',
                                  'SYS-CORE-01',
                                  'Success',
                                ],
                                [
                                  '10:35 AM',
                                  'Key Rotation Scheduled',
                                  'SYSTEM',
                                  'Pending',
                                ],
                              ]
                              .map(
                                (row) => DataRow(
                                  cells: row
                                      .map((cell) => DataCell(Text(cell)))
                                      .toList(),
                                ),
                              )
                              .toList(),
                    ),
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

class ITSecurityDashboardIntent extends PrimeCareScreen {
  ITSecurityDashboardIntent() : super(title: 'ITSecurityDashboard');

  @override
  Widget build(BuildContext context) => const ITSecurityDashboardView();
}
