import 'package:primecare_ui/primecare_ui.dart';

class SchedulingHealth extends GovernedStatelessWidget {
  const SchedulingHealth({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'SchedulingHealth',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
