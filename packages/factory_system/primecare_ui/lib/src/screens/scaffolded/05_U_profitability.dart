// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class Profitability extends ConsumerWidget {
  const Profitability({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.profitability'.tr(),
      subtitle: 'navigation.items.profitability'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
