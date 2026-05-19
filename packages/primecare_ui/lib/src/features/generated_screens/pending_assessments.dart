import 'package:primecare_ui/primecare_ui.dart';

class PendingAssessments extends GovernedStatelessWidget {
  const PendingAssessments({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'PendingAssessments',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
