// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_intake_coordinator_dashboard_screen.dart';

class IntakeCoordinatorDashboardIntent extends AppScreenIntent {
  IntakeCoordinatorDashboardIntent();

  @override
  String get name => 'intake_coordinator_dashboard';

  @override
  String get route => '/offices/corporate/roles/intake_coordinator/dashboard';

  @override
  String get title => 'dashboards.intakecoordinator.title';

  @override
  PlatformRole get requiredRole => PlatformRole.intakeCoordinator;

  @override
  dynamic get provider => intakeCoordinatorDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) =>
      const IntakeCoordinatorDashboardScreen();
}
