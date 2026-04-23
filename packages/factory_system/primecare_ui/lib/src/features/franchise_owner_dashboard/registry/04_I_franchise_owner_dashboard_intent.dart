// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_franchise_owner_dashboard_screen.dart';

class FranchiseOwnerDashboardIntent extends AppScreenIntent {
  const FranchiseOwnerDashboardIntent();

  @override
  String get name => 'franchise_owner_dashboard';

  @override
  String get route => '/offices/corporate/roles/franchise_owner/dashboard';

  @override
  String get title => 'Franchise Owner Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.franchiseOwner;

  @override
  dynamic get provider => franchiseOwnerAdapterProvider;

  @override
  Widget build(BuildContext context) => const FranchiseOwnerDashboardScreen();
}

