// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class Invoices extends ConsumerWidget {
  const Invoices({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.invoices'.tr(),
      subtitle: 'navigation.items.invoices'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
