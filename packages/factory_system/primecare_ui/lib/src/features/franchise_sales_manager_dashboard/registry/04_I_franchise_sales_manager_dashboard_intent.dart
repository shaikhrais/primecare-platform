// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_franchise_sales_manager_dashboard_screen.dart';

class FranchiseSalesManagerDashboardIntent extends AppScreenIntent {
  FranchiseSalesManagerDashboardIntent();

  @override
  String get name => 'franchise_sales_manager_dashboard';

  @override
  String get route =>
      '/offices/corporate/roles/franchise_sales_manager/dashboard';

  @override
  String get title => 'dashboards.franchisesalesmanager.title';

  @override
  PlatformRole get requiredRole => PlatformRole.franchiseSalesManager;

  @override
  dynamic get provider => franchiseSalesManagerDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) =>
      const FranchiseSalesManagerDashboardScreen();
}
