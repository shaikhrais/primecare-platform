// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class CampaignAnalytics extends ConsumerWidget {
  const CampaignAnalytics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.campaign_analytics'.tr(),
      subtitle: 'navigation.items.campaign_analytics'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
