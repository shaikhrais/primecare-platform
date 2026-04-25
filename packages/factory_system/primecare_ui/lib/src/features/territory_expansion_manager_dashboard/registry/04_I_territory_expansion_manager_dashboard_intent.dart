// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_territory_expansion_manager_dashboard_screen.dart';

class TerritoryExpansionManagerDashboardIntent extends AppScreenIntent {
  TerritoryExpansionManagerDashboardIntent();

  @override
  String get name => 'territory_expansion_manager_dashboard';

  @override
  String get route =>
      '/offices/corporate/roles/territory_expansion_manager/dashboard';

  @override
  String get title => 'Territory Expansion Manager Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.territoryExpansionManager;

  @override
  dynamic get provider => territoryExpansionMetricsProvider;

  @override
  Widget build(BuildContext context) =>
      const TerritoryExpansionManagerDashboardScreen();
}
