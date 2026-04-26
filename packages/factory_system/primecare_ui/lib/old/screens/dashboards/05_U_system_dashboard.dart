// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class SystemDashboard extends ConsumerWidget {
  SystemDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(generalManagerMetricsProvider);

    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_system_dashboard.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_enterprise_wide_operational_overview
          .tr(),
      body: asyncData.when(
        data: (metrics) => PrimeCareResponsiveKpiGrid(metrics: metrics),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }
}
