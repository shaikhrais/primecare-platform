# Registered Nurse (RN)

## Role Summary

* **Role key**: `rn`
* **Role category**: `clinical`
* **Total screens**: 22
* **Business ready screens**: 3
* **Incomplete screens**: 22
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 55.9%
* **Average screen-body interactions**: 2.7

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| RnDashboardScreen | `/offices/clinical/roles/rn/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | charting, medication, vitals, care-plan, assessment, administration | **No** |
| RnAnalyticsScreen | `/offices/clinical/roles/rn/rn-analytics` | 8 | 2 | `MEANINGFUL` | 6 | 1 | charting, medication, vitals, care-plan, administration | **No** |
| RnAssessmentsScreen | `/offices/clinical/roles/rn/rn-assessments` | 3 | 0 | `MEANINGFUL` | 4 | 1 | charting, medication, vitals, care-plan, administration | **No** |
| RnCarePlansScreen | `/offices/clinical/roles/rn/rn-care-plans` | 3 | 0 | `MEANINGFUL` | 4 | 2 | charting, vitals, assessment, administration | **No** |
| RnComplianceScreen | `/offices/clinical/roles/rn/rn-compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | charting, vitals, care-plan, assessment | **No** |
| RnWorkflowScreen | `/offices/clinical/roles/rn/rn-workflow` | 4 | 0 | `MEANINGFUL` | 6 | 2 | charting, care-plan, assessment, administration | **No** |
| RnCommandCenterScreen | `/offices/clinical/roles/rn/rn-command-center` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | charting, vitals, care-plan, assessment, administration | **No** |
| RnPatientChartingScreen | `/offices/clinical/roles/rn/patient-charting` | 2 | 1 | `LOW_INTERACTION` | 5 | 3 | vitals, care-plan, assessment | **Yes** |
| RnMedicationsScreen | `/offices/clinical/roles/rn/medications` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | charting, vitals, care-plan, administration | **No** |
| RnVitalsScreen | `/offices/clinical/roles/rn/vitals` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | charting, care-plan, assessment, administration | **No** |
| RnCarePlanReviewScreen | `/offices/clinical/roles/rn/rn-care-plan-review` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | charting, vitals, assessment, administration | **No** |
| RnIncidentReviewScreen | `/offices/clinical/roles/rn/rn-incident-review` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | charting, vitals, care-plan, assessment | **No** |
| RnTasksScreen | `/offices/clinical/roles/rn/rn-tasks` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | charting, vitals, care-plan, assessment, administration | **No** |
| RnReportsScreen | `/offices/clinical/roles/rn/rn-reports` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | charting, vitals, care-plan, assessment, administration | **No** |
| MedicationAdministrationScreen | `/offices/clinical/roles/rn/medication-administration` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | charting, care-plan, assessment | **Yes** |
| CarePlanReviewScreen | `/offices/clinical/roles/rn/care-plan-review` | 2 | 1 | `LOW_INTERACTION` | 3 | 3 | charting, vitals, assessment | **Yes** |
| IncidentReviewScreen | `/offices/clinical/roles/rn/incident-review` | 2 | 1 | `LOW_INTERACTION` | 3 | 0 | charting, medication, vitals, care-plan, assessment, administration | **No** |
| ShiftReportScreen | `/offices/clinical/roles/rn/shift-report` | 2 | 1 | `LOW_INTERACTION` | 6 | 0 | charting, medication, vitals, care-plan, assessment, administration | **No** |
| Nurse Practitioner (NP) Analytics | `/rn/np-analytics` | 2 | 1 | `LOW_INTERACTION` | 4 | 0 | charting, medication, vitals, care-plan, assessment, administration | **No** |
| Nurse Practitioner (NP) Compliance Workflow | `/rn/np-workflow` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | charting, vitals, care-plan, administration | **No** |
| Rn Charting | `/generated/rn-charting` | 2 | 0 | `LOW_INTERACTION` | 3 | 1 | medication, vitals, care-plan, assessment, administration | **No** |
| Rn Messaging | `/generated/rn-messaging` | 8 | 6 | `MEANINGFUL` | 8 | 0 | charting, medication, vitals, care-plan, assessment, administration | **No** |

## Screen Details

### RnDashboardScreen

* **Route**: `/offices/clinical/roles/rn/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_dashboard_screen.dart`
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
* **Missing Business Features**: charting, medication, vitals, care-plan, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnAnalyticsScreen

