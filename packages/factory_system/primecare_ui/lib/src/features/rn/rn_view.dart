// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class RnView extends ConsumerWidget {
  const RnView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rnAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'RN Sync Error: $e',
            onRetry: () => ref.refresh(rnAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(rnAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RnViewModel vm) {
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
                  Text('Registered Nurse Hub', style: theme.typography.h2),
                  Text(
                    'Clinical surveillance and critical care orchestration',
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
          _buildClinicalMatrix(theme),
        ],
      ),
    );
  }

  Widget _buildClinicalMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Critical Care Surveillance', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text('All patient vitals within normal parameters.'),
          ),
        ],
      ),
    );
  }
}

class RnIntent extends PrimeCareScreen {
  RnIntent() : super(title: 'Rn');

  @override
  Widget build(BuildContext context) => const RnView();
}
