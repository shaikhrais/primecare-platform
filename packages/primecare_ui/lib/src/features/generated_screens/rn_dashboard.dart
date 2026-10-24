// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class RnDashboardScreen extends GovernedWorkspaceEntry {
  const RnDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/rn/dashboard');
}
