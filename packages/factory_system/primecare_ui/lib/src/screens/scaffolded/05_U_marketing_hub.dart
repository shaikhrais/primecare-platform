// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class MarketingHub extends ConsumerWidget {
  const MarketingHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.marketing_hub'.tr(),
      subtitle: 'navigation.items.marketing_hub'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
