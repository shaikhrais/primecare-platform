// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class SystemVerificationDashboardView extends ConsumerWidget {
  const SystemVerificationDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(systemVerificationDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Verification Governance Error: $e',
            onRetry: () => ref.refresh(systemDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(systemDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    SystemVerificationDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'System Verification Command Center',
                style: theme.typography.h2,
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
                style: theme.typography.bodyLarge.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SystemVerificationDashboardIntent extends PrimeCareScreen {
  SystemVerificationDashboardIntent()
    : super(title: 'SystemVerificationDashboard');

  @override
  Widget build(BuildContext context) => const SystemVerificationDashboardView();
}
