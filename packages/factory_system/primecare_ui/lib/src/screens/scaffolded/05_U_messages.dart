// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class Messages extends ConsumerWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.messages'.tr(),
      subtitle: 'navigation.items.messages'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
