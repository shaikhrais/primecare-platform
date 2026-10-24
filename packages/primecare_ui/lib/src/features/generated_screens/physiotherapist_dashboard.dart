// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class PhysiotherapistDashboardScreen extends GovernedWorkspaceEntry {
  const PhysiotherapistDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/physiotherapist/dashboard');
}
