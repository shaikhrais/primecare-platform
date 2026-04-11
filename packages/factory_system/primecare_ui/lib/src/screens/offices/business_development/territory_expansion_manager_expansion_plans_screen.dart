import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritoryExpansionManagerExpansionPlansScreen extends ConsumerWidget {
  const TerritoryExpansionManagerExpansionPlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Expansion Manager Expansion Plans',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: territoryExpansionManagerDashboardDataProvider('territory_expansion_manager_expansion_plans'),
      );
}
