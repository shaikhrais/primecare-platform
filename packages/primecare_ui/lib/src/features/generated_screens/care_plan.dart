import 'package:primecare_ui/primecare_ui.dart';

class CarePlan extends GovernedStatelessWidget {
  const CarePlan({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'CarePlan',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
