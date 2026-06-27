# Chief Financial Officer (CFO)

## Role Summary

* **Role key**: `cfo`
* **Role category**: `corporate`
* **Total screens**: 17
* **Business ready screens**: 1
* **Incomplete screens**: 17
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 32.9%
* **Average screen-body interactions**: 4.5

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CfoDashboardScreen | `/offices/corporate/roles/cfo/dashboard` | 9 | 2 | `MEANINGFUL` | 9 | 5 | P&L, balance-sheet, budget, audit, comparison | **Yes** |
| CfoAnalyticsScreen | `/executive/cfo-analytics` | 2 | 0 | `LOW_INTERACTION` | 2 | 1 | ledger, P&L, balance-sheet, tax, payroll, invoice, export, audit, comparison | **No** |
| CfoWorkflowScreen | `/executive/cfo-workflow` | 2 | 0 | `LOW_INTERACTION` | 3 | 1 | ledger, P&L, balance-sheet, tax, payroll, invoice, export, audit, comparison | **No** |
| CfoRevenueScreen | `/offices/corporate/roles/cfo/revenue` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | ledger, P&L, balance-sheet, tax, payroll, budget, invoice, export, comparison | **No** |
| CfoExpensesScreen | `/offices/corporate/roles/cfo/expenses` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | ledger, P&L, balance-sheet, tax, payroll, budget, invoice, export, comparison | **No** |
| CfoPayrollScreen | `/offices/corporate/roles/cfo/payroll` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | ledger, P&L, balance-sheet, tax, budget, invoice, export, comparison | **No** |
| CfoInvoicesScreen | `/offices/corporate/roles/cfo/invoices` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | ledger, P&L, balance-sheet, tax, payroll, budget, export, comparison | **No** |
| CfoTaxScreen | `/executive/cfo-tax` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | ledger, P&L, balance-sheet, payroll, invoice, comparison | **No** |
| CfoProfitabilityScreen | `/offices/corporate/roles/cfo/profitability` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | ledger, P&L, balance-sheet, tax, payroll, budget, invoice, export, comparison | **No** |
| CfoCashflowScreen | `/executive/cfo-cashflow` | 2 | 1 | `LOW_INTERACTION` | 3 | 3 | ledger, P&L, balance-sheet, tax, payroll, invoice, export | **No** |
| FinancialDashboardScreen | `/executive/financial-dashboard` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | ledger, P&L, balance-sheet, tax, payroll, invoice, export, comparison | **No** |
| Cfo Accounts Payable | `/offices/corporate/roles/cfo/accounts-payable` | 8 | 6 | `MEANINGFUL` | 9 | 2 | P&L, balance-sheet, tax, payroll, budget, export, audit, comparison | **No** |
| Cfo Accounts Receivable | `/offices/corporate/roles/cfo/accounts-receivable` | 8 | 6 | `MEANINGFUL` | 8 | 1 | ledger, P&L, balance-sheet, tax, payroll, budget, export, audit, comparison | **No** |
| Cfo Financial Overview | `/offices/corporate/roles/cfo/financial-overview` | 8 | 6 | `MEANINGFUL` | 7 | 2 | balance-sheet, tax, payroll, budget, invoice, export, audit, comparison | **No** |
| Cfo Franchise Financials | `/offices/corporate/roles/cfo/franchise-financials` | 8 | 6 | `MEANINGFUL` | 7 | 3 | P&L, balance-sheet, tax, payroll, budget, export, comparison | **No** |
| Cfo Reports | `/offices/corporate/roles/cfo/reports` | 8 | 6 | `MEANINGFUL` | 8 | 3 | ledger, P&L, balance-sheet, payroll, budget, invoice, comparison | **No** |
| Cfo Tax And Remittance | `/offices/corporate/roles/cfo/tax-and-remittance` | 8 | 6 | `MEANINGFUL` | 7 | 2 | ledger, P&L, balance-sheet, budget, invoice, export, audit, comparison | **No** |

## Screen Details

### CfoDashboardScreen

* **Route**: `/offices/corporate/roles/cfo/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/cfo_dashboard.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 9
  * **Buttons**: 6
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 1
  * **Clickable Cards**: 1
* **Global Navigation Count**: 2
* **Business Workflow Score**: 9
* **Role Expectation Score**: 5
* **Missing Business Features**: P&L, balance-sheet, budget, audit, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: None
* **Next action**: None

### CfoAnalyticsScreen

* **Route**: `/executive/cfo-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_analytics_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 2
* **Role Expectation Score**: 1
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, invoice, export, audit, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CfoWorkflowScreen

* **Route**: `/executive/cfo-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_workflow_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, invoice, export, audit, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CfoRevenueScreen

* **Route**: `/offices/corporate/roles/cfo/revenue`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_revenue_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, budget, invoice, export, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CfoExpensesScreen

* **Route**: `/offices/corporate/roles/cfo/expenses`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_expenses_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, budget, invoice, export, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CfoPayrollScreen

* **Route**: `/offices/corporate/roles/cfo/payroll`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_payroll_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, budget, invoice, export, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CfoInvoicesScreen

* **Route**: `/offices/corporate/roles/cfo/invoices`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_invoices_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, budget, export, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CfoTaxScreen

* **Route**: `/executive/cfo-tax`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_tax_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 5
* **Role Expectation Score**: 4
* **Missing Business Features**: ledger, P&L, balance-sheet, payroll, invoice, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CfoProfitabilityScreen

* **Route**: `/offices/corporate/roles/cfo/profitability`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_profitability_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, budget, invoice, export, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CfoCashflowScreen

* **Route**: `/executive/cfo-cashflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/cfo_cashflow_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 3
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, invoice, export
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FinancialDashboardScreen

