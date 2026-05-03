// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Training Velocity)
// @governance: component=Session Scheduling Grid
// @governance: component=Attendee Tracking
// @governance: component=Material Management

class TrainingCoordinatorDashboardView extends ConsumerWidget {
  const TrainingCoordinatorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(trainingCoordinatorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Training Governance Error: $e',
            onRetry: () =>
                ref.refresh(trainingCoordinatorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(trainingCoordinatorDashboardAdapterProvider),
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

class TrainingCoordinatorDashboardIntent extends PrimeCareScreen {
  TrainingCoordinatorDashboardIntent()
      : super(
          name: 'SCREEN_TRAINING_COORDINATOR_DASHBOARD',
          title: LocaleKeys.business_development_training_coordinator_dashboard_title,
          route: '/training-coordinator-dashboard',
          requiredRole: PlatformRole.trainingCoordinator,
          form: PrimeCareForm.trainingCoordinatorDashboard,
          provider: trainingCoordinatorDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Training Velocity)',
            'Session Scheduling Grid',
            'Attendee Tracking',
            'Material Management',
          ],
        );

  @override
  Widget build(BuildContext context) =>
      const TrainingCoordinatorDashboardView();
}
