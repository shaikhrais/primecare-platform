import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseSalesManagerDashboard extends ConsumerWidget {
  const FranchiseSalesManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'business_development.franchiseSalesManager.dashboard.title',
        subtitle: 'business_development.franchiseSalesManager.dashboard.subtitle',
        provider: franchiseSalesManagerDashboardDataProvider('franchise_sales_manager'),
      );
}
