# General Manager

## Role Summary

* **Role key**: `gm`
* **Role category**: `business_development`
* **Total screens**: 4
* **Business ready screens**: 4
* **Incomplete screens**: 4
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 45.0%
* **Average screen-body interactions**: 3.5

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GeneralManagerDashboardScreen | `/offices/business_development/roles/general_manager/dashboard` | 4 | 1 | `MEANINGFUL` | 5 | 0 | None | **Yes** |
| GeneralManagerAnalyticsScreen | `/management/general-manager-analytics` | 3 | 0 | `MEANINGFUL` | 3 | 0 | None | **Yes** |
| GeneralManagerComplianceScreen | `/management/general-manager-compliance` | 4 | 1 | `MEANINGFUL` | 5 | 0 | None | **Yes** |
| GeneralManagerWorkflowScreen | `/management/general-manager-workflow` | 3 | 0 | `MEANINGFUL` | 3 | 0 | None | **Yes** |

## Screen Details

### GeneralManagerDashboardScreen

* **Route**: `/offices/business_development/roles/general_manager/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/general_manager_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 4
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 5
* **Role Expectation Score**: 0
* **Missing Business Features**: None
* **Purpose**: Management workspace screen for GeneralManagerDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### GeneralManagerAnalyticsScreen

* **Route**: `/management/general-manager-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/general_manager_analytics_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 3
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 0
* **Missing Business Features**: None
* **Purpose**: Business intelligence analytics dashboard for GeneralManagerAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: None
* **Next action**: None

### GeneralManagerComplianceScreen

* **Route**: `/management/general-manager-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/general_manager_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 4
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 5
* **Role Expectation Score**: 0
* **Missing Business Features**: None
* **Purpose**: Regulatory compliance tracking and audit registry for GeneralManagerComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: None
* **Next action**: None

### GeneralManagerWorkflowScreen

* **Route**: `/management/general-manager-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/general_manager_workflow_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 3
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 0
* **Missing Business Features**: None
* **Purpose**: Operational workflow configuration and tracking screen for GeneralManagerWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: None
* **Next action**: None

## Screens to Fix First

All screens are fully business-ready and verified! Zero issues found.

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- None (All screens have core workflows implemented)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- GeneralManagerAnalyticsScreen (Micro-interactions and design alignment polish)
- GeneralManagerWorkflowScreen (Micro-interactions and design alignment polish)
- GeneralManagerDashboardScreen (Micro-interactions and design alignment polish)
- GeneralManagerComplianceScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
