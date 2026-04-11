import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CustomerSupportDashboardScreen extends ConsumerWidget {
  const CustomerSupportDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'common.customerSupport.dashboard.title',
        subtitle: 'common.customerSupport.dashboard.subtitle',
        provider: customerSupportDashboardDataProvider('customer_support'),
      );
}
