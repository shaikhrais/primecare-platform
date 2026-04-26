// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class CarePlan extends ConsumerWidget {
  const CarePlan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.care_plan'.tr(),
      subtitle: 'navigation.items.care_plan'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
