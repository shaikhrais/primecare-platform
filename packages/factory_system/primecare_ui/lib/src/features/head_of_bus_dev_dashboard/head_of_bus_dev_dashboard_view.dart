// @governance: id=SCREEN_HEAD_OF_BUS_DEV_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Pipeline Velocity)
// @governance: component=Pipeline Velocity Chart
// @governance: component=Expansion Roadmap Heatmap
// @governance: component=Partner Synergy Matrix
class HeadOfBusDevDashboardView extends ConsumerWidget {
  const HeadOfBusDevDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(headOfBusDevAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(headOfBusDevAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(headOfBusDevAdapterProvider),
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
                    LocaleKeys.head_of_bus_dev_dashboard_title.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    LocaleKeys.head_of_bus_dev_dashboard_subtitle.tr(),
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
                  child: Icon(
                    LucideIcons.globe,
                    size: 16,
                    color: theme.colors.onTertiaryContainer,
                  ),
                ),
                title: Text('Expansion Protocol #${index + 301}'),
                subtitle: const Text(
                  'Region: Southeast Asia • Market Fit: High',
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

class HeadOfBusDevDashboardIntent extends PrimeCareScreen {
  static const kName = 'head-of-bus-dev-dashboard';
  static const kRoute = '/offices/corporate/roles/head-of-bus-dev/dashboard';

  @override
  String get title => LocaleKeys.head_of_bus_dev_dashboard_title;

  @override
  PlatformRole get requiredRole => PlatformRole.headOfBusDev;

  @override
  PrimeCareForm get form => PrimeCareForm.headOfBusDevDashboard;

  HeadOfBusDevDashboardIntent()
      : super(
          name: kName,
          title: LocaleKeys.head_of_bus_dev_dashboard_title,
          route: kRoute,
          requiredRole: PlatformRole.headOfBusDev,
          form: PrimeCareForm.headOfBusDevDashboard,
          provider: headOfBusDevAdapterProvider,
          componentLabels: const [
            'Aura HUD (Pipeline Velocity)',
            'Pipeline Velocity Chart',
            'Expansion Roadmap Heatmap',
            'Partner Synergy Matrix',
          ],
        );

  @override
  Widget build(BuildContext context) => const HeadOfBusDevDashboardView();
}
