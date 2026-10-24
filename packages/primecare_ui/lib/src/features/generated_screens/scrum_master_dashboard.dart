// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ScrumMasterDashboardScreen extends GovernedWorkspaceEntry {
  const ScrumMasterDashboardScreen({super.key})
      : super(route: '/management/scrum-master-dashboard');
}
