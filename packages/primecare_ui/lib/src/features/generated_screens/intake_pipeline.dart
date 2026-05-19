import 'package:primecare_ui/primecare_ui.dart';

class IntakePipeline extends GovernedStatelessWidget {
  const IntakePipeline({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'IntakePipeline',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
