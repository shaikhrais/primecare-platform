// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class PatientDashboardScreen extends GovernedWorkspaceEntry {
  const PatientDashboardScreen({super.key})
      : super(route: '/offices/client/roles/client/dashboard');
}
