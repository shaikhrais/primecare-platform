// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class FamilyHome extends ConsumerWidget {
  const FamilyHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.family_home'.tr(),
      subtitle: 'navigation.items.family_home'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
