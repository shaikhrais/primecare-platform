// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class CaregiverDashboardScreen extends GovernedWorkspaceEntry {
  const CaregiverDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/caregiver/dashboard');
}
