// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class RegionDashboard extends ConsumerWidget {
  RegionDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(regionalManagerOntarioMetricsProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_regional_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_regional_performance_overview
          .tr(),
      body: asyncData.when(
        data: (metrics) => PrimeCareResponsiveKpiGrid(metrics: metrics),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }
}
