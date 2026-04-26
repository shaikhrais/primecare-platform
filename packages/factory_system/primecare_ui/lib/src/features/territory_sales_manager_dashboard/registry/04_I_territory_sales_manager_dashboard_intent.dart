// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_territory_sales_manager_dashboard_screen.dart';

class TerritorySalesManagerDashboardIntent extends AppScreenIntent {
  TerritorySalesManagerDashboardIntent();

  @override
  String get name => 'territory_sales_manager_dashboard';

  @override
  String get route =>
      '/offices/corporate/roles/territory_sales_manager/dashboard';

  @override
  String get title => 'dashboards.territorysalesmanager.title';

  @override
  PlatformRole get requiredRole => PlatformRole.territorySalesManager;

  @override
  dynamic get provider => territorySalesMetricsProvider;

  @override
  Widget build(BuildContext context) =>
      const TerritorySalesManagerDashboardScreen();
}
