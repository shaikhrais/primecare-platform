// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class RpnView extends ConsumerWidget {
  const RpnView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpnAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'RPN Sync Error: $e',
            onRetry: () => ref.refresh(rpnAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(rpnAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RpnViewModel vm) {
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
                  Text(
                    'Registered Practical Nurse Hub',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Practical clinical telemetry and nursing support',
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
          _buildPracticalClinicalMatrix(theme),
        ],
      ),
    );
  }

  Widget _buildPracticalClinicalMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Medication Administration Surveillance',
            style: theme.typography.h4,
          ),
          SizedBox(height: theme.spacing.lg),
          const Center(child: Text('All medication rounds are on schedule.')),
        ],
      ),
    );
  }
}

class RpnIntent extends PrimeCareScreen {
  RpnIntent() : super(title: 'Rpn');

  @override
  Widget build(BuildContext context) => const RpnView();
}
