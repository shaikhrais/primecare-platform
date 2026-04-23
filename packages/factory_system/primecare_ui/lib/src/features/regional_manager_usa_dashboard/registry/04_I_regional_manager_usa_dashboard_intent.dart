// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_regional_manager_usa_dashboard_screen.dart';

class RegionalManagerUsaDashboardIntent extends AppScreenIntent {
  const RegionalManagerUsaDashboardIntent();

  @override
  String get name => 'regional_manager_usa_dashboard';

  @override
  String get route => '/offices/corporate/roles/regional_manager_usa/dashboard';

  @override
  String get title => 'Regional Manager Usa Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.regionalManagerUsa;

  @override
  dynamic get provider => regionalManagerUsaDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const RegionalManagerUsaDashboardScreen();
}

