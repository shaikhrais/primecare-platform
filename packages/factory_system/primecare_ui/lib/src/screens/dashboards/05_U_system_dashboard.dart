// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class SystemDashboard extends ConsumerWidget {
  const SystemDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(generalManagerMetricsProvider);

    return PageTemplate(
      title: 'System Dashboard',
      subtitle: 'Enterprise-wide operational overview',
      body: asyncData.when(
        data: (metrics) => PrimeCareResponsiveKpiGrid(metrics: metrics),
        loading: () => const PrimeCareSkeleton(),
        error: (e, s) => Center(child: Text(e.toString())),
      ),
    );
  }
}
