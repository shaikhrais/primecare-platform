import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class PremiumFeature13 extends GovernedConsumerWidget {
  const PremiumFeature13({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Premium Feature 13',
      subtitle: 'Premium Dashboard',
      kpiCards: const SizedBox(),
      child: Center(
        child: Text('Hydrated Premium Feature 13'),
      ),
    );
  }
}
