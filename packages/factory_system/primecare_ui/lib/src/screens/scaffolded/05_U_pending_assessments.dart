// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PendingAssessments extends ConsumerWidget {
  const PendingAssessments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.pending_assessments'.tr(),
      subtitle: 'navigation.items.pending_assessments'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
