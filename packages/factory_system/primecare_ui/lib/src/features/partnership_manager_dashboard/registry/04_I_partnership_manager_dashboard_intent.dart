// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_partnership_manager_dashboard_screen.dart';

class PartnershipManagerDashboardIntent extends AppScreenIntent {
  PartnershipManagerDashboardIntent();

  @override
  String get name => 'partnership_manager_dashboard';

  @override
  String get route => '/offices/corporate/roles/partnership_manager/dashboard';

  @override
  String get title => 'Partnership Manager Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.partnershipManager;

  @override
  dynamic get provider => partnershipManagerDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) =>
      const PartnershipManagerDashboardScreen();
}
