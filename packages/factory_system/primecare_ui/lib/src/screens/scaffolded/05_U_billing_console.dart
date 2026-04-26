// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class BillingConsole extends ConsumerWidget {
  const BillingConsole({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.billing_console'.tr(),
      subtitle: 'navigation.items.billing_console'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
