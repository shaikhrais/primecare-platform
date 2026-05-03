// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

    hide isOnlineProvider, ProviderTTL;

class DynamicScreenDashboardView extends ConsumerWidget {
  const DynamicScreenDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(dynamicScreenDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(cxDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(crmFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    DashboardMetrics metrics,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.dynamic_screen_dashboard_title.tr(),
            style: theme.typography.h2,
          ),
          Text(
            LocaleKeys.dynamic_screen_dashboard_subtitle.tr(),
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DynamicScreenDashboardIntent extends PrimeCareScreen {
  DynamicScreenDashboardIntent()
      : super(
          name: 'dynamic_screen_dashboard',
          title: LocaleKeys.dynamic_screen_dashboard_title,
          route: '/infrastructure/dynamic-screen',
          requiredRole: PlatformRole.dynamicScreen,
          form: PrimeCareForm.dynamicRoleDashboard,
          provider: dynamicScreenDashboardAdapterProvider,
          componentLabels: const ['Aura HUD', 'Widget Factory HUD', 'Screen Layout Architect', 'Style Token Monitor'],
        );

  @override
  Widget build(BuildContext context) => const DynamicScreenDashboardView();
}
