// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class FranchiseOwnerDashboardScreen extends GovernedWorkspaceEntry {
  const FranchiseOwnerDashboardScreen({super.key})
      : super(route: '/offices/franchise/roles/franchise_owner/dashboard');
}
