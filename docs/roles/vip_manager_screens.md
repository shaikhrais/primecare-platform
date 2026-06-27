# VIP Client Manager

## Role Summary

* **Role key**: `vip_manager`
* **Role category**: `executive`
* **Total screens**: 3
* **Business ready screens**: 1
* **Incomplete screens**: 3
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 60.0%
* **Average screen-body interactions**: 2.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| VipManagerDashboardScreen | `/management/vip-manager-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | account, feedback, exclusive, communication | **No** |
| VIP Client Manager Analytics | `/executive/vip-manager-analytics` | 2 | 1 | `LOW_INTERACTION` | 2 | 3 | account, exclusive | **Yes** |
| VIP Client Manager Compliance Workflow | `/executive/vip-manager-workflow` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | account, feedback, exclusive, communication | **No** |

## Screen Details

### VipManagerDashboardScreen

* **Route**: `/management/vip-manager-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/vip_manager_dashboard_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: account, feedback, exclusive, communication
* **Purpose**: Management workspace screen for VipManagerDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### VIP Client Manager Analytics

* **Route**: `/executive/vip-manager-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/vip_manager_analytics_screen.dart`
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
* **Business Workflow Score**: 2
* **Role Expectation Score**: 3
* **Missing Business Features**: account, exclusive
* **Purpose**: Business intelligence analytics dashboard for VIP Client Manager Analytics to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### VIP Client Manager Compliance Workflow

* **Route**: `/executive/vip-manager-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/vip_manager_workflow_screen.dart`
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
* **Missing Business Features**: account, feedback, exclusive, communication
* **Purpose**: Operational workflow configuration and tracking screen for VIP Client Manager Compliance Workflow workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **VipManagerDashboardScreen** (Progress: 60%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: account, feedback, exclusive, communication
2. **VIP Client Manager Compliance Workflow** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: account, feedback, exclusive, communication

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- VipManagerDashboardScreen (Implement role-specific workflows and transactional features)
- VIP Client Manager Compliance Workflow (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- VIP Client Manager Analytics (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
