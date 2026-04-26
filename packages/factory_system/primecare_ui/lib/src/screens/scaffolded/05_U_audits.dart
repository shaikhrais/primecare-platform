// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class Audits extends ConsumerWidget {
  const Audits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.audits'.tr(),
      subtitle: 'navigation.items.audits'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
