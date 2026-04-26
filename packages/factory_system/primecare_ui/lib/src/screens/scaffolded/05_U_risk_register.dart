// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class RiskRegister extends ConsumerWidget {
  const RiskRegister({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.risk_register'.tr(),
      subtitle: 'navigation.items.risk_register'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
