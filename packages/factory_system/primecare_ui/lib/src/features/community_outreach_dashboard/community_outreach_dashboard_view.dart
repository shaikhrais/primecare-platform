import 'package:primecare_ui/primecare_ui.dart';
import 'community_outreach_dashboard_controller.dart';
import 'community_outreach_dashboard_model.dart';

class CommunityOutreachDashboardView extends ConsumerWidget {
  const CommunityOutreachDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(communityOutreachDashboardAdapterProvider);
    final controller = CommunityOutreachDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel, controller),
          error: (e, st) => DashboardErrorWidget(
            message: 'Outreach Error: $e',
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
    CommunityOutreachDashboardViewModel vm,
    CommunityOutreachDashboardController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Community Outreach Command Center', style: theme.typography.h2),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityOutreachDashboardIntent extends PrimeCareScreen {
  CommunityOutreachDashboardIntent() : super(title: "CommunityOutreachDashboard");

  @override
  Widget build(BuildContext context) => const CommunityOutreachDashboardView();
}


