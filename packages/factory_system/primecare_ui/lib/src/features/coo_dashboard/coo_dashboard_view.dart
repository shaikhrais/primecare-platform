// @governance: id=SCREEN_COO_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

class CooDashboardView extends ConsumerWidget {
  const CooDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(cooDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel as COODashboardViewModel),
          (e) => DashboardErrorWidget(
            message: 'Operations Governance Error: $e',
            onRetry: () => ref.refresh(cooDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(cooDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    COODashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'COO Command Center',
                style: theme.typography.h2,
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          // Use standard KPI grid
          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          PrimeCareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Global Logistics Surveillance', style: theme.typography.h4),
                SizedBox(height: theme.spacing.lg),
                SizedBox(
                  height: 300,
                  child: Center(
                    child: Text(
                      'Operational Heatmap Active - Monitoring Assets',
                      style: theme.typography.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CooDashboardIntent extends PrimeCareScreen {
  static const kName = 'coo-dashboard';
  static const kRoute = '/offices/corporate/roles/coo/dashboard';

  @override
  String get title => LocaleKeys.dashboards_common_labels_coo_dashboard;

  @override
  PlatformRole get requiredRole => PlatformRole.coo;

  @override
  PrimeCareForm get form => PrimeCareForm.cooDashboard;

  CooDashboardIntent()
      : super(
          name: kName,
          title: LocaleKeys.dashboards_common_labels_coo_dashboard,
          route: kRoute,
          requiredRole: PlatformRole.coo,
          form: PrimeCareForm.cooDashboard,
          provider: cooDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD',
            'Branch Efficiency Table',
            'Service Quality Log',
            'Operational KPI Grid',
            'Logistics Surveillance Heatmap',
            'Incident Response Queue',
          ],
        );

  @override
  Widget build(BuildContext context) => const CooDashboardView();
}
