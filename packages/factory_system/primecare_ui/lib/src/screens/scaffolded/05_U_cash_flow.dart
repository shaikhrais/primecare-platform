// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class CashFlow extends ConsumerWidget {
  const CashFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.cash_flow'.tr(),
      subtitle: 'navigation.items.cash_flow'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
