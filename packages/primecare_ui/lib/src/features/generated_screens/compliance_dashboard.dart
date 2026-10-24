// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ComplianceDashboardScreen extends GovernedWorkspaceEntry {
  const ComplianceDashboardScreen({super.key})
      : super(route: '/management/compliance-dashboard');
}
