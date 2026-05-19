import 'package:primecare_ui/primecare_ui.dart';

class NotificationCenter extends GovernedStatelessWidget {
  const NotificationCenter({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'NotificationCenter',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
