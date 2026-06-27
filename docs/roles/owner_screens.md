# Franchise Owner

## Role Summary

* **Role key**: `owner`
* **Role category**: `corporate`
* **Total screens**: 15
* **Business ready screens**: 0
* **Incomplete screens**: 15
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 44.0%
* **Average screen-body interactions**: 3.2

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| FranchiseDashboardScreen | `/common/franchise-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | revenue, royalty, agreement, profit | **No** |
| OwnerDashboardScreen | `/offices/corporate/roles/owner/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | franchise, revenue, royalty, agreement, profit | **No** |
| OwnerAnalyticsScreen | `/executive/owner-analytics` | 2 | 0 | `LOW_INTERACTION` | 4 | 1 | revenue, royalty, agreement, profit | **No** |
| OwnerWorkflowScreen | `/executive/owner-workflow` | 2 | 0 | `LOW_INTERACTION` | 2 | 1 | revenue, royalty, agreement, profit | **No** |
| FranchiseOwnerCommandCenterScreen | `/executive/franchise-owner-command-center` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | revenue, royalty, agreement, profit | **No** |
| FranchiseOwnerBranchOverviewScreen | `/offices/franchise/roles/franchise_owner/branch-overview` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | revenue, royalty, agreement, profit | **No** |
| FranchiseOwnerStaffScreen | `/offices/franchise/roles/franchise_owner/staff` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | revenue, royalty, agreement, profit | **No** |
| FranchiseOwnerClientsScreen | `/offices/franchise/roles/franchise_owner/clients` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | revenue, royalty, agreement, profit | **No** |
| FranchiseOwnerAppointmentsScreen | `/offices/franchise/roles/franchise_owner/appointments` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | revenue, royalty, agreement, profit | **No** |
| FranchiseOwnerFinanceSnapshotScreen | `/executive/franchise-owner-finance-snapshot` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | revenue, royalty, agreement, profit | **No** |
| FranchiseOwnerComplianceScreen | `/offices/franchise/roles/franchise_owner/compliance` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | revenue, royalty, agreement, profit | **No** |
| FranchiseOwnerReportsScreen | `/offices/franchise/roles/franchise_owner/reports` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | revenue, royalty, agreement, profit | **No** |
| Franchise Owner Dashboard | `/offices/franchise/roles/franchise_owner/dashboard` | 8 | 6 | `MEANINGFUL` | 8 | 1 | revenue, royalty, agreement, profit | **No** |
| Franchise Owner Financial Snapshot | `/offices/franchise/roles/franchise_owner/financial-snapshot` | 8 | 6 | `MEANINGFUL` | 8 | 2 | revenue, agreement, profit | **No** |
| Franchise Owner Hiring | `/offices/franchise/roles/franchise_owner/hiring` | 8 | 6 | `MEANINGFUL` | 7 | 1 | revenue, royalty, agreement, profit | **No** |

## Screen Details

### FranchiseDashboardScreen

* **Route**: `/common/franchise-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/franchise_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Role Expectation Score**: 1
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for FranchiseDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### OwnerDashboardScreen

* **Route**: `/offices/corporate/roles/owner/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/owner_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Role Expectation Score**: 0
* **Missing Business Features**: franchise, revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for OwnerDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### OwnerAnalyticsScreen

* **Route**: `/executive/owner-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/owner_analytics_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 1
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Business intelligence analytics dashboard for OwnerAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### OwnerWorkflowScreen

* **Route**: `/executive/owner-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/owner_workflow_screen.dart`
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
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Operational workflow configuration and tracking screen for OwnerWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FranchiseOwnerCommandCenterScreen

* **Route**: `/executive/franchise-owner-command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_command_center_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for FranchiseOwnerCommandCenterScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FranchiseOwnerBranchOverviewScreen

* **Route**: `/offices/franchise/roles/franchise_owner/branch-overview`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_branch_overview_screen.dart`
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
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for FranchiseOwnerBranchOverviewScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FranchiseOwnerStaffScreen

* **Route**: `/offices/franchise/roles/franchise_owner/staff`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_staff_screen.dart`
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
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for FranchiseOwnerStaffScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FranchiseOwnerClientsScreen

