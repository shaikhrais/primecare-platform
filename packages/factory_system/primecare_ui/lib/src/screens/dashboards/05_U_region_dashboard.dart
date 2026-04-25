// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class RegionDashboard extends ConsumerWidget {
  const RegionDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(regionalManagerOntarioMetricsProvider);

    return PageTemplate(
      title: 'Regional Dashboard',
      subtitle: 'Regional performance overview',
      body: asyncData.when(
        data: (metrics) => PrimeCareResponsiveKpiGrid(metrics: metrics),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }
}
