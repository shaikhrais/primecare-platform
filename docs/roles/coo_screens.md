# Chief Operating Officer (COO)

## Role Summary

* **Role key**: `coo`
* **Role category**: `corporate`
* **Total screens**: 16
* **Business ready screens**: 2
* **Incomplete screens**: 16
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 30.6%
* **Average screen-body interactions**: 4.5

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CooDashboardScreen | `/offices/corporate/roles/coo/dashboard` | 6 | 4 | `MEANINGFUL` | 6 | 2 | comparison, staff, logistics, performance | **No** |
| CooAnalyticsScreen | `/executive/coo-analytics` | 2 | 0 | `LOW_INTERACTION` | 2 | 2 | branch, comparison, staff, logistics | **No** |
| CooComplianceScreen | `/offices/corporate/roles/coo/compliance-view` | 2 | 1 | `LOW_INTERACTION` | 4 | 0 | operations, branch, comparison, staff, logistics, performance | **No** |
| CooWorkflowScreen | `/executive/coo-workflow` | 2 | 0 | `LOW_INTERACTION` | 2 | 2 | branch, comparison, staff, logistics | **No** |
| CooCommandCenterScreen | `/executive/coo-command-center` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | branch, comparison, staff, logistics | **No** |
| CooOperationsOverviewScreen | `/offices/corporate/roles/coo/operations-overview` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | branch, comparison, staff, logistics | **No** |
| CooStaffingScreen | `/executive/coo-staffing` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | branch, comparison, logistics | **Yes** |
| CooSchedulingHealthScreen | `/offices/corporate/roles/coo/scheduling-health` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | branch, comparison, staff, logistics | **No** |
| CooWorkflowIssuesScreen | `/executive/coo-workflow-issues` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | branch, comparison, staff, logistics | **No** |
| CooBranchComparisonScreen | `/offices/corporate/roles/coo/branch-comparison` | 2 | 1 | `LOW_INTERACTION` | 3 | 4 | staff, logistics | **Yes** |
| Coo Branch Operations | `/offices/corporate/roles/coo/branch-operations` | 8 | 6 | `MEANINGFUL` | 7 | 2 | comparison, staff, logistics, performance | **No** |
| Coo Issue Escalations | `/offices/corporate/roles/coo/issue-escalations` | 8 | 6 | `MEANINGFUL` | 7 | 2 | branch, comparison, logistics, performance | **No** |
| Coo Reports | `/offices/corporate/roles/coo/reports` | 8 | 6 | `MEANINGFUL` | 8 | 1 | branch, comparison, staff, logistics, performance | **No** |
| Coo Service Delivery | `/offices/corporate/roles/coo/service-delivery` | 8 | 6 | `MEANINGFUL` | 7 | 1 | branch, comparison, staff, logistics, performance | **No** |
| Coo Staffing Efficiency | `/offices/corporate/roles/coo/staffing-efficiency` | 8 | 6 | `MEANINGFUL` | 7 | 2 | branch, comparison, logistics, performance | **No** |
| Coo Workflow Performance | `/offices/corporate/roles/coo/workflow-performance` | 8 | 6 | `MEANINGFUL` | 8 | 2 | branch, comparison, staff, logistics | **No** |

## Screen Details

### CooDashboardScreen

* **Route**: `/offices/corporate/roles/coo/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/coo_dashboard.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 6
  * **Buttons**: 5
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 4
* **Business Workflow Score**: 6
* **Role Expectation Score**: 2
* **Missing Business Features**: comparison, staff, logistics, performance
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: comparison, staff, logistics, performance
* **Next action**: Implement expected workflows for coo role.

### CooAnalyticsScreen

* **Route**: `/executive/coo-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_analytics_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: branch, comparison, staff, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CooComplianceScreen

* **Route**: `/offices/corporate/roles/coo/compliance-view`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_compliance_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: operations, branch, comparison, staff, logistics, performance
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CooWorkflowScreen

* **Route**: `/executive/coo-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_workflow_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: branch, comparison, staff, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CooCommandCenterScreen

* **Route**: `/executive/coo-command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_command_center_screen.dart`
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
* **Missing Business Features**: branch, comparison, staff, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CooOperationsOverviewScreen

* **Route**: `/offices/corporate/roles/coo/operations-overview`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_operations_overview_screen.dart`
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
* **Missing Business Features**: branch, comparison, staff, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CooStaffingScreen

