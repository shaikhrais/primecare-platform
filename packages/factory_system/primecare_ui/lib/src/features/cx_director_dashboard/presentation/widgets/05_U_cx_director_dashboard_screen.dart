// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class CxDirectorDashboardScreen extends ConsumerWidget {
  const CxDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(customerExperienceDirectorDashboardAdapterProvider);

    return MasterLayout(
      
      child: state.when(
        
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (err) => DashboardErrorWidget(
            message: 'Domain Logistics Failure: $err',
            onRetry: () => ref.refresh(customerExperienceDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (Object e, StackTrace st) => DashboardErrorWidget(
          message: 'Governance Exception: $e',
          onRetry: () => ref.refresh(customerExperienceDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PrimeCareThemeData theme, CustomerExperienceDirectorDashboardViewModel vm) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cx Director Command Center', style: theme.typography.h2),
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
