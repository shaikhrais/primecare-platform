# Dynamic Screen Viewer

## Role Summary

* **Role key**: `dynamic`
* **Role category**: `common`
* **Total screens**: 5
* **Business ready screens**: 1
* **Incomplete screens**: 5
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 58.0%
* **Average screen-body interactions**: 5.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DynamicScreenDashboardScreen | `/common/dynamic-dashboard` | 6 | 0 | `MEANINGFUL` | 4 | 1 | report, custom-view, dynamic-form | **No** |
| DynamicScreenAnalyticsScreen | `/common/dynamic-analytics` | 2 | 0 | `LOW_INTERACTION` | 5 | 1 | report, custom-view, dynamic-form | **No** |
| DynamicScreenWorkflowScreen | `/common/dynamic-workflow` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | report, custom-view, dynamic-form | **No** |
| Dynamic | `/generated/dynamic` | 9 | 0 | `MEANINGFUL` | 8 | 2 | custom-view, dynamic-form | **Yes** |
| Dynamic Dashboard | `/generated/dynamic-dashboard` | 6 | 0 | `MEANINGFUL` | 4 | 1 | report, custom-view, dynamic-form | **No** |

## Screen Details

### DynamicScreenDashboardScreen

* **Route**: `/common/dynamic-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 6
  * **Buttons**: 6
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 4
* **Role Expectation Score**: 1
* **Missing Business Features**: report, custom-view, dynamic-form
* **Purpose**: Management workspace screen for DynamicScreenDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: report, custom-view, dynamic-form
* **Next action**: Implement expected workflows for dynamic role.

### DynamicScreenAnalyticsScreen

* **Route**: `/common/dynamic-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/dynamic_screen_analytics_screen.dart`
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 1
* **Missing Business Features**: report, custom-view, dynamic-form
* **Purpose**: Business intelligence analytics dashboard for DynamicScreenAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### DynamicScreenWorkflowScreen

* **Route**: `/common/dynamic-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/dynamic_workflow_screen.dart`
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
* **Missing Business Features**: report, custom-view, dynamic-form
* **Purpose**: Operational workflow configuration and tracking screen for DynamicScreenWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Dynamic

* **Route**: `/generated/dynamic`
* **Component file**: `apps/primecare_governance/lib/core/ui/dynamic_screen_view.dart`
* **Current stage**: Stage 9
* **Progress %**: 90%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 9
  * **Buttons**: 2
  * **Forms**: 2
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 5
* **Global Navigation Count**: 0
* **Business Workflow Score**: 8
* **Role Expectation Score**: 2
* **Missing Business Features**: custom-view, dynamic-form
* **Purpose**: Management workspace screen for Dynamic module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### Dynamic Dashboard

* **Route**: `/generated/dynamic-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/dynamic_screen_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 6
  * **Buttons**: 6
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 4
* **Role Expectation Score**: 1
* **Missing Business Features**: report, custom-view, dynamic-form
* **Purpose**: Management workspace screen for Dynamic Dashboard module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: report, custom-view, dynamic-form
* **Next action**: Implement expected workflows for dynamic role.

## Screens to Fix First

1. **DynamicScreenAnalyticsScreen** (Progress: 40%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: report, custom-view, dynamic-form
2. **DynamicScreenDashboardScreen** (Progress: 50%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: report, custom-view, dynamic-form
3. **Dynamic Dashboard** (Progress: 50%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: report, custom-view, dynamic-form
4. **DynamicScreenWorkflowScreen** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: report, custom-view, dynamic-form

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- DynamicScreenAnalyticsScreen (Implement role-specific workflows and transactional features)
- DynamicScreenDashboardScreen (Implement role-specific workflows and transactional features)
- Dynamic Dashboard (Implement role-specific workflows and transactional features)
- DynamicScreenWorkflowScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Dynamic (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
