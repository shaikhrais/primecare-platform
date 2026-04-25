// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class COODashboard extends ConsumerWidget {
  const COODashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(cooMetricsProvider);

    return PageTemplate(
      title: 'COO Dashboard',
      subtitle: 'Logistics and operational execution overview',
      body: asyncData.when(
        data: (metrics) => PrimeCareResponsiveKpiGrid(metrics: metrics),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }
}
