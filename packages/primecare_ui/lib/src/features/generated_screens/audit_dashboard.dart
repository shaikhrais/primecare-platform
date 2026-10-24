// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class AuditDashboardScreen extends GovernedWorkspaceEntry {
  const AuditDashboardScreen({super.key})
      : super(route: '/generated/audit-dashboard');
}
