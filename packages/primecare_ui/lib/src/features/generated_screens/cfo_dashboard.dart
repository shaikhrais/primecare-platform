// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class CfoDashboardScreen extends GovernedWorkspaceEntry {
  const CfoDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/cfo/dashboard');
}
