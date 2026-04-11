import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CeoGrowthPipelineScreen extends ConsumerWidget {
  const CeoGrowthPipelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Ceo Growth Pipeline',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: ceoDashboardDataProvider('ceo_growth_pipeline'),
      );
}
