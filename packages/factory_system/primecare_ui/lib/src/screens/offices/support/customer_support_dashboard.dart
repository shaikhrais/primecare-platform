import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart' hide customerSupportDashboardAdapterProvider;
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CustomerSupportDashboard extends ConsumerWidget {
  const CustomerSupportDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'support.customerSupport.dashboard.title',
        subtitle: 'support.customerSupport.dashboard.subtitle',
        provider: customerSupportDashboardAdapterProvider,
      );
}
