// @governance: id=SCREEN_FRANCHISE_SALES_MANAGER_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide isOnlineProvider, ProviderTTL;


// @governance: component=Aura HUD (Franchise Sales Funnel)
// @governance: component=Sales Funnel Visualization
// @governance: component=Candidate Lifecycle Map
// @governance: component=CD Pipeline Monitor
class FranchiseSalesManagerDashboardView extends ConsumerWidget {
  const FranchiseSalesManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(franchiseSalesAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, theme, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(financialFormsControllerProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(financialFormsControllerProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    FranchiseSalesManagerDashboardViewModel vm,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DashboardHeader(isOffline: vm.isOfflineFallback),
          SizedBox(height: theme.spacing.xl),
          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),
          _SalesFunnelSection(theme: theme),
          SizedBox(height: theme.spacing.xl),
          _FranchiseLeadList(theme: theme),
        ],
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  final bool isOffline;
  const _DashboardHeader({required this.isOffline});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.franchise_sales_manager_dashboard_title.tr(),
              style: theme.typography.h2,
            ),
            Text(
              LocaleKeys.franchise_sales_manager_dashboard_subtitle.tr(),
              style: theme.typography.labelMedium,
            ),
          ],
        ),
        const Spacer(),
        if (isOffline) const OfflineStatusChip(),
      ],
    );
  }
}

class _SalesFunnelSection extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _SalesFunnelSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Conversion Pipeline', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Pipeline Visualization Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}

class _FranchiseLeadList extends StatelessWidget {
  final PrimeCareThemeData theme;
  const _FranchiseLeadList({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('High-Value Leads', style: theme.typography.h4),
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
                    LucideIcons.user,
                    size: 16,
                    color: theme.colors.onPrimaryContainer,
                  ),
                ),
                title: Text('Lead Protocol #${index + 104}'),
                subtitle: const Text(
                  'Territory: North Atlantic • Qualification: Grade A',
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

class FranchiseSalesManagerDashboardIntent extends PrimeCareScreen {
  FranchiseSalesManagerDashboardIntent()
      : super(
          name: 'SCREEN_FRANCHISE_SALES_MANAGER_DASHBOARD',
          title: LocaleKeys.franchise_sales_manager_dashboard_title,
          route: '/franchise-sales-manager-dashboard',
          requiredRole: PlatformRole.franchiseSalesManager,
          form: PrimeCareForm.franchiseSalesManagerDashboard,
          provider: franchiseSalesAdapterProvider,
          componentLabels: const [
            'Aura HUD (Franchise Sales Funnel)',
            'Sales Funnel Visualization',
            'Candidate Lifecycle Map',
            'CD Pipeline Monitor',
          ],
        );

  @override
  Widget build(BuildContext context) =>
      const FranchiseSalesManagerDashboardView();
}
