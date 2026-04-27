import 'package:primecare_ui/primecare_ui.dart';

class CooDashboardView extends ConsumerWidget {
  const CooDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(cooDashboardAdapterProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_coo_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_logistics_and_operational_execution_overview
          .tr(),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => ref.read(cooDashboardAdapterProvider.notifier).refresh(),
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
    if (t.contains('logistics') || t.contains('fleet')) return Icons.local_shipping_outlined;
    if (t.contains('warehouse')) return Icons.inventory_2_outlined;
    if (t.contains('time')) return Icons.timer_outlined;
    return Icons.settings_applications_outlined;
  }
}

class CooDashboardIntent extends PrimeCareScreen {
  CooDashboardIntent() : super(title: "CooDashboard");

  @override
  Widget build(BuildContext context) => const CooDashboardView();
}



