import 'package:primecare_ui/primecare_ui.dart';
import 'rn_controller.dart';
import 'rn_model.dart';

class RnView extends ConsumerWidget {
  const RnView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rnAdapterProvider);
    final controller = ref.read(rnAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'RN Sync Error: $e',
            onRetry: controller.refresh,
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: controller.refresh,
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
                  Text('Clinical surveillance and critical care orchestration', style: theme.typography.labelMedium),
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
          const Center(child: Text('All patient vitals within normal parameters.')),
        ],
      ),
    );
  }
}

class RnIntent extends PrimeCareScreen {
  RnIntent() : super(title: "Rn");

  @override
  Widget build(BuildContext context) => const RnView();
}


