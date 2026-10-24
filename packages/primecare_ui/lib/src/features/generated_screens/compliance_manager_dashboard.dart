// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ComplianceManagerDashboardScreen extends GovernedWorkspaceEntry {
  const ComplianceManagerDashboardScreen({super.key})
      : super(route: '/offices/corporate/roles/compliance_manager/dashboard');
}
