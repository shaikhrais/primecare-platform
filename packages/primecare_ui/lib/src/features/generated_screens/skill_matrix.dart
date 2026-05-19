import 'package:primecare_ui/primecare_ui.dart';

class SkillMatrix extends GovernedStatelessWidget {
  const SkillMatrix({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'SkillMatrix',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
