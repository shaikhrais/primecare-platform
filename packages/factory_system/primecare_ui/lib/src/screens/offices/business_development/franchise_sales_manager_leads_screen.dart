import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseSalesManagerLeadsScreen extends ConsumerWidget {
  const FranchiseSalesManagerLeadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Franchise Sales Manager Leads',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: franchiseSalesManagerDashboardDataProvider('franchise_sales_manager_leads'),
      );
}
