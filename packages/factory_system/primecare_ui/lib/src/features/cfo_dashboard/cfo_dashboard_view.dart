import 'package:primecare_ui/primecare_ui.dart';

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
          onPressed: () => ref.read(cfoDashboardAdapterProvider.notifier).refresh(),
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
          (error) => Center(child: Text(error)),
        ),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }

  IconData _getIconForMetric(String title) {
    final t = title.toLowerCase();
    if (t.contains('revenue') || t.contains('profit')) return Icons.payments_outlined;
    if (t.contains('expense') || t.contains('cost')) return Icons.account_balance_wallet_outlined;
    if (t.contains('claim')) return Icons.request_quote_outlined;
    return Icons.analytics_outlined;
  }
}

class CfoDashboardIntent extends PrimeCareScreen {
  CfoDashboardIntent() : super(title: "CfoDashboard");

  @override
  Widget build(BuildContext context) => const CfoDashboardView();
}