* **Route**: `/offices/clinical/roles/rn/rn-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_analytics_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 2
  * **Filters**: 1
  * **Table Actions**: 1
  * **Clickable Cards**: 0
* **Global Navigation Count**: 2
* **Business Workflow Score**: 6
* **Role Expectation Score**: 1
* **Missing Business Features**: charting, medication, vitals, care-plan, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Missing core role features: charting, medication, vitals, care-plan, administration
* **Next action**: Implement expected workflows for rn role.

### RnAssessmentsScreen

* **Route**: `/offices/clinical/roles/rn/rn-assessments`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_assessments_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 2
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 4
* **Role Expectation Score**: 1
* **Missing Business Features**: charting, medication, vitals, care-plan, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Missing core role features: charting, medication, vitals, care-plan, administration
* **Next action**: Implement expected workflows for rn role.

### RnCarePlansScreen

* **Route**: `/offices/clinical/roles/rn/rn-care-plans`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_care_plans_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 2
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 4
* **Role Expectation Score**: 2
* **Missing Business Features**: charting, vitals, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Missing core role features: charting, vitals, assessment, administration
* **Next action**: Implement expected workflows for rn role.

### RnComplianceScreen

* **Route**: `/offices/clinical/roles/rn/rn-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_compliance_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: charting, vitals, care-plan, assessment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnWorkflowScreen

* **Route**: `/offices/clinical/roles/rn/rn-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_workflow_screen.dart`
* **Current stage**: Stage 9
* **Progress %**: 90%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 3
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 0
* **Business Workflow Score**: 6
* **Role Expectation Score**: 2
* **Missing Business Features**: charting, care-plan, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Missing core role features: charting, care-plan, assessment, administration
* **Next action**: Implement expected workflows for rn role.

### RnCommandCenterScreen

* **Route**: `/offices/clinical/roles/rn/rn-command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_command_center_screen.dart`
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
* **Missing Business Features**: charting, vitals, care-plan, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnPatientChartingScreen

* **Route**: `/offices/clinical/roles/rn/patient-charting`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_patient_charting_screen.dart`
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 3
* **Missing Business Features**: vitals, care-plan, assessment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnMedicationsScreen

* **Route**: `/offices/clinical/roles/rn/medications`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_medications_screen.dart`
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
* **Missing Business Features**: charting, vitals, care-plan, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnVitalsScreen

* **Route**: `/offices/clinical/roles/rn/vitals`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_vitals_screen.dart`
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
* **Missing Business Features**: charting, care-plan, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnCarePlanReviewScreen

* **Route**: `/offices/clinical/roles/rn/rn-care-plan-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_care_plan_review_screen.dart`
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
* **Missing Business Features**: charting, vitals, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnIncidentReviewScreen

* **Route**: `/offices/clinical/roles/rn/rn-incident-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_incident_review_screen.dart`
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
* **Missing Business Features**: charting, vitals, care-plan, assessment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnTasksScreen

* **Route**: `/offices/clinical/roles/rn/rn-tasks`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_tasks_screen.dart`
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
* **Missing Business Features**: charting, vitals, care-plan, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RnReportsScreen

* **Route**: `/offices/clinical/roles/rn/rn-reports`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/rn_reports_screen.dart`
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
* **Missing Business Features**: charting, vitals, care-plan, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### MedicationAdministrationScreen

* **Route**: `/offices/clinical/roles/rn/medication-administration`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/medication_administration_screen.dart`
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
* **Missing Business Features**: charting, care-plan, assessment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### CarePlanReviewScreen

* **Route**: `/offices/clinical/roles/rn/care-plan-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/care_plan_review_screen.dart`
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
* **Missing Business Features**: charting, vitals, assessment
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IncidentReviewScreen

* **Route**: `/offices/clinical/roles/rn/incident-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/incident_review_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: charting, medication, vitals, care-plan, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ShiftReportScreen

* **Route**: `/offices/clinical/roles/rn/shift-report`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/shift_report_screen.dart`
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
* **Business Workflow Score**: 6
* **Role Expectation Score**: 0
* **Missing Business Features**: charting, medication, vitals, care-plan, assessment, administration
* **Purpose**: Clinical director hub to review staff quality metrics, manage incident escalations, and review compliance audits.
* **Primary user goal**: Ensure high standards of clinical care, review incident reports, and pass clinical quality audits.
* **Expected user actions**: Filter incident reports, check nurse credential expirations, download audit files, sign approvals.
* **Business reason**: Mandatory for clinical safety oversight, risk mitigation, and compliance with health regulations.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Nurse Practitioner (NP) Analytics

