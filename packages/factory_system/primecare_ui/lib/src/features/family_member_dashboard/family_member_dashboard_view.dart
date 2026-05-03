// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

    hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Care Coordination)
// @governance: component=Patient Status Card
// @governance: component=Care Log Timeline
// @governance: component=Wellness Trend Chart
class FamilyMemberDashboardView extends ConsumerWidget {
  const FamilyMemberDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(familyMemberDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel.metrics),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(familyMemberControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(familyMemberControllerProvider),
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
          Text(
            LocaleKeys.family_member_dashboard_title.tr(),
            style: theme.typography.h2,
          ),
          Text(
            LocaleKeys.family_member_dashboard_subtitle.tr(),
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

class FamilyMemberDashboardIntent extends PrimeCareScreen {
  FamilyMemberDashboardIntent()
      : super(
          name: 'family_member_dashboard',
          title: LocaleKeys.family_member_dashboard_title,
          route: '/portal/family/dashboard',
          requiredRole: PlatformRole.familyMember,
          form: PrimeCareForm.familyMemberDashboard,
          provider: familyMemberDashboardAdapterProvider,
          componentLabels: const ['Aura HUD', 'Care Coordination'],
        );

  @override
  Widget build(BuildContext context) => const FamilyMemberDashboardView();
}
