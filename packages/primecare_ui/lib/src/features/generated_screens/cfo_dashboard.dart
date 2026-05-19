import 'package:primecare_ui/primecare_ui.dart';

class CfoDashboard extends GovernedStatelessWidget {
  const CfoDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CfoDashboard',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
