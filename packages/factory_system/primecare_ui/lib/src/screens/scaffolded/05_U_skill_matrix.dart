// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class SkillMatrix extends ConsumerWidget {
  const SkillMatrix({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.skill_matrix'.tr(),
      subtitle: 'navigation.items.skill_matrix'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
