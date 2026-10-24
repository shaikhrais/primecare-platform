// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class EscalationDashboardScreen extends GovernedWorkspaceEntry {
  const EscalationDashboardScreen({super.key})
      : super(route: '/support/escalation-dashboard');
}
