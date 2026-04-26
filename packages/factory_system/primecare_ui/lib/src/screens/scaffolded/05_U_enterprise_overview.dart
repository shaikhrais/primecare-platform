// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class EnterpriseOverview extends ConsumerWidget {
  const EnterpriseOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.enterprise_overview'.tr(),
      subtitle: 'navigation.items.enterprise_overview'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