* **Route**: `/executive/financial-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/financial_dashboard_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 4
* **Role Expectation Score**: 2
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, invoice, export, comparison
* **Purpose**: Management workspace screen for FinancialDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Cfo Accounts Payable

* **Route**: `/offices/corporate/roles/cfo/accounts-payable`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/cfo_accounts_payable_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 9
* **Role Expectation Score**: 2
* **Missing Business Features**: P&L, balance-sheet, tax, payroll, budget, export, audit, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Missing core role features: P&L, balance-sheet, tax, payroll, budget, export, audit, comparison
* **Next action**: Implement expected workflows for cfo role.

### Cfo Accounts Receivable

* **Route**: `/offices/corporate/roles/cfo/accounts-receivable`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/cfo_accounts_receivable_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 8
* **Role Expectation Score**: 1
* **Missing Business Features**: ledger, P&L, balance-sheet, tax, payroll, budget, export, audit, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Missing core role features: ledger, P&L, balance-sheet, tax, payroll, budget, export, audit, comparison
* **Next action**: Implement expected workflows for cfo role.

### Cfo Financial Overview

* **Route**: `/offices/corporate/roles/cfo/financial-overview`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/cfo_financial_overview_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 2
* **Missing Business Features**: balance-sheet, tax, payroll, budget, invoice, export, audit, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Missing core role features: balance-sheet, tax, payroll, budget, invoice, export, audit, comparison
* **Next action**: Implement expected workflows for cfo role.

### Cfo Franchise Financials

* **Route**: `/offices/corporate/roles/cfo/franchise-financials`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/cfo_franchise_financials_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 3
* **Missing Business Features**: P&L, balance-sheet, tax, payroll, budget, export, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Missing core role features: P&L, balance-sheet, tax, payroll, budget, export, comparison
* **Next action**: Implement expected workflows for cfo role.

### Cfo Reports

* **Route**: `/offices/corporate/roles/cfo/reports`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/cfo_reports_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 8
* **Role Expectation Score**: 3
* **Missing Business Features**: ledger, P&L, balance-sheet, payroll, budget, invoice, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Missing core role features: ledger, P&L, balance-sheet, payroll, budget, invoice, comparison
* **Next action**: Implement expected workflows for cfo role.

### Cfo Tax And Remittance

* **Route**: `/offices/corporate/roles/cfo/tax-and-remittance`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/cfo_tax_and_remittance_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 2
* **Missing Business Features**: ledger, P&L, balance-sheet, budget, invoice, export, audit, comparison
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Missing core role features: ledger, P&L, balance-sheet, budget, invoice, export, audit, comparison
* **Next action**: Implement expected workflows for cfo role.

## Screens to Fix First

1. **Cfo Accounts Payable** (Progress: 0%, Business Score: 9, Role Score: 2)  
   *Reason*: Missing core workflows/features: P&L, balance-sheet, tax, payroll, budget, export, audit, comparison
2. **Cfo Accounts Receivable** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: ledger, P&L, balance-sheet, tax, payroll, budget, export, audit, comparison
3. **Cfo Financial Overview** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: balance-sheet, tax, payroll, budget, invoice, export, audit, comparison
4. **Cfo Franchise Financials** (Progress: 0%, Business Score: 7, Role Score: 3)  
   *Reason*: Missing core workflows/features: P&L, balance-sheet, tax, payroll, budget, export, comparison
5. **Cfo Reports** (Progress: 0%, Business Score: 8, Role Score: 3)  
   *Reason*: Missing core workflows/features: ledger, P&L, balance-sheet, payroll, budget, invoice, comparison
6. **Cfo Tax And Remittance** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: ledger, P&L, balance-sheet, budget, invoice, export, audit, comparison
7. **CfoAnalyticsScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: ledger, P&L, balance-sheet, tax, payroll, invoice, export, audit, comparison
8. **CfoWorkflowScreen** (Progress: 40%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: ledger, P&L, balance-sheet, tax, payroll, invoice, export, audit, comparison
9. **CfoRevenueScreen** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: ledger, P&L, balance-sheet, tax, payroll, budget, invoice, export, comparison
10. **CfoExpensesScreen** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: ledger, P&L, balance-sheet, tax, payroll, budget, invoice, export, comparison

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Cfo Accounts Payable (Implement role-specific workflows and transactional features)
- Cfo Accounts Receivable (Implement role-specific workflows and transactional features)
- Cfo Financial Overview (Implement role-specific workflows and transactional features)
- Cfo Franchise Financials (Implement role-specific workflows and transactional features)
- Cfo Reports (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- CfoDashboardScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
