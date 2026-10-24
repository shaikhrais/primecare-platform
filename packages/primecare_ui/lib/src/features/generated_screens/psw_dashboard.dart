// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class PswDashboardScreen extends GovernedWorkspaceEntry {
  const PswDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/psw/dashboard');
}
