// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class AuditLogs extends ConsumerWidget {
  const AuditLogs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
      title: 'navigation.items.audit_logs'.tr(),
      subtitle: 'navigation.items.audit_logs'.tr(),
      
      body: Center(child: Text('Provisioning...')),
    );
  }
}
