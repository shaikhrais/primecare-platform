// @governance: id=SCREEN_REGIONAL_MANAGER_USA_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (US Expansion Velocity)
// @governance: component=Multi-state Revenue Grid
// @governance: component=USA Expansion Map
// @governance: component=Compliance Drift Log
class RegionalManagerUsaDashboardView extends ConsumerWidget {
  const RegionalManagerUsaDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalManagerUsaDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as RegionalManagerUsaDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'USA Governance Error: $e',
            onRetry: () =>
                ref.refresh(regionalManagerUsaDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(regionalManagerUsaDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalManagerUsaDashboardViewModel viewModel,
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
                    'Regional Command Center: USA',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Operational insights, KPI tracking, and regional telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
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

class RegionalManagerUsaDashboardIntent extends PrimeCareScreen {
  RegionalManagerUsaDashboardIntent()
    : super(
        name: 'SCREEN_REGIONAL_MANAGER_USA_DASHBOARD',
        title: LocaleKeys.business_development_regional_manager_usa_dashboard_title,
        route: '/regional-manager-usa-dashboard',
        requiredRole: PlatformRole.regionalManagerUsa,
        form: PrimeCareForm.regionalManagerUsaDashboard,
        provider: regionalManagerUsaDashboardAdapterProvider,
        componentLabels: const [
          'Aura HUD (US Expansion Velocity)',
          'Multi-state Revenue Grid',
          'USA Expansion Map',
          'Compliance Drift Log',
        ],
      );

  @override
  Widget build(BuildContext context) => const RegionalManagerUsaDashboardView();
}
