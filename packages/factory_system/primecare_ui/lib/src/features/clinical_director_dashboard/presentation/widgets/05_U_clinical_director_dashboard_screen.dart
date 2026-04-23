// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ClinicalDirectorDashboardScreen extends ConsumerWidget {
  const ClinicalDirectorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clinicalDirectorDashboardAdapterProvider);

    return MasterLayout(
      
      child: state.when(
        
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (err) => DashboardErrorWidget(
            message: 'Domain Logistics Failure: $err',
            onRetry: () => ref.refresh(clinicalDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (Object e, StackTrace st) => DashboardErrorWidget(
          message: 'Governance Exception: $e',
          onRetry: () => ref.refresh(clinicalDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PrimeCareThemeData theme, ClinicalDirectorDashboardViewModel vm) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Director Command Center', style: theme.typography.h2),
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
