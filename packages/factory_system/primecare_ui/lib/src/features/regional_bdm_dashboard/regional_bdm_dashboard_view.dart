// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class RegionalBdmDashboardView extends ConsumerWidget {
  const RegionalBdmDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalBdmDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as RegionalBdmDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(regionalBdmDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(regionalBdmDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalBdmDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Regional BDM Command Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Regional business development and growth telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Center(
              child: Text(
                LocaleKeys.dashboards_common_labels_operational_insights.tr(),
                style: theme.typography.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegionalBdmDashboardIntent extends PrimeCareScreen {
  RegionalBdmDashboardIntent() : super(title: 'RegionalBdmDashboard');

  @override
  Widget build(BuildContext context) => const RegionalBdmDashboardView();
}
