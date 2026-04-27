import 'package:primecare_ui/primecare_ui.dart';
import 'head_of_marketing_dashboard_controller.dart';
import 'head_of_marketing_dashboard_model.dart';

class HeadOfMarketingDashboardView extends ConsumerWidget {
  const HeadOfMarketingDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(headOfMarketingAdapterProvider);
    final controller = ref.read(headOfMarketingAdapterProvider.notifier);

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
    HeadOfMarketingDashboardViewModel vm,
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
                    'Marketing Command',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Brand resonance, campaign velocity, and market penetration telemetry',
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
          _MarketingCampaignSection(theme: theme),
          SizedBox(height: theme.spacing.xl),
          _CreativeAssetList(theme: theme),
        ],
      ),
    );
  }
}

class _MarketingCampaignSection extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _MarketingCampaignSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Campaign ROI Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Campaign Intelligence Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreativeAssetList extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _CreativeAssetList({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Creative Performance Protocols', style: theme.typography.h4),
        SizedBox(height: theme.spacing.lg),
        PrimeCareCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              3,
              (index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colors.primaryContainer,
                  child: Icon(LucideIcons.image, size: 16, color: theme.colors.onPrimaryContainer),
                ),
                title: Text('Creative Protocol #${index + 401}'),
                subtitle: const Text('Campaign: Spring Expansion • Engagement: Top 5%'),
                trailing: const Icon(LucideIcons.chevronRight, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeadOfMarketingDashboardIntent extends PrimeCareScreen {
  HeadOfMarketingDashboardIntent() : super(title: "HeadOfMarketingDashboard");

  @override
  Widget build(BuildContext context) => const HeadOfMarketingDashboardView();
}


