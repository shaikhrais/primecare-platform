import 'package:primecare_ui/primecare_ui.dart';

class PendingAssessments extends StatelessWidget {
  const PendingAssessments({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'PendingAssessments',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
