# Regional Manager USA

## Role Summary

* **Role key**: `regional_manager_usa`
* **Role category**: `business_development`
* **Total screens**: 7
* **Business ready screens**: 4
* **Incomplete screens**: 7
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 25.7%
* **Average screen-body interactions**: 4.6

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| RegionalManagerUsaDashboardScreen | `/offices/business_development/roles/regional_manager_usa/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 3 | branch, revenue | **Yes** |
| RegionalManagerUsaAnalyticsScreen | `/management/regional-manager-usa-analytics` | 2 | 0 | `LOW_INTERACTION` | 2 | 3 | branch, revenue | **Yes** |
| RegionalManagerUsaComplianceScreen | `/management/regional-manager-usa-compliance` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | branch, revenue, operations | **No** |
| RegionalManagerUsaWorkflowScreen | `/management/regional-manager-usa-workflow` | 2 | 0 | `LOW_INTERACTION` | 2 | 3 | branch, revenue | **Yes** |
| Regional Manager Ontario Dashboard | `/offices/business_development/roles/regional_manager_ontario/dashboard` | 8 | 6 | `MEANINGFUL` | 7 | 2 | USA, revenue, compliance | **No** |
| Regional Manager Branch Comparison | `/offices/franchise/roles/regional_manager/branch_comparison` | 8 | 6 | `MEANINGFUL` | 7 | 3 | USA, compliance | **Yes** |
| Regional Manager Dashboard | `/offices/franchise/roles/regional_manager/dashboard` | 8 | 6 | `MEANINGFUL` | 8 | 1 | USA, branch, revenue, compliance | **No** |

## Screen Details

### RegionalManagerUsaDashboardScreen

* **Route**: `/offices/business_development/roles/regional_manager_usa/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/regional_manager_usa_dashboard_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: branch, revenue
* **Purpose**: Management workspace screen for RegionalManagerUsaDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RegionalManagerUsaAnalyticsScreen

* **Route**: `/management/regional-manager-usa-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/regional_manager_usa_analytics_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 2
* **Role Expectation Score**: 3
* **Missing Business Features**: branch, revenue
* **Purpose**: Business intelligence analytics dashboard for RegionalManagerUsaAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RegionalManagerUsaComplianceScreen

* **Route**: `/management/regional-manager-usa-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/regional_manager_usa_compliance_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 2
* **Missing Business Features**: branch, revenue, operations
* **Purpose**: Regulatory compliance tracking and audit registry for RegionalManagerUsaComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RegionalManagerUsaWorkflowScreen

* **Route**: `/management/regional-manager-usa-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/regional_manager_usa_workflow_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 2
  * **Buttons**: 2
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 2
* **Role Expectation Score**: 3
* **Missing Business Features**: branch, revenue
* **Purpose**: Operational workflow configuration and tracking screen for RegionalManagerUsaWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Regional Manager Ontario Dashboard

* **Route**: `/offices/business_development/roles/regional_manager_ontario/dashboard`
* **Component file**: `apps/primecare_business_development/lib/features/regional/screens/regional_manager_ontario_dashboard_screen.dart`
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
* **Missing Business Features**: USA, revenue, compliance
* **Purpose**: Management workspace screen for Regional Manager Ontario Dashboard module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: USA, revenue, compliance
* **Next action**: Implement expected workflows for regional_manager_usa role.

### Regional Manager Branch Comparison

* **Route**: `/offices/franchise/roles/regional_manager/branch_comparison`
* **Component file**: `apps/primecare_franchise/lib/features/regional_manager/screens/regional_manager_branch_comparison_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
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
* **Missing Business Features**: USA, compliance
* **Purpose**: Management workspace screen for Regional Manager Branch Comparison module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: None
* **Next action**: None

### Regional Manager Dashboard

* **Route**: `/offices/franchise/roles/regional_manager/dashboard`
* **Component file**: `apps/primecare_franchise/lib/features/regional_manager/screens/regional_manager_dashboard_screen.dart`
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
* **Missing Business Features**: USA, branch, revenue, compliance
* **Purpose**: Management workspace screen for Regional Manager Dashboard module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: USA, branch, revenue, compliance
* **Next action**: Implement expected workflows for regional_manager_usa role.

## Screens to Fix First

1. **Regional Manager Ontario Dashboard** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: USA, revenue, compliance
2. **Regional Manager Dashboard** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: USA, branch, revenue, compliance
3. **RegionalManagerUsaComplianceScreen** (Progress: 50%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: branch, revenue, operations

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Regional Manager Ontario Dashboard (Implement role-specific workflows and transactional features)
- Regional Manager Dashboard (Implement role-specific workflows and transactional features)
- RegionalManagerUsaComplianceScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Regional Manager Branch Comparison (Micro-interactions and design alignment polish)
- RegionalManagerUsaAnalyticsScreen (Micro-interactions and design alignment polish)
- RegionalManagerUsaWorkflowScreen (Micro-interactions and design alignment polish)
- RegionalManagerUsaDashboardScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
