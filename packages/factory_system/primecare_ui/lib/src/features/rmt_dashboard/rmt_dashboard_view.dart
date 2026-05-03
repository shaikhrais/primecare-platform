// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD
// @governance: component=Massage Session Log
// @governance: component=Client Trigger Point Map
// @governance: component=Therapeutic Goal Tracker

class RmtDashboardView extends ConsumerWidget {
  const RmtDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(rmtDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'RMT Governance Error: $e',
            onRetry: () => ref.refresh(rmtDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(rmtDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RmtDashboardViewModel viewModel,
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
                  Text('RMT Command Center', style: theme.typography.h2),
                  Text(
                    'Therapeutic outcomes, schedule density, and clinical telemetry',
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

class RmtDashboardIntent extends PrimeCareScreen {
  RmtDashboardIntent()
      : super(
          name: 'rmt',
          title: LocaleKeys.clinical_rmt_dashboard_title,
          route: '/offices/clinical/roles/rmt/dashboard',
          requiredRole: PlatformRole.rmt,
          form: PrimeCareForm.rmtDashboard,
          provider: rmtDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD',
            'Musculoskeletal Chart',
            'Treatment Plan',
            'Massage Session Log',
            'Client Trigger Point Map',
            'Therapeutic Goal Tracker',
          ],
        );

  @override
  Widget build(BuildContext context) => const RmtDashboardView();
}
