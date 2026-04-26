// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class IncidentReviews extends ConsumerWidget {
  IncidentReviews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.incident_reviews'.tr(),
      subtitle: 'navigation.items.incident_reviews'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
