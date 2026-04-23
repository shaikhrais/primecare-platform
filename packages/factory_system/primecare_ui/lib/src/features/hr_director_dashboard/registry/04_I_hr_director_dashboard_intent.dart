// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_hr_director_dashboard_screen.dart';

class HrDirectorDashboardIntent extends AppScreenIntent {
  const HrDirectorDashboardIntent();

  @override
  String get name => 'hr_director_dashboard';

  @override
  String get route => '/offices/corporate/roles/hr_director/dashboard';

  @override
  String get title => 'Hr Director Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.hrDirector;

  @override
  dynamic get provider => humanResourcesDirectorDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const HrDirectorDashboardScreen();
}

