import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PartnershipManagerDashboardScreen extends ConsumerWidget {
  const PartnershipManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'businessDevelopment.partnershipManager.dashboard.title',
        subtitle: 'businessDevelopment.partnershipManager.dashboard.subtitle',
        provider: partnershipManagerDashboardDataProvider('partnership_manager'),
      );
}
