// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class COODashboard extends ConsumerWidget {
  COODashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(cooMetricsProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_coo_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_logistics_and_operational_execution_overview
          .tr(),
      body: asyncData.when(
        data: (metrics) => PrimeCareResponsiveKpiGrid(metrics: metrics),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }
}
