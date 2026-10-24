// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class NpDashboardScreen extends GovernedWorkspaceEntry {
  const NpDashboardScreen({super.key})
      : super(route: '/clinical/np-dashboard');
}
