import 'package:primecare_ui/primecare_ui.dart';
import 'client_controller.dart';
import 'client_model.dart';

class ClientView extends ConsumerWidget {
  const ClientView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clientAdapterProvider);
    final controller = ref.read(clientAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'Client Sync Error: $e',
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

  Widget _buildContent(BuildContext context, ClientViewModel vm) {
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
                  Text('Client Care Hub', style: theme.typography.h2),
                  Text('Personalized telemetry and health insights', style: theme.typography.labelMedium),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Upcoming Appointments', style: theme.typography.h4),
                SizedBox(height: theme.spacing.lg),
                const Center(child: Text('No appointments scheduled.')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClientIntent extends PrimeCareScreen {
  ClientIntent() : super(title: "Client");

  @override
  Widget build(BuildContext context) => const ClientView();
}


