// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_cx_director_dashboard_screen.dart';

class CxDirectorDashboardIntent extends AppScreenIntent {
  const CxDirectorDashboardIntent();

  @override
  String get name => 'cx_director_dashboard';

  @override
  String get route => '/offices/corporate/roles/cx_director/dashboard';

  @override
  String get title => 'Cx Director Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.cxDirector;

  @override
  dynamic get provider => customerExperienceDirectorDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const CxDirectorDashboardScreen();
}

