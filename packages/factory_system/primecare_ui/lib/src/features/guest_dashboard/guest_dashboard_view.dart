// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

    hide isOnlineProvider, ProviderTTL;

class GuestDashboardView extends ConsumerWidget {
  const GuestDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(guestDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(guestDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(guestDashboardAdapterProvider),
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
          Text(LocaleKeys.guest_dashboard_title.tr(), style: theme.typography.h2),
          Text(
            LocaleKeys.guest_dashboard_subtitle.tr(),
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

class GuestDashboardIntent extends PrimeCareScreen {
  GuestDashboardIntent()
      : super(
          name: 'guest_dashboard',
          title: LocaleKeys.guest_dashboard_title,
          route: '/portal/guest/dashboard',
          requiredRole: PlatformRole.guest,
          form: PrimeCareForm.guestDashboard,
          provider: guestDashboardAdapterProvider,
          componentLabels: const ['Aura HUD', 'Welcome Module', 'Service Explorer', 'Self-Guided Intake'],
        );

  @override
  Widget build(BuildContext context) => const GuestDashboardView();
}
