import 'package:primecare_ui/primecare_ui.dart';

class HrOnboardingScreen extends GovernedStatelessWidget {
  const HrOnboardingScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'HrOnboardingScreen',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
