# Registered Practical Nurse (RPN)

## Role Summary

* **Role key**: `rpn`
* **Role category**: `clinical`
* **Total screens**: 18
* **Business ready screens**: 0
* **Incomplete screens**: 18
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 60.0%
* **Average screen-body interactions**: 2.4

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| RpnDashboardScreen | `/offices/clinical/roles/rpn/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | nursing, medication, wound-care, charting, treatment | **No** |
| RpnAnalyticsScreen | `/offices/clinical/roles/rpn/rpn-analytics` | 7 | 2 | `MEANINGFUL` | 5 | 0 | nursing, medication, wound-care, charting, treatment | **No** |
| RpnComplianceScreen | `/offices/clinical/roles/rpn/rpn-compliance` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | nursing, wound-care, charting, treatment | **No** |
| RpnWorkflowScreen | `/offices/clinical/roles/rpn/rpn-workflow` | 5 | 0 | `MEANINGFUL` | 4 | 2 | nursing, wound-care, charting | **No** |
| RpnCommandCenterScreen | `/offices/clinical/roles/rpn/rpn-command-center` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | nursing, wound-care, charting, treatment | **No** |
| RpnPatientChartingScreen | `/offices/clinical/roles/rpn/patient-charting` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | nursing, wound-care, treatment | **No** |
| RpnMedicationsScreen | `/offices/clinical/roles/rpn/medications` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | nursing, wound-care, charting, treatment | **No** |
| RpnVitalsScreen | `/offices/clinical/roles/rpn/vitals` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | nursing, wound-care, charting, treatment | **No** |
| RpnCarePlanReviewScreen | `/offices/clinical/roles/rpn/rpn-care-plan-review` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | wound-care, charting, treatment | **No** |
| RpnIncidentReviewScreen | `/offices/clinical/roles/rpn/rpn-incident-review` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | nursing, wound-care, charting, treatment | **No** |
| RpnTasksScreen | `/offices/clinical/roles/rpn/rpn-tasks` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | nursing, wound-care, charting, treatment | **No** |
| RpnReportsScreen | `/offices/clinical/roles/rpn/rpn-reports` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | nursing, wound-care, charting, treatment | **No** |
| NursingTaskScreen | `/offices/clinical/roles/rpn/nursing-task` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | wound-care, charting, treatment | **No** |
| VitalsTrackingScreen | `/offices/clinical/roles/rpn/vitals-tracking` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | nursing, wound-care, charting, treatment | **No** |
| MedicationScreen | `/offices/clinical/roles/rpn/medication` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | wound-care, charting, treatment | **No** |
| PatientObservationScreen | `/offices/clinical/roles/rpn/patient-observation` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | nursing, wound-care, charting, treatment | **No** |
| Licensed Practical Nurse (LPN) Analytics | `/rpn/lpn-analytics` | 2 | 1 | `LOW_INTERACTION` | 2 | 0 | nursing, medication, wound-care, charting, treatment | **No** |
| Licensed Practical Nurse (LPN) Compliance Workflow | `/rpn/lpn-workflow` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | nursing, wound-care, charting, treatment | **No** |

## Screen Details

### RpnDashboardScreen

* **Route**: `/offices/clinical/roles/rpn/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_dashboard_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: nursing, medication, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnAnalyticsScreen

* **Route**: `/offices/clinical/roles/rpn/rpn-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_analytics_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 7
  * **Buttons**: 4
  * **Forms**: 2
  * **Filters**: 0
  * **Table Actions**: 1
  * **Clickable Cards**: 0
* **Global Navigation Count**: 2
* **Business Workflow Score**: 5
* **Role Expectation Score**: 0
* **Missing Business Features**: nursing, medication, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Missing core role features: nursing, medication, wound-care, charting, treatment
* **Next action**: Implement expected workflows for rpn role.

### RpnComplianceScreen

* **Route**: `/offices/clinical/roles/rpn/rpn-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_compliance_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnWorkflowScreen

