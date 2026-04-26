// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class Cases extends ConsumerWidget {
  const Cases({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.cases'.tr(),
      subtitle: 'navigation.items.cases'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
