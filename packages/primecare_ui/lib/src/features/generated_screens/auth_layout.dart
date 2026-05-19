import 'package:primecare_ui/primecare_ui.dart';

class AuthLayout extends GovernedStatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'AuthLayout',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
