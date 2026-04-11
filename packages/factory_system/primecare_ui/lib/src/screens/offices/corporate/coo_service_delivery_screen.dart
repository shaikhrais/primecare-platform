import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CooServiceDeliveryScreen extends ConsumerWidget {
  const CooServiceDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Coo Service Delivery',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: cooDashboardDataProvider('coo_service_delivery'),
      );
}
