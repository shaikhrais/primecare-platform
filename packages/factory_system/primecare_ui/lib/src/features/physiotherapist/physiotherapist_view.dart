// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD
// @governance: component=Mobility Progress Chart
// @governance: component=Treatment Session Timer
// @governance: component=Rehab Plan Builder

class PhysiotherapistView extends ConsumerWidget {
  const PhysiotherapistView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(physiotherapistDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(physiotherapistDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(physiotherapistDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    PhysiotherapistViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.clinical_physiotherapist_dashboard_title.tr(),
            style: theme.typography.h2,
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          Text('Rehabilitation Schedule', style: theme.typography.h4),
          SizedBox(height: theme.spacing.md),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: const Center(child: Text('Mobility Compliance Tracker')),
          ),
        ],
      ),
    );
  }
}

class PhysiotherapistDashboardIntent extends PrimeCareScreen {
  PhysiotherapistDashboardIntent()
      : super(
          name: 'physiotherapist',
          title: LocaleKeys.clinical_physiotherapist_dashboard_title,
          route: '/offices/clinical/roles/physiotherapist/dashboard',
          requiredRole: PlatformRole.physiotherapist,
          form: PrimeCareForm.physiotherapistDashboard,
          provider: physiotherapistDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Mobility Recovery Vector)',
            'Mobility Progress Chart',
            'Treatment Session Timer',
            'Rehab Plan Builder',
          ],
        );

  @override
  Widget build(BuildContext context) => const PhysiotherapistView();
}
