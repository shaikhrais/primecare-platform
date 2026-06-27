# Home Support Worker

## Role Summary

* **Role key**: `hsw`
* **Role category**: `clinical`
* **Total screens**: 5
* **Business ready screens**: 0
* **Incomplete screens**: 5
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 44.0%
* **Average screen-body interactions**: 2.4

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| HswDashboardScreen | `/clinical/hsw-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | visit-log, tasks, home-support, meal, safety | **No** |
| HswAdlLoggerScreen | `/clinical/hsw-adl-logger` | 3 | 0 | `MEANINGFUL` | 3 | 1 | visit-log, tasks, home-support, safety | **No** |
| HswCarePlansScreen | `/clinical/hsw-care-plans` | 2 | 0 | `LOW_INTERACTION` | 1 | 0 | visit-log, tasks, home-support, meal, safety | **No** |
| HswIncidentReportsScreen | `/clinical/hsw-incident-reports` | 2 | 0 | `LOW_INTERACTION` | 3 | 0 | visit-log, tasks, home-support, meal, safety | **No** |
| HswScheduleScreen | `/clinical/hsw-schedule` | 3 | 0 | `MEANINGFUL` | 1 | 0 | visit-log, tasks, home-support, meal, safety | **No** |

## Screen Details

### HswDashboardScreen

* **Route**: `/clinical/hsw-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/hsw_dashboard_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: visit-log, tasks, home-support, meal, safety
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### HswAdlLoggerScreen

* **Route**: `/clinical/hsw-adl-logger`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/hsw_adl_logger_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 3
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: visit-log, tasks, home-support, safety
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Missing core role features: visit-log, tasks, home-support, safety
* **Next action**: Implement expected workflows for hsw role.

### HswCarePlansScreen

* **Route**: `/clinical/hsw-care-plans`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/hsw_care_plans_screen.dart`
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
* **Business Workflow Score**: 1
* **Role Expectation Score**: 0
* **Missing Business Features**: visit-log, tasks, home-support, meal, safety
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### HswIncidentReportsScreen

* **Route**: `/clinical/hsw-incident-reports`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/hsw_incident_reports_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: visit-log, tasks, home-support, meal, safety
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### HswScheduleScreen

* **Route**: `/clinical/hsw-schedule`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/hsw_schedule_screen.dart`
* **Current stage**: Stage 4
* **Progress %**: 40%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 3
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 1
* **Role Expectation Score**: 0
* **Missing Business Features**: visit-log, tasks, home-support, meal, safety
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Missing core role features: visit-log, tasks, home-support, meal, safety
* **Next action**: Implement expected workflows for hsw role.

## Screens to Fix First

1. **HswAdlLoggerScreen** (Progress: 40%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: visit-log, tasks, home-support, safety
2. **HswCarePlansScreen** (Progress: 40%, Business Score: 1, Role Score: 0)  
   *Reason*: Missing core workflows/features: visit-log, tasks, home-support, meal, safety
3. **HswIncidentReportsScreen** (Progress: 40%, Business Score: 3, Role Score: 0)  
   *Reason*: Missing core workflows/features: visit-log, tasks, home-support, meal, safety
4. **HswScheduleScreen** (Progress: 40%, Business Score: 1, Role Score: 0)  
   *Reason*: Missing core workflows/features: visit-log, tasks, home-support, meal, safety
5. **HswDashboardScreen** (Progress: 60%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: visit-log, tasks, home-support, meal, safety

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- HswAdlLoggerScreen (Implement role-specific workflows and transactional features)
- HswCarePlansScreen (Implement role-specific workflows and transactional features)
- HswIncidentReportsScreen (Implement role-specific workflows and transactional features)
- HswScheduleScreen (Implement role-specific workflows and transactional features)
- HswDashboardScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
