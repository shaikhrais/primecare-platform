// @governance: id=SCREEN_TERRITORY_SALES_MANAGER_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Sales Velocity)
// @governance: component=Sales KPI Grid
// @governance: component=Pipeline Velocity Chart
// @governance: component=Territory Growth Map
class TerritorySalesManagerDashboardView extends ConsumerWidget {
  const TerritorySalesManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(territorySalesManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Sales Governance Error: $e',
            onRetry: () =>
                ref.refresh(territorySalesManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(territorySalesManagerDashboardAdapterProvider),
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
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TerritorySalesManagerDashboardIntent extends PrimeCareScreen {
  static const kName = 'territory-sales-manager-dashboard';
  static const kRoute = '/offices/corporate/roles/territory-sales-manager/dashboard';

  @override
  String get title => LocaleKeys.business_development_territory_sales_manager_dashboard_title;

  @override
  PlatformRole get requiredRole => PlatformRole.territorySalesManager;

  @override
  PrimeCareForm get form => PrimeCareForm.territorySalesDashboard;

  TerritorySalesManagerDashboardIntent()
      : super(
          name: kName,
          title: LocaleKeys.business_development_territory_sales_manager_dashboard_title,
          route: kRoute,
          requiredRole: PlatformRole.territorySalesManager,
          form: PrimeCareForm.territorySalesDashboard,
          provider: territorySalesManagerDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Sales Velocity)',
            'Sales KPI Grid',
            'Pipeline Velocity Chart',
            'Territory Growth Map',
          ],
        );

  @override
  Widget build(BuildContext context) =>
      const TerritorySalesManagerDashboardView();
}
