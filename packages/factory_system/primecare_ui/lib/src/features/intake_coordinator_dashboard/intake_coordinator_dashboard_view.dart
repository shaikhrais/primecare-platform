import 'package:primecare_ui/primecare_ui.dart';
import 'intake_coordinator_dashboard_controller.dart';
import 'intake_coordinator_dashboard_model.dart';

class IntakeCoordinatorDashboardView extends ConsumerWidget {
  const IntakeCoordinatorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(intakeCoordinatorDashboardAdapterProvider);
    final controller = ref.read(intakeCoordinatorDashboardAdapterProvider.notifier);

    return MasterLayout(
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
    IntakeCoordinatorDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Intake Coordinator Command Center', style: theme.typography.h2),
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
  IntakeCoordinatorDashboardIntent() : super(title: "IntakeCoordinatorDashboard");

  @override
  Widget build(BuildContext context) => const IntakeCoordinatorDashboardView();
}


