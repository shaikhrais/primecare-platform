import 'package:primecare_ui/primecare_ui.dart';
import 'psw_controller.dart';
import 'psw_model.dart';

class PswView extends ConsumerWidget {
  const PswView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswAdapterProvider);
    final controller = ref.read(pswAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'PSW Sync Error: $e',
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

  Widget _buildContent(BuildContext context, PswViewModel vm) {
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
                  Text('Personal Support Worker Hub', style: theme.typography.h2),
                  Text('Direct care telemetry and patient support insights', style: theme.typography.labelMedium),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          _buildTaskMatrix(theme),
        ],
      ),
    );
  }

  Widget _buildTaskMatrix(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Care Tasks', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(child: Text('No active tasks assigned.')),
        ],
      ),
    );
  }
}

class PswIntent extends PrimeCareScreen {
  PswIntent() : super(title: "Psw");

  @override
  Widget build(BuildContext context) => const PswView();
}


