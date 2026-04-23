// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseOwnerDashboardScreen extends ConsumerWidget {
  const FranchiseOwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(franchiseOwnerAdapterProvider);

    return MasterLayout(
      
      child: state.when(
        
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (err) => DashboardErrorWidget(
            message: 'Domain Logistics Failure: $err',
            onRetry: () => ref.refresh(franchiseOwnerAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (Object e, StackTrace st) => DashboardErrorWidget(
          message: 'Governance Exception: $e',
          onRetry: () => ref.refresh(franchiseOwnerAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PrimeCareThemeData theme, FranchiseOwnerDashboardViewModel vm) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Franchise Owner Command Center', style: theme.typography.h2),
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
