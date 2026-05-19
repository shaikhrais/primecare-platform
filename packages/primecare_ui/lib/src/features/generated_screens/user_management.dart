import 'package:primecare_ui/primecare_ui.dart';

class UserManagement extends GovernedStatelessWidget {
  const UserManagement({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'UserManagement',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
