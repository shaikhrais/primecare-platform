// Governance - Category: view | Purpose: UI Screen component rendering the Receptionist Appointments Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

class ReceptionistAppointmentsScreen extends GovernedStatelessWidget {
  const ReceptionistAppointmentsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'ReceptionistAppointmentsScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
