// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;



// @governance: component=Aura HUD (Total Active Intakes)
// @governance: component=Intake Funnel Chart
// @governance: component=Urgent Referral List
// @governance: component=Capacity Availability Grid
class IntakeCoordinatorDashboardView extends ConsumerWidget {
  const IntakeCoordinatorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(intakeCoordinatorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () =>
                ref.refresh(intakeCoordinatorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(intakeCoordinatorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    IntakeCoordinatorDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.intake_dashboard_title.tr(),
            style: theme.typography.h2,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            LocaleKeys.intake_dashboard_subtitle.tr(),
            style: theme.typography.bodyLarge.copyWith(
              color: theme.colors.textSecondary,
            ),
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
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

class IntakeCoordinatorDashboardIntent extends PrimeCareScreen {
  IntakeCoordinatorDashboardIntent()
      : super(
          name: 'intake-coordinator',
          title: LocaleKeys.intake_dashboard_title,
          route: '/offices/clinical/roles/intake-coordinator/dashboard',
          requiredRole: PlatformRole.intakeCoordinator,
          form: PrimeCareForm.intakeCoordinatorDashboard,
          provider: intakeCoordinatorDashboardAdapterProvider,
          componentLabels: [
            'Aura HUD (Total Active Intakes)',
            'Intake Funnel Chart',
            'Urgent Referral List',
            'Capacity Availability Grid',
          ],
        );

  @override
  Widget build(BuildContext context) => const IntakeCoordinatorDashboardView();
}
