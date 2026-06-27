# Employee

## Role Summary

* **Role key**: `employee`
* **Role category**: `management`
* **Total screens**: 4
* **Business ready screens**: 0
* **Incomplete screens**: 4
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 60.0%
* **Average screen-body interactions**: 2.5

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| EmployeeDashboardScreen | `/staff/employee-dashboard` | 4 | 1 | `MEANINGFUL` | 7 | 0 | profile, shift, leave, payroll-stub, training | **No** |
| EmployeeRecordsScreen | `/management/employee-records` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | profile, shift, leave, payroll-stub | **No** |
| Employee Analytics | `/staff/employee-analytics` | 2 | 1 | `LOW_INTERACTION` | 2 | 0 | profile, shift, leave, payroll-stub, training | **No** |
| Employee Compliance Workflow | `/staff/employee-workflow` | 2 | 1 | `LOW_INTERACTION` | 2 | 0 | profile, shift, leave, payroll-stub, training | **No** |

## Screen Details

### EmployeeDashboardScreen

* **Route**: `/staff/employee-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/employee_dashboard_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
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
* **Business Workflow Score**: 7
* **Role Expectation Score**: 0
* **Missing Business Features**: profile, shift, leave, payroll-stub, training
* **Purpose**: Management workspace screen for EmployeeDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: profile, shift, leave, payroll-stub, training
* **Next action**: Implement expected workflows for employee role.

### EmployeeRecordsScreen

* **Route**: `/management/employee-records`
* **Component file**: `packages/primecare_ui/lib/src/screens/management/employee_records_screen.dart`
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
* **Missing Business Features**: profile, shift, leave, payroll-stub
* **Purpose**: Management workspace screen for EmployeeRecordsScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Employee Analytics

* **Route**: `/staff/employee-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/employee_analytics_screen.dart`
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
* **Missing Business Features**: profile, shift, leave, payroll-stub, training
* **Purpose**: Business intelligence analytics dashboard for Employee Analytics to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Employee Compliance Workflow

* **Route**: `/staff/employee-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/employee_workflow_screen.dart`
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
* **Missing Business Features**: profile, shift, leave, payroll-stub, training
* **Purpose**: Operational workflow configuration and tracking screen for Employee Compliance Workflow workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **EmployeeDashboardScreen** (Progress: 60%, Business Score: 7, Role Score: 0)  
   *Reason*: Missing core workflows/features: profile, shift, leave, payroll-stub, training
2. **EmployeeRecordsScreen** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: profile, shift, leave, payroll-stub
3. **Employee Analytics** (Progress: 60%, Business Score: 2, Role Score: 0)  
   *Reason*: Missing core workflows/features: profile, shift, leave, payroll-stub, training
4. **Employee Compliance Workflow** (Progress: 60%, Business Score: 2, Role Score: 0)  
   *Reason*: Missing core workflows/features: profile, shift, leave, payroll-stub, training

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- EmployeeDashboardScreen (Implement role-specific workflows and transactional features)
- EmployeeRecordsScreen (Implement role-specific workflows and transactional features)
- Employee Analytics (Implement role-specific workflows and transactional features)
- Employee Compliance Workflow (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
