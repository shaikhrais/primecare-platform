// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class LegalDashboardScreen extends GovernedWorkspaceEntry {
  const LegalDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/legal/dashboard');
}
