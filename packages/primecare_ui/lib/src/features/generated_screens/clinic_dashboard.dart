// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class ClinicDashboardScreen extends GovernedWorkspaceEntry {
  const ClinicDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/clinical_director/clinic-dashboard');
}