* **Route**: `/rn/np-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/np_analytics_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: charting, medication, vitals, care-plan, assessment, administration
* **Purpose**: Registered Nurse (RN) workspace to update patient charting, administer medications, and check vitals logs.
* **Primary user goal**: Perform home care assessments, update care plans, and log vitals and medications.
* **Expected user actions**: Select patient, open medication administration list, log vitals check, submit shift notes.
* **Business reason**: Core bedside medical documentation, medication safety checks, and clinical continuity.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Nurse Practitioner (NP) Compliance Workflow

* **Route**: `/rn/np-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/rn/np_workflow_screen.dart`
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
* **Missing Business Features**: charting, vitals, care-plan, administration
* **Purpose**: Registered Nurse (RN) workspace to update patient charting, administer medications, and check vitals logs.
* **Primary user goal**: Perform home care assessments, update care plans, and log vitals and medications.
* **Expected user actions**: Select patient, open medication administration list, log vitals check, submit shift notes.
* **Business reason**: Core bedside medical documentation, medication safety checks, and clinical continuity.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Rn Charting

* **Route**: `/generated/rn-charting`
* **Component file**: `apps/primecare_clinic/lib/features/rn/screens/rn_charting_screen.dart`
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
* **Global Navigation Count**: 0
* **Business Workflow Score**: 3
* **Role Expectation Score**: 1
* **Missing Business Features**: medication, vitals, care-plan, assessment, administration
* **Purpose**: Registered Nurse (RN) workspace to update patient charting, administer medications, and check vitals logs.
* **Primary user goal**: Perform home care assessments, update care plans, and log vitals and medications.
* **Expected user actions**: Select patient, open medication administration list, log vitals check, submit shift notes.
* **Business reason**: Core bedside medical documentation, medication safety checks, and clinical continuity.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Rn Messaging

* **Route**: `/generated/rn-messaging`
* **Component file**: `apps/primecare_clinic/lib/features/rn/screens/rn_messaging_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: charting, medication, vitals, care-plan, assessment, administration
* **Purpose**: Registered Nurse (RN) workspace to update patient charting, administer medications, and check vitals logs.
* **Primary user goal**: Perform home care assessments, update care plans, and log vitals and medications.
* **Expected user actions**: Select patient, open medication administration list, log vitals check, submit shift notes.
* **Business reason**: Core bedside medical documentation, medication safety checks, and clinical continuity.
* **Missing items**: Missing core role features: charting, medication, vitals, care-plan, assessment, administration
* **Next action**: Implement expected workflows for rn role.

## Screens to Fix First

1. **Rn Messaging** (Progress: 0%, Business Score: 8, Role Score: 0)  
   *Reason*: Missing core workflows/features: charting, medication, vitals, care-plan, assessment, administration
2. **RnDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 0)  
   *Reason*: Missing core workflows/features: charting, medication, vitals, care-plan, assessment, administration
3. **RnAnalyticsScreen** (Progress: 50%, Business Score: 6, Role Score: 1)  
   *Reason*: Missing core workflows/features: charting, medication, vitals, care-plan, administration
4. **RnAssessmentsScreen** (Progress: 50%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: charting, medication, vitals, care-plan, administration
5. **RnCarePlansScreen** (Progress: 50%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: charting, vitals, assessment, administration
6. **RnComplianceScreen** (Progress: 50%, Business Score: 5, Role Score: 2)  
   *Reason*: Missing core workflows/features: charting, vitals, care-plan, assessment
7. **Rn Charting** (Progress: 50%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: medication, vitals, care-plan, assessment, administration
8. **RnCommandCenterScreen** (Progress: 60%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: charting, vitals, care-plan, assessment, administration
9. **RnMedicationsScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: charting, vitals, care-plan, administration
10. **RnVitalsScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: charting, care-plan, assessment, administration

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Rn Messaging (Implement role-specific workflows and transactional features)
- RnDashboardScreen (Implement role-specific workflows and transactional features)
- RnAnalyticsScreen (Implement role-specific workflows and transactional features)
- RnAssessmentsScreen (Implement role-specific workflows and transactional features)
- RnCarePlansScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- RnPatientChartingScreen (Micro-interactions and design alignment polish)
- MedicationAdministrationScreen (Micro-interactions and design alignment polish)
- CarePlanReviewScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
