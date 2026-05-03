// @governance: id=SCREEN_OPERATIONS_MANAGER_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Utilization Score)
// @governance: component=Logistics KPI Grid
// @governance: component=Resource Allocation Map
// @governance: component=Efficiency DashboardMetrics
class OperationsManagerDashboardView extends ConsumerWidget {
  const OperationsManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(operationsManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as OperationsManagerDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(marketingManagerControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(marketingManagerControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    OperationsManagerDashboardViewModel viewModel,
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
                  if (viewModel.isOfflineFallback) const OfflineStatusChip(),
                ],
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          _buildOpsContinuitySummary(context, theme),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildInventoryDistribution(context, theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildMaintenanceLog(context, theme),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpsContinuitySummary(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OPERATIONAL CONTINUITY SCORE',
                  style: theme.typography.label.copyWith(
                    color: theme.colors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                Text('Status: Highly Stable', style: theme.typography.h1),
                SizedBox(height: theme.spacing.xs),
                Text(
                  'Facility uptime is at 99.8%. Supply chain routes are optimized with no critical shortages detected in the last 48 hours.',
                  style: theme.typography.bodyLarge.copyWith(
                    color: theme.colors.slateGray,
                  ),
                ),
              ],
            ),
          ),
          _buildGauge(theme, 0.99, 'System Uptime'),
        ],
      ),
    );
  }

  Widget _buildGauge(PrimeCareThemeData theme, double value, String label) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 12,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: theme.colors.success,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                PrimeCareFormatters.formatPercentage(value),
                style: theme.typography.h2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(label, style: theme.typography.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryDistribution(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key Inventory Categories', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildInventoryRow(
            theme,
            'Medical Consumables',
            0.88,
            theme.colors.primary,
          ),
          _buildInventoryRow(
            theme,
            'Pharmaceutical Stock',
            0.95,
            theme.colors.success,
          ),
          _buildInventoryRow(
            theme,
            'PPE & Safety Gear',
            0.62,
            theme.colors.warning,
          ),
          _buildInventoryRow(
            theme,
            'Sanitization Supplies',
            0.78,
            theme.colors.primary,
          ),
          _buildInventoryRow(
            theme,
            'Facility Spares',
            0.45,
            theme.colors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryRow(
    PrimeCareThemeData theme,
    String category,
    double level,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                category,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                ' ${PrimeCareFormatters.formatPercentage(level)} Stock',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: level,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceLog(BuildContext context, PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Facility Maintenance', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildLogItem(
            theme,
            'HVAC Periodic Service',
            'In Progress',
            LucideIcons.wind,
            theme.colors.primary,
          ),
          const Divider(),
          _buildLogItem(
            theme,
            'Generator Test',
            'Completed',
            LucideIcons.zap,
            theme.colors.success,
          ),
          const Divider(),
          _buildLogItem(
            theme,
            'Elevator Repair (West)',
            'Urgent',
            LucideIcons.arrowUpCircle,
            theme.colors.error,
          ),
          const Divider(),
          _buildLogItem(
            theme,
            'IT Node Migration',
            'Scheduled',
            LucideIcons.server,
            theme.colors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(
    PrimeCareThemeData theme,
    String task,
    String status,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(theme.spacing.sm),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: theme.spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task,
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status,
                style: theme.typography.labelSmall.copyWith(color: color),
              ),
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

class OperationsManagerDashboardIntent extends PrimeCareScreen {
  static const kName = 'operations-manager-dashboard';
  static const kRoute = '/offices/corporate/roles/operations-manager/dashboard';

  @override
  String get title => LocaleKeys.operations_manager_dashboard_title;

  @override
  PlatformRole get requiredRole => PlatformRole.operationsManager;

  @override
  PrimeCareForm get form => PrimeCareForm.operationsManagerDashboard;

  OperationsManagerDashboardIntent()
      : super(
          name: kName,
          title: LocaleKeys.operations_manager_dashboard_title,
          route: kRoute,
          requiredRole: PlatformRole.operationsManager,
          form: PrimeCareForm.operationsManagerDashboard,
          provider: operationsManagerDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Utilization Score)',
            'Logistics KPI Grid',
            'Resource Allocation Map',
            'Efficiency Dynamics',
          ],
        );

  @override
  Widget build(BuildContext context) => const OperationsManagerDashboardView();
}
