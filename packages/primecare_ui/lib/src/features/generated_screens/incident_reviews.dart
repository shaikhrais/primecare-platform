import 'package:primecare_ui/primecare_ui.dart';

class IncidentReviews extends GovernedStatelessWidget {
  const IncidentReviews({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'IncidentReviews',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
