import 'package:primecare_ui/primecare_ui.dart';

class CurriculumHub extends GovernedStatelessWidget {
  const CurriculumHub({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CurriculumHub',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
