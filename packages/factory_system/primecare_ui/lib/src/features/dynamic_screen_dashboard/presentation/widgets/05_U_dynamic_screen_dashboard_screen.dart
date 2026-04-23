
import 'package:primecare_ui/primecare_ui.dart';

class DynamicScreenDashboardScreen extends ConsumerWidget {
  const DynamicScreenDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final provider = ref.watch(primecareFormProvider(PrimeCareForm.genericDashboard));
    final asyncValue = ref.watch(provider);

    return MasterLayout(
      child: asyncValue.when(
        data: (Result<PrimeCareDashboardViewModel> result) => result.fold(
          (PrimeCareDashboardViewModel viewModel) => _buildContent(context, theme, viewModel),
          (Object err) => DashboardErrorWidget(
            message: 'Domain Logistics Failure: $err',
            onRetry: () => ref.refresh(provider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (Object e, StackTrace st) => DashboardErrorWidget(
          message: 'Governance Exception: $e',
          onRetry: () => ref.refresh(dynamicAdapterProvider(PrimeCareForm.genericDashboard)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PrimeCareThemeData theme, PrimeCareDashboardViewModel vm) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dynamic Screen Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: const Center(child: Text('Operational Insights Unified')),
          ),
        ],
      ),
    );
  }
}
