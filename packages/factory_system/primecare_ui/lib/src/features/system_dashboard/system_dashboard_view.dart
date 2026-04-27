import 'package:primecare_ui/primecare_ui.dart';

class SystemDashboardView extends ConsumerWidget {
  const SystemDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(systemDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_system_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_enterprise_wide_operational_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.read(systemDashboardAdapterProvider.notifier).refresh(),
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
    if (t.contains('efficiency')) return Icons.trending_up_outlined;
    if (t.contains('clinic')) return Icons.business_outlined;
    if (t.contains('patient')) return Icons.person_outline;
    if (t.contains('budget')) return Icons.account_balance_outlined;
    return Icons.analytics_outlined;
  }
}
class SystemDashboardIntent extends PrimeCareScreen {
  SystemDashboardIntent() : super(title: "SystemDashboard");

  @override
  Widget build(BuildContext context) => const SystemDashboardView();
}


