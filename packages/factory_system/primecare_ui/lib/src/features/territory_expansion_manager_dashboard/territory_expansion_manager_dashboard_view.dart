// @governance: id=SCREEN_TERRITORY_EXPANSION_MANAGER_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Expansion Roadmap)
// @governance: component=Geographic Vetting Map
// @governance: component=Site Viability Scorecard
// @governance: component=Research Log
class TerritoryExpansionManagerDashboardView extends ConsumerWidget {
  const TerritoryExpansionManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch<AsyncValue<Result<TerritoryExpansionManagerDashboardViewModel>>>(territoryExpansionManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (Result<TerritoryExpansionManagerDashboardViewModel> result) => result.fold(
          (TerritoryExpansionManagerDashboardViewModel viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Expansion Governance Error: $e',
            onRetry: () =>
                ref.refresh(territoryExpansionManagerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(territoryExpansionManagerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TerritoryExpansionManagerDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Territory Expansion Manager Command Center',
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

class TerritoryExpansionManagerDashboardIntent extends PrimeCareScreen {
  static const kName = 'territory-expansion-manager-dashboard';
  static const kRoute = '/offices/corporate/roles/territory-expansion-manager/dashboard';

  @override
  String get title => LocaleKeys.business_development_territory_expansion_manager_dashboard_title;

  @override
  PlatformRole get requiredRole => PlatformRole.territoryExpansionManager;

  @override
  PrimeCareForm get form => PrimeCareForm.territoryExpansionDashboard;

  TerritoryExpansionManagerDashboardIntent()
      : super(
          name: kName,
          title: LocaleKeys.business_development_territory_expansion_manager_dashboard_title,
          route: kRoute,
          requiredRole: PlatformRole.territoryExpansionManager,
          form: PrimeCareForm.territoryExpansionDashboard,
          provider: territoryExpansionManagerDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Expansion Roadmap)',
            'Geographic Vetting Map',
            'Site Viability Scorecard',
            'Research Log',
          ],
        );

  @override
  Widget build(BuildContext context) =>
      const TerritoryExpansionManagerDashboardView();
}
