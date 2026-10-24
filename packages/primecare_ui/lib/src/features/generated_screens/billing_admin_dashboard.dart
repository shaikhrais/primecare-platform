// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class BillingAdminDashboardScreen extends GovernedWorkspaceEntry {
  const BillingAdminDashboardScreen({super.key})
      : super(route: '/offices/franchise/roles/billing_admin/dashboard');
}
