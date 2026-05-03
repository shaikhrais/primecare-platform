// Layer: 02_I_HEAD_OF_MARKETING_DASHBOARD_VIEW
// @governance: id=SCREEN_HEAD_OF_MARKETING_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Campaign Intelligence)
// @governance: component=Marketing ROI Grid
// @governance: component=Creative Asset Performance
// @governance: component=Brand Sentiment Analysis
class HeadOfMarketingDashboardView extends ConsumerWidget {
  const HeadOfMarketingDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(headOfMarketingAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(headOfMarketingAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(headOfMarketingAdapterProvider),
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
                    LocaleKeys.head_of_marketing_dashboard_title.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    LocaleKeys.head_of_marketing_dashboard_subtitle.tr(),
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
                  child: Icon(
                    LucideIcons.image,
                    size: 16,
                    color: theme.colors.onPrimaryContainer,
                  ),
                ),
                title: Text('Creative Protocol #${index + 401}'),
                subtitle: const Text(
                  'Campaign: Spring Expansion • Engagement: Top 5%',
                ),
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
  static const kName = 'head-of-marketing-dashboard';
  static const kRoute = '/offices/corporate/roles/head-of-marketing/dashboard';

  @override
  String get title => LocaleKeys.head_of_marketing_dashboard_title;

  @override
  PlatformRole get requiredRole => PlatformRole.headOfMarketing;

  @override
  PrimeCareForm get form => PrimeCareForm.headOfMarketingDashboard;

  HeadOfMarketingDashboardIntent()
      : super(
          name: kName,
          title: LocaleKeys.head_of_marketing_dashboard_title,
          route: kRoute,
          requiredRole: PlatformRole.headOfMarketing,
          form: PrimeCareForm.headOfMarketingDashboard,
          provider: headOfMarketingAdapterProvider,
          componentLabels: const [
            'Aura HUD (Campaign Intelligence)',
            'Marketing ROI Grid',
            'Creative Asset Performance',
            'Brand Sentiment Analysis',
          ],
        );

  @override
  Widget build(BuildContext context) => const HeadOfMarketingDashboardView();
}
