// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class RpnDashboardScreen extends GovernedWorkspaceEntry {
  const RpnDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/rpn/dashboard');
}
