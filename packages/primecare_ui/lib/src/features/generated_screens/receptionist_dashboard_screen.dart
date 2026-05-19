import 'package:primecare_ui/primecare_ui.dart';

class ReceptionistDashboardScreen extends GovernedStatelessWidget {
  const ReceptionistDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'ReceptionistDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
