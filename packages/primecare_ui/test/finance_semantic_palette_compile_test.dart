import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/features/generated_screens/billing_console.dart' as view0;
import 'package:primecare_ui/src/features/generated_screens/financial_performance.dart' as view1;
import 'package:primecare_ui/src/features/generated_screens/branch_operations.dart' as view2;
import 'package:primecare_ui/src/features/generated_screens/region_dashboard.dart' as view3;
import 'package:primecare_ui/src/features/generated_screens/region_performance.dart' as view4;
import 'package:primecare_ui/src/features/generated_screens/cash_flow.dart' as view5;
import 'package:primecare_ui/src/features/generated_screens/profitability.dart' as view6;
import 'package:primecare_ui/src/features/generated_screens/revenue_tracker.dart' as view7;
import 'package:primecare_ui/src/features/generated_screens/tax_remittance.dart' as view8;
import 'package:primecare_ui/src/features/generated_screens/invoices.dart' as view9;
import 'package:primecare_ui/src/features/generated_screens/financial_overview.dart' as view10;
import 'package:primecare_ui/src/features/generated_screens/business_overview.dart' as view11;

void main() {
  test('all 12 finance and region palette consumers compile', () {
    final types=<Type>[
      view0.BillingConsoleState,
      view1.FinancialPerformanceState,
      view2.BranchOperationsState,
      view3.RegionDashboardState,
      view4.RegionPerformanceState,
      view5.CashFlowState,
      view6.ProfitabilityState,
      view7.RevenueTrackerState,
      view8.TaxRemittanceState,
      view9.InvoicesState,
      view10.FinancialOverviewState,
      view11.BusinessOverviewState
    ];
    expect(types,hasLength(12));
  });
}
