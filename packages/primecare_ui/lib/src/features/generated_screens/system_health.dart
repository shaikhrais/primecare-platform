import 'package:primecare_ui/primecare_ui.dart';

class SystemHealth extends StatelessWidget {
  const SystemHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: LucideIcons.layoutTemplate,
      title: 'SystemHealth',
      subtitle: 'Premium feature module pending hydration.',
      actionLabel: 'Refresh',
      onAction: () {},
    );
  }
}
