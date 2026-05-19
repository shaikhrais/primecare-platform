import 'package:primecare_ui/primecare_ui.dart';

class SchedulerCalendarScreen extends GovernedStatelessWidget {
  const SchedulerCalendarScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'SchedulerCalendarScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
