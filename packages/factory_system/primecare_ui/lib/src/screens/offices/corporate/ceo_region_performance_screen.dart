import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CeoRegionPerformanceScreen extends ConsumerWidget {
  const CeoRegionPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Ceo Region Performance',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: ceoDashboardDataProvider('ceo_region_performance'),
      );
}
