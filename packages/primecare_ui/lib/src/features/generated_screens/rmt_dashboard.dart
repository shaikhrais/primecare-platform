// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class RmtDashboardScreen extends GovernedWorkspaceEntry {
  const RmtDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/rmt/dashboard');
}
