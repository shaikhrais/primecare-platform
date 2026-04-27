import 'package:primecare_ui/primecare_ui.dart';
import 'territory_sales_manager_dashboard_controller.dart';
import 'territory_sales_manager_dashboard_model.dart';

class TerritorySalesManagerDashboardView extends ConsumerWidget {
  const TerritorySalesManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(territorySalesManagerDashboardAdapterProvider);
    final controller = ref.read(territorySalesManagerDashboardAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'Sales Governance Error: $e',
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
    TerritorySalesManagerDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Territory Sales Manager Command Center',
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TerritorySalesManagerDashboardIntent extends PrimeCareScreen {
  TerritorySalesManagerDashboardIntent() : super(title: "TerritorySalesManagerDashboard");

  @override
  Widget build(BuildContext context) => const TerritorySalesManagerDashboardView();
}