* **Route**: `/offices/franchise/roles/franchise_owner/clients`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_clients_screen.dart`
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
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for FranchiseOwnerClientsScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FranchiseOwnerAppointmentsScreen

* **Route**: `/offices/franchise/roles/franchise_owner/appointments`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_appointments_screen.dart`
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
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for FranchiseOwnerAppointmentsScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FranchiseOwnerFinanceSnapshotScreen

* **Route**: `/executive/franchise-owner-finance-snapshot`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_finance_snapshot_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Chief Financial Officer dashboard for ledger auditing, P&L monitoring, payroll, tax compliance, and revenue tracking.
* **Primary user goal**: Track clinical revenue, approve payroll runs, monitor profit margins, and review tax remittances.
* **Expected user actions**: Download ledger sheets, filter revenue by branch, trigger Plaid bank sync, approve invoice claims.
* **Business reason**: Ensures financial audits, tax compliance, and payroll distributions are accurate and automated.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FranchiseOwnerComplianceScreen

* **Route**: `/offices/franchise/roles/franchise_owner/compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_compliance_screen.dart`
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
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Regulatory compliance tracking and audit registry for FranchiseOwnerComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FranchiseOwnerReportsScreen

* **Route**: `/offices/franchise/roles/franchise_owner/reports`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/franchise_owner_reports_screen.dart`
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
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for FranchiseOwnerReportsScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Franchise Owner Dashboard

* **Route**: `/offices/franchise/roles/franchise_owner/dashboard`
* **Component file**: `apps/primecare_franchise/lib/features/owner/screens/franchise_owner_dashboard_screen.dart`
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
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Management workspace screen for Franchise Owner Dashboard module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: revenue, royalty, agreement, profit
* **Next action**: Implement expected workflows for owner role.

### Franchise Owner Financial Snapshot

* **Route**: `/offices/franchise/roles/franchise_owner/financial-snapshot`
* **Component file**: `apps/primecare_franchise/lib/features/owner/screens/franchise_owner_financial_snapshot_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: revenue, agreement, profit
* **Purpose**: Management workspace screen for Franchise Owner Financial Snapshot module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: revenue, agreement, profit
* **Next action**: Implement expected workflows for owner role.

### Franchise Owner Hiring

* **Route**: `/offices/franchise/roles/franchise_owner/hiring`
* **Component file**: `apps/primecare_franchise/lib/features/owner/screens/franchise_owner_hiring_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: revenue, royalty, agreement, profit
* **Purpose**: Human Resources dashboard to track applicants, schedule credentials, and monitor credential expiries.
* **Primary user goal**: Hire new healthcare staff, verify licenses, and manage staff onboarding checklists.
* **Expected user actions**: Filter applications, click schedule interview, upload credential file, verify background check.
* **Business reason**: Ensures all hired staff are fully vetted, qualified, and compliant with nursing association rules.
* **Missing items**: Missing core role features: revenue, royalty, agreement, profit
* **Next action**: Implement expected workflows for owner role.

## Screens to Fix First

1. **Franchise Owner Dashboard** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: revenue, royalty, agreement, profit
2. **Franchise Owner Financial Snapshot** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: revenue, agreement, profit
3. **Franchise Owner Hiring** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: revenue, royalty, agreement, profit
4. **OwnerAnalyticsScreen** (Progress: 40%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: revenue, royalty, agreement, profit
5. **OwnerWorkflowScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: revenue, royalty, agreement, profit
6. **FranchiseDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: revenue, royalty, agreement, profit
7. **OwnerDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: franchise, revenue, royalty, agreement, profit
8. **FranchiseOwnerCommandCenterScreen** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: revenue, royalty, agreement, profit
9. **FranchiseOwnerBranchOverviewScreen** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: revenue, royalty, agreement, profit
10. **FranchiseOwnerStaffScreen** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: revenue, royalty, agreement, profit

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Franchise Owner Dashboard (Implement role-specific workflows and transactional features)
- Franchise Owner Financial Snapshot (Implement role-specific workflows and transactional features)
- Franchise Owner Hiring (Implement role-specific workflows and transactional features)
- OwnerAnalyticsScreen (Implement role-specific workflows and transactional features)
- OwnerWorkflowScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
