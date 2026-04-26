import 'package:primecare_ui/primecare_ui.dart';

/// Target 132: IT Security Dashboard (UI Remediate)
/// A high-fidelity security HUD featuring real-time threat telemetry,
/// cyber-shield metrics, and automated lockdown controls.
class ITSecurityDashboardScreen extends ConsumerWidget {
  const ITSecurityDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(itSecurityDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        onRetry: () => ref.refresh(itSecurityDashboardAdapterProvider),
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
                      title: 'Security Matrix: Block Velocity',
                      chart: PrimeCareLineChart(
                        chart: AnalyticsChart(
                          id: 'block-velocity',
                          title: 'Block Velocity',
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
                    const PrimeCareSectionHeader(title: 'Security Audit Trail'),
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
        Text(LocaleKeys.dashboards_common_labels_aura_intelligence.tr(), style: theme.typography.h4),
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
