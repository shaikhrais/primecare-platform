// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceStatus extends ConsumerWidget {
  ComplianceStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.compliance_status'.tr(),
      subtitle: 'navigation.items.compliance_status'.tr(),

      body: Center(
        child: Text(LocaleKeys.dashboards_common_labels_provisioning.tr()),
      ),
    );
  }
}
