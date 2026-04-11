import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipManagerDashboard extends ConsumerWidget {
  const PartnershipManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.partnershipManager.dashboard.title',
        subtitle: 'business_development.partnershipManager.dashboard.subtitle',
        provider: partnershipManagerDashboardDataProvider('partnership_manager'),
      );
}
