import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class PremiumFeature130 extends GovernedConsumerWidget {
  const PremiumFeature130({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'Premium Feature 130',
      subtitle: 'Premium Dashboard',
      kpiCards: const SizedBox(),
      child: Center(
        child: Text('Hydrated Premium Feature 130'),
      ),
    );
  }
}
