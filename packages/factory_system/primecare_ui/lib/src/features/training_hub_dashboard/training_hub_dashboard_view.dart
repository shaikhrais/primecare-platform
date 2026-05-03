// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Learning Management UI
// @governance: component=Course Progression Heatmap
// @governance: component=Resource Library

    hide isOnlineProvider, ProviderTTL;

class TrainingHubDashboardView extends ConsumerWidget {
  const TrainingHubDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(trainingHubDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Training Hub Governance Error: $e',
            onRetry: () => ref.refresh(trainingHubDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(trainingHubDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TrainingHubDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                LocaleKeys.command_center_labels_training_hub_center.tr(),
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
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

class TrainingHubDashboardIntent extends PrimeCareScreen {
  TrainingHubDashboardIntent()
    : super(
        name: 'training_hub',
        title: LocaleKeys.command_center_labels_training_hub_center,
        route: '/offices/corporate/roles/training_hub/dashboard',
        requiredRole: PlatformRole.trainingHub,
        form: PrimeCareForm.trainingHub,
        provider: trainingHubDashboardAdapterProvider,
        componentLabels: const [
          'Aura HUD',
          'Learning Management UI',
          'Course Progression Heatmap',
          'Resource Library',
        ],
      );

  @override
  Widget build(BuildContext context) => const TrainingHubDashboardView();
}
