import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CeoStrategicKpisScreen extends ConsumerWidget {
  const CeoStrategicKpisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Ceo Strategic Kpis',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: ceoDashboardDataProvider('ceo_strategic_kpis'),
      );
}
