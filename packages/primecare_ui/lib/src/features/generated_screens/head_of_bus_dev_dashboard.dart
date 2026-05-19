import 'package:primecare_ui/primecare_ui.dart';

class HeadOfBusDevDashboard extends GovernedStatelessWidget {
  const HeadOfBusDevDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'HeadOfBusDevDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
