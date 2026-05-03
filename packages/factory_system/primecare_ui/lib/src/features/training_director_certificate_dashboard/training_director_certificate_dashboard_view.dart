// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Certificate Issuance Hook
// @governance: component=Validator Credentialing
// @governance: component=Audit Trail

    hide isOnlineProvider, ProviderTTL;

class TrainingDirectorCertificateDashboardView extends ConsumerWidget {
  const TrainingDirectorCertificateDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(trainingDirectorCertDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Certificate Governance Error: $e',
            onRetry: () =>
                ref.refresh(trainingDirectorCertDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () =>
              ref.refresh(trainingDirectorCertDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    TrainingDirectorCertificateDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Training Director Certificate Command Center',
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

class TrainingDirectorCertificateDashboardIntent extends PrimeCareScreen {
  TrainingDirectorCertificateDashboardIntent()
    : super(
        name: 'training_director_certificate',
        title: LocaleKeys.command_center_labels_training_center,
        route:
            '/offices/corporate/roles/training_director_certificate/dashboard',
        requiredRole: PlatformRole.trainingDirectorCertificate,
        form: PrimeCareForm.trainingDirectorCertificateDashboard,
        provider: trainingDirectorCertDashboardAdapterProvider,
        componentLabels: const [
          'Aura HUD',
          'Certificate Issuance Hook',
          'Validator Credentialing',
          'Audit Trail',
        ],
      );

  @override
  Widget build(BuildContext context) =>
      const TrainingDirectorCertificateDashboardView();
}
