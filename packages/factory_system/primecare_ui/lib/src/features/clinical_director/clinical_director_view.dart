// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class ClinicalDirectorView extends ConsumerWidget {
  const ClinicalDirectorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicalDirectorAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Clinical Governance Error: $e',
            onRetry: () => ref.refresh(clinicalDirectorAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(clinicalDirectorAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ClinicalDirectorViewModel vm) {
    final theme = context.theme;
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
                  Text('Clinical Director Hub', style: theme.typography.h2),
                  Text(
                    'Facility medical governance and protocol surveillance',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          _buildGovernanceAlerts(theme),
        ],
      ),
    );
  }

  Widget _buildGovernanceAlerts(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Compliance Alerts', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const ListTile(
            leading: Icon(Icons.warning_amber_rounded, color: Colors.orange),
            title: Text('Protocol Drift Detected in Sector 4'),
            subtitle: Text('Review medication administration deviation logs.'),
          ),
        ],
      ),
    );
  }
}

class ClinicalDirectorIntent extends PrimeCareScreen {
  ClinicalDirectorIntent() : super(title: 'ClinicalDirector');

  @override
  Widget build(BuildContext context) => const ClinicalDirectorView();
}
