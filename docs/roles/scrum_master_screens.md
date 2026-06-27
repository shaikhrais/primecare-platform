# Scrum Master

## Role Summary

* **Role key**: `scrum_master`
* **Role category**: `management`
* **Total screens**: 4
* **Business ready screens**: 4
* **Incomplete screens**: 4
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 55.0%
* **Average screen-body interactions**: 2.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ScrumMasterDashboardScreen | `/management/scrum-master-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | sprint | **Yes** |
| ScrumMasterAnalyticsScreen | `/management/scrum-master-analytics` | 2 | 1 | `LOW_INTERACTION` | 3 | 4 | velocity | **Yes** |
| ScrumMasterComplianceScreen | `/management/scrum-master-compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | velocity | **Yes** |
| ScrumMasterWorkflowScreen | `/management/scrum-master-workflow` | 2 | 1 | `LOW_INTERACTION` | 3 | 4 | velocity | **Yes** |

## Screen Details

### ScrumMasterDashboardScreen

* **Route**: `/management/scrum-master-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/scrum_master_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
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
* **Missing Business Features**: sprint
* **Purpose**: Management workspace screen for ScrumMasterDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ScrumMasterAnalyticsScreen

* **Route**: `/management/scrum-master-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scrum_master_analytics_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 4
* **Missing Business Features**: velocity
* **Purpose**: Business intelligence analytics dashboard for ScrumMasterAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ScrumMasterComplianceScreen

* **Route**: `/management/scrum-master-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/scrum_master_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
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
* **Missing Business Features**: velocity
* **Purpose**: Regulatory compliance tracking and audit registry for ScrumMasterComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ScrumMasterWorkflowScreen

* **Route**: `/management/scrum-master-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scrum_master_workflow_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 4
* **Missing Business Features**: velocity
* **Purpose**: Operational workflow configuration and tracking screen for ScrumMasterWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

All screens are fully business-ready and verified! Zero issues found.

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- None (All screens have core workflows implemented)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- ScrumMasterDashboardScreen (Micro-interactions and design alignment polish)
- ScrumMasterComplianceScreen (Micro-interactions and design alignment polish)
- ScrumMasterAnalyticsScreen (Micro-interactions and design alignment polish)
- ScrumMasterWorkflowScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
