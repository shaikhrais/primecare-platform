# Legal Counsel

## Role Summary

* **Role key**: `legal`
* **Role category**: `corporate`
* **Total screens**: 3
* **Business ready screens**: 1
* **Incomplete screens**: 3
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 56.7%
* **Average screen-body interactions**: 2.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| LegalDashboardScreen | `/offices/corporate/roles/legal/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | contract, agreement, dispute, document | **No** |
| LegalAnalyticsScreen | `/executive/legal-analytics` | 2 | 1 | `LOW_INTERACTION` | 3 | 3 | agreement, dispute | **Yes** |
| LegalWorkflowScreen | `/executive/legal-workflow` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | contract, agreement, dispute | **No** |

## Screen Details

### LegalDashboardScreen

* **Route**: `/offices/corporate/roles/legal/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/legal_dashboard_screen.dart`
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
* **Missing Business Features**: contract, agreement, dispute, document
* **Purpose**: Management workspace screen for LegalDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### LegalAnalyticsScreen

* **Route**: `/executive/legal-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/legal_analytics_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: agreement, dispute
* **Purpose**: Business intelligence analytics dashboard for LegalAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### LegalWorkflowScreen

* **Route**: `/executive/legal-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/legal_workflow_screen.dart`
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
* **Missing Business Features**: contract, agreement, dispute
* **Purpose**: Operational workflow configuration and tracking screen for LegalWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **LegalDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: contract, agreement, dispute, document
2. **LegalWorkflowScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: contract, agreement, dispute

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- LegalDashboardScreen (Implement role-specific workflows and transactional features)
- LegalWorkflowScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- LegalAnalyticsScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
