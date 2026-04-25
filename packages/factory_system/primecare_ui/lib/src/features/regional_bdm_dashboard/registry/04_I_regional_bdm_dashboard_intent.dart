// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_regional_bdm_dashboard_screen.dart';

class RegionalBdmDashboardIntent extends AppScreenIntent {
  RegionalBdmDashboardIntent();

  @override
  String get name => 'regional_bdm_dashboard';

  @override
  String get route => '/offices/corporate/roles/regional_bdm/dashboard';

  @override
  String get title => 'Regional Bdm Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.regionalBdm;

  @override
  dynamic get provider => regionalBdmDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const RegionalBdmDashboardScreen();
}
