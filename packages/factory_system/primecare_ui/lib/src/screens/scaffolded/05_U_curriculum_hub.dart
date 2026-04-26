// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class CurriculumHub extends ConsumerWidget {
  const CurriculumHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.curriculum_hub'.tr(),
      subtitle: 'navigation.items.curriculum_hub'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
