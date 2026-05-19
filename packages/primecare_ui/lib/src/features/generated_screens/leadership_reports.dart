import 'package:primecare_ui/primecare_ui.dart';

class LeadershipReports extends GovernedStatelessWidget {
  const LeadershipReports({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'LeadershipReports',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
