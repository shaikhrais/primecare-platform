// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class LeadershipReports extends ConsumerWidget {
  const LeadershipReports({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.leadership_reports'.tr(),
      subtitle: 'navigation.items.leadership_reports'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
