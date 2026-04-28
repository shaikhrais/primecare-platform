// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class CeoDashboardView extends ConsumerWidget {
  const CeoDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(ceoDashboardAdapterProvider);
    final controller = CeoDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as CeoDashboardModel,
            controller,
          ),
          (e) => DashboardErrorWidget(
            message: 'CEO Dashboard Error: $e',
            onRetry: () => ref.refresh(ceoDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(ceoDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    CeoDashboardModel vm,
    CeoDashboardController controller,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Executive Summary', style: theme.typography.h2),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          if (vm.insights.isNotEmpty) ...[
            Text('Intelligence Insights', style: theme.typography.h4),
            SizedBox(height: theme.spacing.md),
            // TODO: Add insight widgets
          ],
        ],
      ),
    );
  }
}

/// The high-fidelity intent for the CEO Dashboard.
/// Bypasses the universal screen engine to use the MVC view directly.
class CeoDashboardIntent extends PrimeCareScreen {
  CeoDashboardIntent()
    : super(
        name: 'ceo',
        title: 'CEO Command Center',
        route: '/offices/corporate/roles/ceo/dashboard',
        requiredRole: PlatformRole.ceo,
        componentLabels: [
          'Global KPI DashboardMetrics',
          'Region Comparison',
          'Strategic Initiatives',
        ],
      );

  @override
  Widget build(BuildContext context) => const CeoDashboardView();
}
