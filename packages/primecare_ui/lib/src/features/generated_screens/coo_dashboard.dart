import 'package:primecare_ui/primecare_ui.dart';

class CooDashboard extends GovernedStatelessWidget {
  const CooDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CooDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
