import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart' hide customerSupportDashboardAdapterProvider;
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CustomerSupportTemplatesScreen extends ConsumerWidget {
  const CustomerSupportTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'CustomerSupportTemplatesScreen',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: customerSupportDashboardAdapterProvider,
      );
}
