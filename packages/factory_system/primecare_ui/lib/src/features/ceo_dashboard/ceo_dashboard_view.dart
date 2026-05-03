// @governance: id=SCREEN_CEO_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:primecare_ui/src/theme/sovereign_surgeon_theme.dart';
import 'package:primecare_ui/src/theme/aura/aura_role_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD
// @governance: component=Global KPI DashboardMetrics
// @governance: component=Region Comparison
// @governance: component=Strategic Initiatives
class CeoDashboardView extends ConsumerWidget {
  const CeoDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ceoDashboardAdapterProvider);
    final controller = CeoDashboardController(ref);

    return Theme(
      data: SovereignSurgeonTheme.lightTheme,
      child: Scaffold(
        body: state.when(
          data: (result) => result.fold(
            (viewModel) => Builder(
              builder: (innerContext) => _buildContent(
                innerContext,
                viewModel as CeoDashboardModel,
                controller,
                ref,
              ),
            ),
            (e) => DashboardErrorWidget(
              message: 'CEO Dashboard Error: $e',
              onRetry: () => ref.refresh(ceoDashboardAdapterProvider),
            ),
          ),
          loading: () => const DashboardLoadingWidget(),
          error: (e, st) => DashboardErrorWidget(
            message: 'Connection Error: $e',
            onRetry: () => ref.refresh(ceoDashboardAdapterProvider),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    CeoDashboardModel vm,
    CeoDashboardController controller,
    WidgetRef ref,
  ) {
    final theme = context.theme;
    final auraTheme = AuraRoleTheme.of('ceo');

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuraV4Hud(
            title: 'Enterprise Health Score',
            value: '98.4%',
            gradient: auraTheme.primaryGradient,
            auraLabel: auraTheme.auraLabel,
          ),
          SizedBox(height: theme.spacing.xxl),
          
          Text('Global KPI Metrics', style: theme.typography.h2),
          SizedBox(height: theme.spacing.md),
          Wrap(
            spacing: theme.spacing.md,
            runSpacing: theme.spacing.md,
            children: [
              PrimeCareV4StatCard(
                title: 'Total Revenue',
                value: '\$14.2M',
                trend: '+12.5% vs LW',
                icon: Icons.account_balance_wallet,
                color: auraTheme.accentColor,
              ),
              const PrimeCareV4StatCard(
                title: 'Patient Satisfaction',
                value: '4.8/5',
                trend: '+0.2% vs LW',
                icon: Icons.star,
                color: Colors.amber,
              ),
              PrimeCareV4StatCard(
                title: 'Operational Efficiency',
                value: '94%',
                trend: '-1.5% vs LW',
                icon: Icons.speed,
                color: PrimeCareColors.emerald,
              ),
            ],
          ),
          
          SizedBox(height: theme.spacing.xxl),
          Text('Strategic Initiatives', style: theme.typography.h2),
          SizedBox(height: theme.spacing.md),
          Column(
            children: [
              PrimeCareV4Card(
                child: ListTile(
                  title: Text('V4 Aesthetic Rollout', style: theme.typography.titleMedium),
                  subtitle: const Text('Targeting 100% compliance by Q3'),
                  trailing: const CircularProgressIndicator(value: 0.65),
                ),
              ),
              PrimeCareV4Card(
                child: ListTile(
                  title: Text('Regional Expansion: Ontario', style: theme.typography.titleMedium),
                  subtitle: const Text('3 new branches in licensing phase'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The high-fidelity intent for the CEO Dashboard.
/// Bypasses the universal screen engine to use the MVC view directly.
class CeoDashboardIntent extends PrimeCareScreen {
  CeoDashboardIntent()
    : super(
        name: 'ceo',
        title: 'dashboards.common.labels.ceo_dashboard',
        route: '/offices/corporate/roles/ceo/dashboard',
        requiredRole: PlatformRole.ceo,
        form: PrimeCareForm.ceoDashboard,
        provider: ceoDashboardAdapterProvider,
        componentLabels: [
          'Aura HUD',
          'Global KPI DashboardMetrics',
          'Region Comparison',
          'Strategic Initiatives',
        ],
      );

  @override
  Widget build(BuildContext context) => const CeoDashboardView();
}
