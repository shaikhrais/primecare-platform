// Existing registered entry; domain actions remain subject to their own contracts.
import '../workspace/governed_workspace_screen.dart';

class TherapistDashboardScreen extends GovernedWorkspaceEntry {
  const TherapistDashboardScreen({super.key})
      : super(route: '/offices/clinical/roles/therapist/dashboard');
}
