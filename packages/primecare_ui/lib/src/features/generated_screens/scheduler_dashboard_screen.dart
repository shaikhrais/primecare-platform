import 'package:primecare_ui/primecare_ui.dart';

class SchedulerDashboardScreen extends GovernedStatelessWidget {
  const SchedulerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'SchedulerDashboardScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