* **Route**: `/offices/clinical/roles/rpn/rpn-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_workflow_screen.dart`
* **Current stage**: Stage 9
* **Progress %**: 90%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 5
  * **Buttons**: 3
  * **Forms**: 2
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 4
* **Role Expectation Score**: 2
* **Missing Business Features**: nursing, wound-care, charting
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Missing core role features: nursing, wound-care, charting
* **Next action**: Implement expected workflows for rpn role.

### RpnCommandCenterScreen

* **Route**: `/offices/clinical/roles/rpn/rpn-command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_command_center_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnPatientChartingScreen

* **Route**: `/offices/clinical/roles/rpn/patient-charting`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_patient_charting_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnMedicationsScreen

* **Route**: `/offices/clinical/roles/rpn/medications`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_medications_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnVitalsScreen

* **Route**: `/offices/clinical/roles/rpn/vitals`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_vitals_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnCarePlanReviewScreen

* **Route**: `/offices/clinical/roles/rpn/rpn-care-plan-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_care_plan_review_screen.dart`
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
* **Missing Business Features**: wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnIncidentReviewScreen

* **Route**: `/offices/clinical/roles/rpn/rpn-incident-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_incident_review_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnTasksScreen

* **Route**: `/offices/clinical/roles/rpn/rpn-tasks`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_tasks_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RpnReportsScreen

* **Route**: `/offices/clinical/roles/rpn/rpn-reports`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/rpn_reports_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### NursingTaskScreen

* **Route**: `/offices/clinical/roles/rpn/nursing-task`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/nursing_task_screen.dart`
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
* **Missing Business Features**: wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### VitalsTrackingScreen

* **Route**: `/offices/clinical/roles/rpn/vitals-tracking`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/vitals_tracking_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### MedicationScreen

* **Route**: `/offices/clinical/roles/rpn/medication`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/medication_screen.dart`
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
* **Missing Business Features**: wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientObservationScreen

* **Route**: `/offices/clinical/roles/rpn/patient-observation`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/patient_observation_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Licensed Practical Nurse (LPN) Analytics

* **Route**: `/rpn/lpn-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/lpn_analytics_screen.dart`
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
* **Missing Business Features**: nursing, medication, wound-care, charting, treatment
* **Purpose**: Business intelligence analytics dashboard for Licensed Practical Nurse (LPN) Analytics to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Licensed Practical Nurse (LPN) Compliance Workflow

* **Route**: `/rpn/lpn-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/rpn/lpn_workflow_screen.dart`
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
* **Missing Business Features**: nursing, wound-care, charting, treatment
* **Purpose**: Operational workflow configuration and tracking screen for Licensed Practical Nurse (LPN) Compliance Workflow workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **RpnDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: nursing, medication, wound-care, charting, treatment
2. **RpnAnalyticsScreen** (Progress: 50%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: nursing, medication, wound-care, charting, treatment
3. **RpnComplianceScreen** (Progress: 50%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: nursing, wound-care, charting, treatment
4. **RpnCommandCenterScreen** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: nursing, wound-care, charting, treatment
5. **RpnPatientChartingScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: nursing, wound-care, treatment
6. **RpnMedicationsScreen** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: nursing, wound-care, charting, treatment
7. **RpnVitalsScreen** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: nursing, wound-care, charting, treatment
8. **RpnCarePlanReviewScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: wound-care, charting, treatment
9. **RpnIncidentReviewScreen** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: nursing, wound-care, charting, treatment
10. **RpnTasksScreen** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: nursing, wound-care, charting, treatment

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- RpnDashboardScreen (Implement role-specific workflows and transactional features)
- RpnAnalyticsScreen (Implement role-specific workflows and transactional features)
- RpnComplianceScreen (Implement role-specific workflows and transactional features)
- RpnCommandCenterScreen (Implement role-specific workflows and transactional features)
- RpnPatientChartingScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
