# Operations Manager

## Role Summary

* **Role key**: `ops_manager`
* **Role category**: `franchise`
* **Total screens**: 14
* **Business ready screens**: 0
* **Incomplete screens**: 14
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 20.7%
* **Average screen-body interactions**: 5.4

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| OfficeDashboardScreen | `/common/office-dashboard` | 2 | 1 | `LOW_INTERACTION` | 6 | 2 | staff, cost, efficiency | **No** |
| OperationsManagerDashboardScreen | `/offices/franchise/roles/operations_manager/dashboard` | 1 | 2 | `LOW_INTERACTION` | 3 | 2 | office, cost, efficiency | **No** |
| OperationsManagerAnalyticsScreen | `/management/operations-manager-analytics` | 2 | 0 | `LOW_INTERACTION` | 2 | 1 | office, staff, cost, efficiency | **No** |
| OperationsManagerComplianceScreen | `/management/operations-manager-compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | office, staff, cost, efficiency | **No** |
| OperationsManagerWorkflowScreen | `/management/operations-manager-workflow` | 2 | 0 | `LOW_INTERACTION` | 3 | 1 | office, staff, cost, efficiency | **No** |
| Operations Manager Attendance | `/offices/franchise/roles/operations_manager/attendance` | 8 | 6 | `MEANINGFUL` | 7 | 2 | office, cost, efficiency | **No** |
| Operations Manager Daily Operations | `/offices/franchise/roles/operations_manager/daily-operations` | 8 | 6 | `MEANINGFUL` | 8 | 1 | office, staff, cost, efficiency | **No** |
| Operations Manager Issues | `/offices/franchise/roles/operations_manager/issues` | 8 | 6 | `MEANINGFUL` | 9 | 2 | office, cost, efficiency | **No** |
| Operations Manager Reports | `/offices/franchise/roles/operations_manager/reports` | 8 | 6 | `MEANINGFUL` | 8 | 1 | office, staff, cost, efficiency | **No** |
| Operations Manager Schedule | `/offices/franchise/roles/operations_manager/schedule` | 8 | 6 | `MEANINGFUL` | 7 | 1 | office, staff, cost, efficiency | **No** |
| Operations Manager Service Quality | `/offices/franchise/roles/operations_manager/service-quality` | 8 | 6 | `MEANINGFUL` | 8 | 2 | office, cost, efficiency | **No** |
| Operations Manager Shifts | `/offices/franchise/roles/operations_manager/shifts` | 8 | 6 | `MEANINGFUL` | 7 | 1 | office, staff, cost, efficiency | **No** |
| Operations Manager Staff Coordination | `/offices/franchise/roles/operations_manager/staff-coordination` | 8 | 6 | `MEANINGFUL` | 7 | 2 | office, cost, efficiency | **No** |
| Site Readiness | `/generated/site-readiness` | 3 | 0 | `MEANINGFUL` | 5 | 1 | office, staff, cost, efficiency | **No** |

## Screen Details

### OfficeDashboardScreen

* **Route**: `/common/office-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/office_dashboard_screen.dart`
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
* **Business Workflow Score**: 6
* **Role Expectation Score**: 2
* **Missing Business Features**: staff, cost, efficiency
* **Purpose**: Management workspace screen for OfficeDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### OperationsManagerDashboardScreen

* **Route**: `/offices/franchise/roles/operations_manager/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/operations_manager_dashboard.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `LOW_INTERACTION`
* **Screen Body Interactions**: 1
  * **Buttons**: 0
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 2
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: office, cost, efficiency
* **Purpose**: Management workspace screen for OperationsManagerDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### OperationsManagerAnalyticsScreen

* **Route**: `/management/operations-manager-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/operations_manager_analytics_screen.dart`
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
* **Missing Business Features**: office, staff, cost, efficiency
* **Purpose**: Business intelligence analytics dashboard for OperationsManagerAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### OperationsManagerComplianceScreen

* **Route**: `/management/operations-manager-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/operations_manager_compliance_screen.dart`
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
* **Missing Business Features**: office, staff, cost, efficiency
* **Purpose**: Regulatory compliance tracking and audit registry for OperationsManagerComplianceScreen protocols.
* **Primary user goal**: Review policy documents, verify training completion status, and log compliance incidents.
* **Expected user actions**: Check off policy read agreements, upload compliance proofs, search audit registers.
* **Business reason**: Mandatory safety oversight, legal compliance, and liability protection.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### OperationsManagerWorkflowScreen

