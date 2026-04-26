// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_franchise_owner_dashboard_screen.dart';

class FranchiseOwnerDashboardIntent extends AppScreenIntent {
  FranchiseOwnerDashboardIntent();

  @override
  String get name => 'franchise_owner_dashboard';

  @override
  String get route => '/offices/corporate/roles/franchise_owner/dashboard';

  @override
  String get title => 'dashboards.franchiseowner.title';

  @override
  PlatformRole get requiredRole => PlatformRole.franchiseOwner;

  @override
  dynamic get provider => franchiseOwnerMetricsProvider;

  @override
  Widget build(BuildContext context) => const FranchiseOwnerDashboardScreen();
}
