// @governance: id=SCREEN_COMMUNITY_OUTREACH_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Event Traction)
// @governance: component=Outreach Stat Grid
// @governance: component=Partnership Growth Chart
// @governance: component=Event Management Calendar
class CommunityOutreachDashboardView extends ConsumerWidget {
  const CommunityOutreachDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(communityOutreachDashboardAdapterProvider);
    final controller = CommunityOutreachDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel, controller),
          (e) => DashboardErrorWidget(
            message: 'Outreach Error: $e',
            onRetry: () => ref.refresh(commonFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(commonFormsControllerProvider),
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
              Text(
                'Community Outreach Command Center',
                style: theme.typography.h2,
              ),
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
  CommunityOutreachDashboardIntent()
      : super(
          name: 'SCREEN_COMMUNITY_OUTREACH_DASHBOARD',
          title: LocaleKeys.business_development_community_outreach_dashboard_title,
          route: '/community-outreach-dashboard',
          requiredRole: PlatformRole.communityOutreach,
          form: PrimeCareForm.communityOutreachDashboard,
          provider: communityOutreachDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Event Traction)',
            'Outreach Stat Grid',
            'Partnership Growth Chart',
            'Event Management Calendar',
          ],
        );

  @override
  Widget build(BuildContext context) => const CommunityOutreachDashboardView();
}
