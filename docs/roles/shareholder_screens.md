# Shareholder

## Role Summary

* **Role key**: `shareholder`
* **Role category**: `corporate`
* **Total screens**: 4
* **Business ready screens**: 1
* **Incomplete screens**: 4
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 42.5%
* **Average screen-body interactions**: 4.2

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ShareholderDashboardScreen | `/offices/corporate/roles/shareholder/dashboard` | 9 | 2 | `MEANINGFUL` | 6 | 4 | meeting | **Yes** |
| ShareholderAnalyticsScreen | `/executive/shareholder-analytics` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | equity, dividend, meeting, financial | **No** |
| ShareholderComplianceScreen | `/executive/shareholder-compliance` | 4 | 1 | `MEANINGFUL` | 4 | 1 | equity, dividend, meeting, financial | **No** |
| ShareholderWorkflowScreen | `/executive/shareholder-workflow` | 2 | 1 | `LOW_INTERACTION` | 2 | 0 | equity, dividend, meeting, report, financial | **No** |

## Screen Details

### ShareholderDashboardScreen

* **Route**: `/offices/corporate/roles/shareholder/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/shareholder_dashboard.dart`
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
* **Business Workflow Score**: 6
* **Role Expectation Score**: 4
* **Missing Business Features**: meeting
* **Purpose**: Management workspace screen for ShareholderDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### ShareholderAnalyticsScreen

* **Route**: `/executive/shareholder-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/shareholder_analytics_screen.dart`
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
* **Missing Business Features**: equity, dividend, meeting, financial
* **Purpose**: Business intelligence analytics dashboard for ShareholderAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ShareholderComplianceScreen

* **Route**: `/executive/shareholder-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/shareholder_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 4
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 4
* **Role Expectation Score**: 1
* **Missing Business Features**: equity, dividend, meeting, financial
* **Purpose**: Regulatory compliance tracking and audit registry for ShareholderComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Missing core role features: equity, dividend, meeting, financial
* **Next action**: Implement expected workflows for shareholder role.

### ShareholderWorkflowScreen

* **Route**: `/executive/shareholder-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/shareholder_workflow_screen.dart`
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
* **Business Workflow Score**: 2
* **Role Expectation Score**: 0
* **Missing Business Features**: equity, dividend, meeting, report, financial
* **Purpose**: Operational workflow configuration and tracking screen for ShareholderWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **ShareholderComplianceScreen** (Progress: 50%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: equity, dividend, meeting, financial
2. **ShareholderAnalyticsScreen** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: equity, dividend, meeting, financial
3. **ShareholderWorkflowScreen** (Progress: 60%, Business Score: 2, Role Score: 0)  
   *Reason*: Missing core workflows/features: equity, dividend, meeting, report, financial

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- ShareholderComplianceScreen (Implement role-specific workflows and transactional features)
- ShareholderAnalyticsScreen (Implement role-specific workflows and transactional features)
- ShareholderWorkflowScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- ShareholderDashboardScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
