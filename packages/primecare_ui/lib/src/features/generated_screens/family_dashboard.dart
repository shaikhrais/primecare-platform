// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class FamilyDashboardScreen extends GovernedWorkspaceEntry {
  const FamilyDashboardScreen({super.key})
      : super(route: '/offices/client/roles/family_member/dashboard');
}
