// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ClientDashboardScreen extends ConsumerWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clientDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        loading: () => const DashboardLoadingWidget(),
        error: (Object e, StackTrace st) => DashboardErrorWidget(
          message: 'Governance Exception: $e',
          onRetry: () => ref.refresh(clientDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ClientDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Client Command Center', style: theme.typography.h2),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
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
