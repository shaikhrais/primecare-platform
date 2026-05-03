// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Registration Funnel
// @governance: component=Patient Onboarding Flow

class IntakeDashboardView extends ConsumerWidget {
  const IntakeDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(intakeDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(intakeDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(intakeDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    IntakeDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Intake Dashboard',
            style: theme.typography.h2,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            'Monitor patient registration and onboarding telemetry.',
            style: theme.typography.bodyLarge.copyWith(
              color: theme.colors.textSecondary,
            ),
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: const Center(
              child: Text('Operational Insights'),
            ),
          ),
        ],
      ),
    );
  }
}

class IntakeDashboardIntent extends PrimeCareScreen {
  IntakeDashboardIntent()
      : super(
          name: 'intake_dashboard',
          title: LocaleKeys.intake_dashboard_title,
          route: '/offices/roles/intake/dashboard',
          requiredRole: PlatformRole.intake,
          form: PrimeCareForm.intakeDashboard,
          provider: intakeDashboardAdapterProvider,
          componentLabels: const ['Aura HUD', 'Intake Telemetry'],
        );

  @override
  Widget build(BuildContext context) => const IntakeDashboardView();
}
