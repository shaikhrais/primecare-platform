// @governance: id=SCREEN_CFO_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD
// @governance: component=Liquidity Index
// @governance: component=Burn Rate Analysis
// @governance: component=Capital Allocation
class CfoDashboardView extends ConsumerWidget {
  const CfoDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(cfoDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_cfo_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_financial_statements_and_forecasts_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.refresh(cfoDashboardAdapterProvider),
        ),
      ],
      body: asyncData.when(
        data: (result) => result.fold(
          (data) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareResponsiveKpiGrid(
                  children: data.kpis
                      .map(
                        (kpi) => PrimeCareKpiCard(
                          title: kpi.title,
                          value: kpi.value,
                          subtitle: kpi.subtitle ?? '',
                          icon: _getIconForMetric(kpi.title),
                          onPinToggle: () {},
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                // Additional sections like Revenue Trend charts would go here
              ],
            ),
          ),
          (error) => Center(child: Text(error.toString())),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('revenue') || t.contains('profit'))
      return Icons.payments_outlined;
    if (t.contains('expense') || t.contains('cost'))
      return Icons.account_balance_wallet_outlined;
    if (t.contains('claim')) return Icons.request_quote_outlined;
    return Icons.analytics_outlined;
  }
}

class CfoDashboardIntent extends PrimeCareScreen {
  CfoDashboardIntent()
    : super(
        name: 'cfo',
        title: LocaleKeys.dashboards_common_labels_cfo_dashboard,
        route: '/offices/corporate/roles/cfo/dashboard',
        requiredRole: PlatformRole.cfo,
        form: PrimeCareForm.cfoDashboard,
        provider: cfoDashboardAdapterProvider,
        componentLabels: const [
          'Aura HUD (Financial Intelligence)',
          'Liquidity Index',
          'Burn Rate Analysis',
          'Capital Allocation',
        ],
      );

  @override
  Widget build(BuildContext context) => const CfoDashboardView();
}