* **Route**: `/executive/coo-staffing`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_staffing_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 3
* **Missing Business Features**: branch, comparison, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CooSchedulingHealthScreen

* **Route**: `/offices/corporate/roles/coo/scheduling-health`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_scheduling_health_screen.dart`
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
* **Missing Business Features**: branch, comparison, staff, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CooWorkflowIssuesScreen

* **Route**: `/executive/coo-workflow-issues`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_workflow_issues_screen.dart`
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
* **Missing Business Features**: branch, comparison, staff, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CooBranchComparisonScreen

* **Route**: `/offices/corporate/roles/coo/branch-comparison`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/coo_branch_comparison_screen.dart`
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
* **Missing Business Features**: staff, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Coo Branch Operations

* **Route**: `/offices/corporate/roles/coo/branch-operations`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/coo_branch_operations_screen.dart`
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
* **Missing Business Features**: comparison, staff, logistics, performance
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: comparison, staff, logistics, performance
* **Next action**: Implement expected workflows for coo role.

### Coo Issue Escalations

* **Route**: `/offices/corporate/roles/coo/issue-escalations`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/coo_issue_escalations_screen.dart`
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
* **Missing Business Features**: branch, comparison, logistics, performance
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: branch, comparison, logistics, performance
* **Next action**: Implement expected workflows for coo role.

### Coo Reports

* **Route**: `/offices/corporate/roles/coo/reports`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/coo_reports_screen.dart`
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
* **Missing Business Features**: branch, comparison, staff, logistics, performance
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: branch, comparison, staff, logistics, performance
* **Next action**: Implement expected workflows for coo role.

### Coo Service Delivery

* **Route**: `/offices/corporate/roles/coo/service-delivery`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/coo_service_delivery_screen.dart`
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
* **Missing Business Features**: branch, comparison, staff, logistics, performance
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: branch, comparison, staff, logistics, performance
* **Next action**: Implement expected workflows for coo role.

### Coo Staffing Efficiency

* **Route**: `/offices/corporate/roles/coo/staffing-efficiency`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/coo_staffing_efficiency_screen.dart`
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
* **Missing Business Features**: branch, comparison, logistics, performance
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: branch, comparison, logistics, performance
* **Next action**: Implement expected workflows for coo role.

### Coo Workflow Performance

* **Route**: `/offices/corporate/roles/coo/workflow-performance`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/coo_workflow_performance_screen.dart`
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
* **Missing Business Features**: branch, comparison, staff, logistics
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: branch, comparison, staff, logistics
* **Next action**: Implement expected workflows for coo role.

## Screens to Fix First

1. **CooDashboardScreen** (Progress: 0%, Business Score: 6, Role Score: 2)  
   *Reason*: Missing core workflows/features: comparison, staff, logistics, performance
2. **Coo Branch Operations** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: comparison, staff, logistics, performance
3. **Coo Issue Escalations** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: branch, comparison, logistics, performance
4. **Coo Reports** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: branch, comparison, staff, logistics, performance
5. **Coo Service Delivery** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: branch, comparison, staff, logistics, performance
6. **Coo Staffing Efficiency** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: branch, comparison, logistics, performance
7. **Coo Workflow Performance** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: branch, comparison, staff, logistics
8. **CooAnalyticsScreen** (Progress: 40%, Business Score: 2, Role Score: 2)  
   *Reason*: Missing core workflows/features: branch, comparison, staff, logistics
9. **CooWorkflowScreen** (Progress: 40%, Business Score: 2, Role Score: 2)  
   *Reason*: Missing core workflows/features: branch, comparison, staff, logistics
10. **CooComplianceScreen** (Progress: 50%, Business Score: 4, Role Score: 0)  
   *Reason*: Missing core workflows/features: operations, branch, comparison, staff, logistics, performance

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- CooDashboardScreen (Implement role-specific workflows and transactional features)
- Coo Branch Operations (Implement role-specific workflows and transactional features)
- Coo Issue Escalations (Implement role-specific workflows and transactional features)
- Coo Reports (Implement role-specific workflows and transactional features)
- Coo Service Delivery (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- CooStaffingScreen (Micro-interactions and design alignment polish)
- CooBranchComparisonScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
