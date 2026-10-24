// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ShareholderDashboardScreen extends GovernedWorkspaceEntry {
  const ShareholderDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/shareholder/dashboard');
}
