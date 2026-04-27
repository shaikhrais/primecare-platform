import 'package:primecare_ui/primecare_ui.dart';
import 'guest_dashboard_controller.dart';
import 'guest_dashboard_model.dart';

class GuestDashboardView extends ConsumerWidget {
  const GuestDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(guestDashboardAdapterProvider);
    final controller = ref.read(guestDashboardAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
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
    DashboardMetrics metrics,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Guest Command Center', style: theme.typography.h2),
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
  GuestDashboardIntent() : super(title: "GuestDashboard");

  @override
  Widget build(BuildContext context) => const GuestDashboardView();
}


