// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PolicyManager extends ConsumerWidget {
  const PolicyManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.policy_manager'.tr(),
      subtitle: 'navigation.items.policy_manager'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
