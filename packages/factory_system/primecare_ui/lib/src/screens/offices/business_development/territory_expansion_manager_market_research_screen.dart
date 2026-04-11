import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritoryExpansionManagerMarketResearchScreen extends ConsumerWidget {
  const TerritoryExpansionManagerMarketResearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Territory Expansion Manager Market Research',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: territoryExpansionManagerDashboardDataProvider('territory_expansion_manager_market_research'),
      );
}
