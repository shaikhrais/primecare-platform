import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_ui/primecare_ui.dart';

class FranchiseSalesManagerDashboardScreen extends ConsumerWidget {
  const FranchiseSalesManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'businessDevelopment.franchiseSalesManager.dashboard.title',
        subtitle: 'businessDevelopment.franchiseSalesManager.dashboard.subtitle',
        provider: franchiseSalesManagerDashboardDataProvider('franchise_sales_manager'),
      );
}
