import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class TerritoryExpansionManagerDashboard extends ConsumerWidget {
  const TerritoryExpansionManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.territoryExpansionManager.dashboard.title',
        subtitle: 'business_development.territoryExpansionManager.dashboard.subtitle',
        provider: territoryExpansionManagerDashboardDataProvider('territory_expansion_manager'),
      );
}
