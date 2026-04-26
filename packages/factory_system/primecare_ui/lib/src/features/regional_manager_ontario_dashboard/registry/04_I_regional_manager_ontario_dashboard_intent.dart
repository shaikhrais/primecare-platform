// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_regional_manager_ontario_dashboard_screen.dart';

class RegionalManagerOntarioDashboardIntent extends AppScreenIntent {
  RegionalManagerOntarioDashboardIntent();

  @override
  String get name => 'regional_manager_ontario_dashboard';

  @override
  String get route =>
      '/offices/corporate/roles/regional_manager_ontario/dashboard';

  @override
  String get title => 'dashboards.regionalmanagerontario.title';

  @override
  PlatformRole get requiredRole => PlatformRole.regionalManagerOntario;

  @override
  dynamic get provider => regionalManagerOntarioMetricsProvider;

  @override
  Widget build(BuildContext context) =>
      const RegionalManagerOntarioDashboardScreen();
}
