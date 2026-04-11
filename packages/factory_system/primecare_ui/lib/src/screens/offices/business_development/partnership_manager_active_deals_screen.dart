import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipManagerActiveDealsScreen extends ConsumerWidget {
  const PartnershipManagerActiveDealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Partnership Manager Active Deals',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: partnershipManagerDashboardDataProvider('partnership_manager_active_deals'),
      );
}
