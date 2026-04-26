// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceHub extends ConsumerWidget {
  ComplianceHub({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: LocaleKeys.dashboards_common_labels_compliance_hub.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_regulatory_and_standard_compliance_status
          .tr(),
      kpis: [],
      body: Center(
        child: Text(
          LocaleKeys.dashboards_common_labels_compliance_interface_provisioning
              .tr(),
        ),
      ),
    );
  }
}
