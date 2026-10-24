// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class OwnerDashboardScreen extends GovernedWorkspaceEntry {
  const OwnerDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/owner/dashboard');
}
