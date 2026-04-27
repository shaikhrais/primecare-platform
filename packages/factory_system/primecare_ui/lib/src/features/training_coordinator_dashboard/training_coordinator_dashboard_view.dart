import 'package:primecare_ui/primecare_ui.dart';
import 'training_coordinator_dashboard_controller.dart';
import 'training_coordinator_dashboard_model.dart';

class TrainingCoordinatorDashboardView extends ConsumerWidget {
  const TrainingCoordinatorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(trainingCoordinatorDashboardAdapterProvider);
    final controller = ref.read(trainingCoordinatorDashboardAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'Training Governance Error: $e',
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
    TrainingCoordinatorDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Training Coordinator Command Center',
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

class TrainingCoordinatorDashboardIntent extends PrimeCareScreen {
  TrainingCoordinatorDashboardIntent() : super(title: "TrainingCoordinatorDashboard");

  @override
  Widget build(BuildContext context) => const TrainingCoordinatorDashboardView();
}


