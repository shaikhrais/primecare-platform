import 'package:primecare_ui/primecare_ui.dart';

class CeoDashboardView extends ConsumerWidget {
  const CeoDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(ceoDashboardAdapterProvider);
    final controller = CeoDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel, controller),
          error: (e, st) => DashboardErrorWidget(
            message: 'CEO Dashboard Error: $e',
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
  CeoDashboardIntent() : super(
    name: 'ceo',
    title: 'CEO Command Center',
    route: '/offices/corporate/roles/ceo/dashboard',
    requiredRole: PlatformRole.ceo,
    blueprints: const [],
    componentLabels: ['MVC View'],
  );

  @override
  Widget build(BuildContext context) => const CeoDashboardView();
}


