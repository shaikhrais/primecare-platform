// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class GovernanceOfficerDashboardScreen extends GovernedWorkspaceEntry {
  const GovernanceOfficerDashboardScreen({super.key})
      : super(route: '/management/governance-officer-dashboard');
}
