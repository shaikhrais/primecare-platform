// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_cx_director_dashboard_screen.dart';

class CxDirectorDashboardIntent extends AppScreenIntent {
  CxDirectorDashboardIntent();

  @override
  String get name => 'cx_director_dashboard';

  @override
  String get route => '/offices/corporate/roles/cx_director/dashboard';

  @override
  String get title => 'dashboards.cxdirector.title';

  @override
  PlatformRole get requiredRole => PlatformRole.cxDirector;

  @override
  dynamic get provider => cxDirectorMetricsProvider;

  @override
  Widget build(BuildContext context) => const CxDirectorDashboardScreen();
}
