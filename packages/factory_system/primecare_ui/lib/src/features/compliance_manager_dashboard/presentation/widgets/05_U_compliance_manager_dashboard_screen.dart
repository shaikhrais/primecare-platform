// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceManagerDashboardScreen extends ConsumerWidget {
  const ComplianceManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(complianceManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        onRetry: () => ref.refresh(complianceManagerDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ComplianceManagerDashboardViewModel vm,
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
                    'Compliance & Regulatory Hub',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Audit completion, risk exposure, and regulatory alert telemetry',
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
                    _buildAuditPerformance(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildRiskMatrix(theme),
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

  Widget _buildAuditPerformance(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Audit Completion Velocity', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Real-time Audit Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Regulatory Risk Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Risk Heatmap Synchronization Complete',
              style: TextStyle(fontStyle: FontStyle.italic),
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
        Text('Aura Intelligence', style: theme.typography.h4),
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
