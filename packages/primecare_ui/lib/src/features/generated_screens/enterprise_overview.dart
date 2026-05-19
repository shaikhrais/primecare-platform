import 'package:primecare_ui/primecare_ui.dart';

class EnterpriseOverview extends GovernedStatelessWidget {
  const EnterpriseOverview({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'EnterpriseOverview',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
