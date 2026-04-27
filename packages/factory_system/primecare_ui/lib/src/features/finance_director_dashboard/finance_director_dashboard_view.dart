import 'package:primecare_ui/primecare_ui.dart';
import 'finance_director_dashboard_controller.dart';
import 'finance_director_dashboard_model.dart';

class FinanceDirectorDashboardView extends ConsumerWidget {
  const FinanceDirectorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(financeDirectorDashboardAdapterProvider);
    final controller = ref.read(financeDirectorDashboardAdapterProvider.notifier);

    return MasterLayout(
      shellType: AppShellType.admin,
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
    FinanceDirectorDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme, vm),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          _buildInsightsSection(context, theme, vm),
          SizedBox(height: theme.spacing.xl),
          _buildActionGrid(theme),
          if (vm.isOfflineFallback) ...[
            SizedBox(height: theme.spacing.xl),
            _buildOfflineWarning(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(
    PrimeCareThemeData theme,
    FinanceDirectorDashboardViewModel vm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treasury Command',
          style: theme.typography.h1.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -1.0,
          ),
        ),
        SizedBox(height: theme.spacing.xs),
        Text(
          'Institutional Ledger • Sovereign Oversight',
          style: theme.typography.bodyLarge.copyWith(
            color: theme.colors.slate400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightsSection(
    BuildContext context,
    PrimeCareThemeData theme,
    FinanceDirectorDashboardViewModel vm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Financial Intelligence', style: theme.typography.h3),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          backgroundColor: theme.colors.surfaceContainerLow,
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: vm.insights.isEmpty
                ? [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'AI is analyzing your ledger. No critical anomalies detected.',
                        ),
                      ),
                    ),
                  ]
                : vm.insights
                      .map(
                        (insight) => DashboardInsightRow(
                          title: insight.title.translate(context),
                          description: insight.summary.translate(context),
                          type: insight.type.name,
                        ),
                      )
                      .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionGrid(PrimeCareThemeData theme) {
    final actions = [
      {'label': 'P&L Report', 'icon': LucideIcons.fileText},
      {'label': 'Tax Remittance', 'icon': LucideIcons.shieldCheck},
      {'label': 'Adjust Budget', 'icon': LucideIcons.sliders},
      {'label': 'Audit Logs', 'icon': LucideIcons.history},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Executive Actions', style: theme.typography.h3),
        SizedBox(height: theme.spacing.lg),
        Wrap(
          spacing: theme.spacing.md,
          runSpacing: theme.spacing.md,
          children: actions.map((action) {
            return PrimeCareButton(
              type: PrimeCareButtonType.secondary,
              onPressed: () {},
              icon: action['icon'] as IconData,
              label: action['label'] as String,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildOfflineWarning(PrimeCareThemeData theme) {
    return Container(
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: theme.colors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(theme.radii.radiusSm),
        border: Border.all(color: theme.colors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wifiOff, color: theme.colors.error, size: 16),
          SizedBox(width: theme.spacing.sm),
          Text(
            'Viewing LKG Snapshot. Some metrics may be stale.',
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.error,
            ),
          ),
        ],
      ),
    );
  }
}

class FinanceDirectorDashboardIntent extends PrimeCareScreen {
  FinanceDirectorDashboardIntent() : super(title: "FinanceDirectorDashboard");

  @override
  Widget build(BuildContext context) => const FinanceDirectorDashboardView();
}


