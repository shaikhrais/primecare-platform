// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class HipaaAuditDashboardScreen extends GovernedWorkspaceEntry {
  const HipaaAuditDashboardScreen({super.key})
      : super(route: '/generated/hipaa-audit-dashboard');
}
