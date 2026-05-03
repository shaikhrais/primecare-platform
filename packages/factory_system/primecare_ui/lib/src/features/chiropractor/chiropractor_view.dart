// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD
// @governance: component=Patient Spine Health Tracker
// @governance: component=Adjustment Protocol Log
// @governance: component=Imaging View

class ChiropractorView extends ConsumerWidget {
  const ChiropractorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(chiropractorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(chiropractorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(chiropractorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ChiropractorViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.clinical_chiropractor_dashboard_title.tr(),
            style: theme.typography.h2,
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          Text('Today\'s Schedule', style: theme.typography.h4),
          SizedBox(height: theme.spacing.md),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: const Center(child: Text('Clinical Schedule Visualization')),
          ),
        ],
      ),
    );
  }
}

class ChiropractorDashboardIntent extends PrimeCareScreen {
  ChiropractorDashboardIntent()
      : super(
          name: 'chiropractor',
          title: LocaleKeys.clinical_chiropractor_dashboard_title,
          route: '/offices/clinical/roles/chiropractor/dashboard',
          requiredRole: PlatformRole.chiropractor,
          form: PrimeCareForm.chiropractorDashboard,
          provider: chiropractorDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD (Spinal Alignment Index)',
            'Patient Spine Health Tracker',
            'Adjustment Protocol Log',
            'Imaging View',
          ],
        );

  @override
  Widget build(BuildContext context) => const ChiropractorView();
}
