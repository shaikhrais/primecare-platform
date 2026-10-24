// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class CooDashboardScreen extends GovernedWorkspaceEntry {
  const CooDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/coo/dashboard');
}
