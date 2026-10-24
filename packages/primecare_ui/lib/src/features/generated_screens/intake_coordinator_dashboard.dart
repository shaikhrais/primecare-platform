// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class IntakeCoordinatorDashboardScreen extends GovernedWorkspaceEntry {
  const IntakeCoordinatorDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/intake_coordinator/dashboard');
}
