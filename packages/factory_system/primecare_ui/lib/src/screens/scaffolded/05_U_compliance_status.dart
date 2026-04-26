// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ComplianceStatus extends ConsumerWidget {
  const ComplianceStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.compliance_status'.tr(),
      subtitle: 'navigation.items.compliance_status'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
