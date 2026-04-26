import 'package:primecare_ui/primecare_ui.dart';

class ShareholderIntelligenceScreen extends ConsumerWidget {
  const ShareholderIntelligenceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final viewModel = ref.watch(shareholderIntelligenceAdapterProvider);

    return MasterLayout(
      child: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(context, theme, viewModel.metrics),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    DashboardMetrics vm,
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
                  Text('Shareholder Intelligence & Feature Tracker',
                      style: theme.typography.h2),
                  Text(
                    'Real-time Telemetry & Governance Pipeline',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              _buildSyncButton(theme),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm),
          SizedBox(height: theme.spacing.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildPipelineBoard(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildTelemetryFeed(theme),
                  ],
                ),
              ),
              SizedBox(width: theme.spacing.xl),
              Expanded(
                child: _buildRoiMatrix(theme),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSyncButton(PrimeCareThemeData theme) {
    return PrimeCareButton(
      type: PrimeCareButtonType.secondary,
      onPressed: () {},
      icon: Icons.sync,
      label: 'Sync with Cloudflare',
    );
  }

  Widget _buildPipelineBoard(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Feature Pipeline Board', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          Row(
            children: [
              _buildKanbanColumn(
                  theme, 'Initial', ['new-franchise-analytics'], Colors.blue),
              _buildKanbanColumn(
                  theme, 'In Processing', ['intake-coordinator-v2'], Colors.orange),
              _buildKanbanColumn(
                  theme, 'Implemented', ['billing-admin-export'], Colors.teal),
              _buildKanbanColumn(
                  theme, 'Done', ['regional-manager-ontario'], Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanColumn(
    PrimeCareThemeData theme,
    String title,
    List<String> intents,
    Color accentColor,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: theme.spacing.xs),
        padding: EdgeInsets.all(theme.spacing.md),
        decoration: BoxDecoration(
          color: theme.colors.surfaceContainerHigh.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(theme.radii.md),
          border: Border(top: BorderSide(color: accentColor, width: 3)),
        ),
        child: Column(
          children: [
            Text(title,
                style: theme.typography.labelSmall
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: theme.spacing.md),
            ...intents.map((id) => Container(
                  margin: EdgeInsets.only(bottom: theme.spacing.sm),
                  padding: EdgeInsets.all(theme.spacing.sm),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radii.sm),
                  ),
                  child: Text(id,
                      style: theme.typography.bodySmall,
                      textAlign: TextAlign.center),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryFeed(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Real-Time Intent Telemetry', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          _buildTelemetryItem(
              theme, 'intake-coordinator-dashboard', 'ExecutionGateService', 'PASS'),
          _buildTelemetryItem(
              theme, 'regional-manager-ontario-dashboard', 'ExecutionGateService', 'PASS'),
        ],
      ),
    );
  }

  Widget _buildTelemetryItem(
      PrimeCareThemeData theme, String intent, String source, String status) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.md),
      child: Row(
        children: [
          Icon(Icons.bolt, color: theme.colors.primary, size: 16),
          SizedBox(width: theme.spacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(intent, style: theme.typography.labelBold),
                Text(source, style: theme.typography.labelSmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(theme.radii.sm),
            ),
            child: Text(status,
                style: theme.typography.labelSmall.copyWith(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  Widget _buildRoiMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      title: 'Platform ROI & Savings',
      child: Column(
        children: [
          _buildRoiRow(theme, 'Zero-Error Savings', '\$124k', Colors.blue),
          _buildRoiRow(theme, 'Registry Sync Efficiency', '94%', Colors.teal),
          _buildRoiRow(theme, 'Governance Parity', '100%', Colors.indigo),
          SizedBox(height: theme.spacing.lg),
          PrimeCareButton(
            type: PrimeCareButtonType.primary,
            onPressed: () {},
            label: 'Download Audit Report',
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRoiRow(
      PrimeCareThemeData theme, String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: theme.spacing.md),
          Text(label, style: theme.typography.bodyMedium),
          const Spacer(),
          Text(value,
              style: theme.typography.bodyBold.copyWith(color: color)),
        ],
      ),
    );
  }
}
