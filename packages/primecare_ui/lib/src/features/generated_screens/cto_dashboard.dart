// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class CtoDashboardScreen extends GovernedWorkspaceEntry {
  const CtoDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/cto/dashboard');
}