* **Route**: `/management/operations-manager-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/operations_manager_workflow_screen.dart`
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
* **Missing Business Features**: office, staff, cost, efficiency
* **Purpose**: Operational workflow configuration and tracking screen for OperationsManagerWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Operations Manager Attendance

* **Route**: `/offices/franchise/roles/operations_manager/attendance`
* **Component file**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_attendance_screen.dart`
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
* **Missing Business Features**: office, cost, efficiency
* **Purpose**: Management workspace screen for Operations Manager Attendance module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: office, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

### Operations Manager Daily Operations

* **Route**: `/offices/franchise/roles/operations_manager/daily-operations`
* **Component file**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_daily_operations_screen.dart`
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
* **Missing Business Features**: office, staff, cost, efficiency
* **Purpose**: Management workspace screen for Operations Manager Daily Operations module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: office, staff, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

### Operations Manager Issues

* **Route**: `/offices/franchise/roles/operations_manager/issues`
* **Component file**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_issues_screen.dart`
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
* **Missing Business Features**: office, cost, efficiency
* **Purpose**: Management workspace screen for Operations Manager Issues module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: office, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

### Operations Manager Reports

* **Route**: `/offices/franchise/roles/operations_manager/reports`
* **Component file**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_reports_screen.dart`
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
* **Missing Business Features**: office, staff, cost, efficiency
* **Purpose**: Management workspace screen for Operations Manager Reports module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: office, staff, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

### Operations Manager Schedule

* **Route**: `/offices/franchise/roles/operations_manager/schedule`
* **Component file**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_schedule_screen.dart`
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
* **Missing Business Features**: office, staff, cost, efficiency
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: office, staff, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

### Operations Manager Service Quality

* **Route**: `/offices/franchise/roles/operations_manager/service-quality`
* **Component file**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_service_quality_screen.dart`
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
* **Missing Business Features**: office, cost, efficiency
* **Purpose**: Management workspace screen for Operations Manager Service Quality module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: office, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

### Operations Manager Shifts

* **Route**: `/offices/franchise/roles/operations_manager/shifts`
* **Component file**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_shifts_screen.dart`
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
* **Missing Business Features**: office, staff, cost, efficiency
* **Purpose**: Management workspace screen for Operations Manager Shifts module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: office, staff, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

### Operations Manager Staff Coordination

* **Route**: `/offices/franchise/roles/operations_manager/staff-coordination`
* **Component file**: `apps/primecare_franchise/lib/features/ops/screens/operations_manager_staff_coordination_screen.dart`
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
* **Missing Business Features**: office, cost, efficiency
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: office, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

### Site Readiness

* **Route**: `/generated/site-readiness`
* **Component file**: `packages/primecare_ui/lib/src/features/operations/site_readiness_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 0
  * **Forms**: 3
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 5
* **Role Expectation Score**: 1
* **Missing Business Features**: office, staff, cost, efficiency
* **Purpose**: Management workspace screen for Site Readiness module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: office, staff, cost, efficiency
* **Next action**: Implement expected workflows for ops_manager role.

## Screens to Fix First

1. **Operations Manager Attendance** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: office, cost, efficiency
2. **Operations Manager Daily Operations** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: office, staff, cost, efficiency
3. **Operations Manager Issues** (Progress: 0%, Business Score: 9, Role Score: 2)  
   *Reason*: Missing core workflows/features: office, cost, efficiency
4. **Operations Manager Reports** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: office, staff, cost, efficiency
5. **Operations Manager Schedule** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: office, staff, cost, efficiency
6. **Operations Manager Service Quality** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: office, cost, efficiency
7. **Operations Manager Shifts** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: office, staff, cost, efficiency
8. **Operations Manager Staff Coordination** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: office, cost, efficiency
9. **OperationsManagerAnalyticsScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: office, staff, cost, efficiency
10. **OperationsManagerWorkflowScreen** (Progress: 40%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: office, staff, cost, efficiency

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Operations Manager Attendance (Implement role-specific workflows and transactional features)
- Operations Manager Daily Operations (Implement role-specific workflows and transactional features)
- Operations Manager Issues (Implement role-specific workflows and transactional features)
- Operations Manager Reports (Implement role-specific workflows and transactional features)
- Operations Manager Schedule (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
