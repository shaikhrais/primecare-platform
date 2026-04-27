import 'package:primecare_ui/primecare_ui.dart';
import 'rn_dashboard_controller.dart';
import 'rn_dashboard_model.dart';

class RnDashboardView extends ConsumerWidget {
  const RnDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(rnDashboardAdapterProvider);
    final controller = ref.read(rnDashboardAdapterProvider.notifier);

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
    RnDashboardViewModel viewModel,
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
                    'RN Command Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Clinical oversight and nursing workflow telemetry',
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
                style: theme.typography.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RnDashboardIntent extends PrimeCareScreen {
  RnDashboardIntent() : super(title: "RnDashboard");

  @override
  Widget build(BuildContext context) => const RnDashboardView();
}


