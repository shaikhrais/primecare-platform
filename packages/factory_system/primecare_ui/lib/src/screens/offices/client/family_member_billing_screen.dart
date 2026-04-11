import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart' hide clientDashboardAdapterProvider;
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FamilyMemberBillingScreen extends ConsumerWidget {
  const FamilyMemberBillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'FamilyMemberBillingScreen',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: clientDashboardAdapterProvider,
      );
}
