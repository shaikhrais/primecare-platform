import 'package:primecare_ui/primecare_ui.dart';
import 'head_of_bus_dev_dashboard_controller.dart';
import 'head_of_bus_dev_dashboard_model.dart';

class HeadOfBusDevDashboardView extends ConsumerWidget {
  const HeadOfBusDevDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(headOfBusDevAdapterProvider);
    final controller = ref.read(headOfBusDevAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'Governance Error: $e',
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

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HeadOfBusDevDashboardViewModel vm,
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
                  Text(
                    'Strategic Command',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Market expansion, partnership velocity, and global growth telemetry',
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
          _PartnershipFunnel(theme: theme),
          SizedBox(height: theme.spacing.xl),
          _StrategicOpportunities(theme: theme),
        ],
      ),
    );
  }
}

class _PartnershipFunnel extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _PartnershipFunnel({required this.theme});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Partnership conversion pipeline', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Partnership Intelligence Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _StrategicOpportunities extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _StrategicOpportunities({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Strategic Growth Opportunities', style: theme.typography.h4),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              3,
              (index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colors.tertiaryContainer,
                  child: Icon(LucideIcons.globe, size: 16, color: theme.colors.onTertiaryContainer),
                ),
                title: Text('Expansion Protocol #${index + 301}'),
                subtitle: const Text('Region: Southeast Asia • Market Fit: High'),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeadOfBusDevDashboardIntent extends PrimeCareScreen {
  HeadOfBusDevDashboardIntent() : super(title: "HeadOfBusDevDashboard");

  @override
  Widget build(BuildContext context) => const HeadOfBusDevDashboardView();
}


