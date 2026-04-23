// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_volunteer_coordinator_dashboard_screen.dart';

class VolunteerCoordinatorDashboardIntent extends AppScreenIntent {
  const VolunteerCoordinatorDashboardIntent();

  @override
  String get name => 'volunteer_coordinator_dashboard';

  @override
  String get route => '/offices/corporate/roles/volunteer_coordinator/dashboard';

  @override
  String get title => 'Volunteer Coordinator Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.volunteerCoordinator;

  @override
  dynamic get provider => volunteerCoordinatorDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const VolunteerCoordinatorDashboardScreen();
}

