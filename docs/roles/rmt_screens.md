# Registered Massage Therapist (RMT)

## Role Summary

* **Role key**: `rmt`
* **Role category**: `clinical`
* **Total screens**: 15
* **Business ready screens**: 11
* **Incomplete screens**: 15
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 56.7%
* **Average screen-body interactions**: 2.1

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| RmtDashboardScreen | `/offices/clinical/roles/rmt/dashboard` | 4 | 1 | `MEANINGFUL` | 7 | 6 | None | **Yes** |
| RmtAnalyticsScreen | `/offices/clinical/roles/rmt/analytics` | 2 | 0 | `LOW_INTERACTION` | 2 | 2 | SOAP, treatment, billing, chart | **No** |
| RmtComplianceScreen | `/offices/clinical/roles/rmt/compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | massage, SOAP, treatment, billing | **No** |
| RmtWorkflowScreen | `/offices/clinical/roles/rmt/workflow` | 2 | 0 | `LOW_INTERACTION` | 3 | 3 | massage, SOAP, billing | **Yes** |
| RmtCommandCenterScreen | `/offices/clinical/roles/rmt/command-center` | 2 | 1 | `LOW_INTERACTION` | 3 | 4 | SOAP, billing | **Yes** |
| RmtAppointmentsScreen | `/offices/clinical/roles/rmt/appointments` | 2 | 1 | `LOW_INTERACTION` | 7 | 3 | massage, SOAP, billing | **Yes** |
| RmtClientIntakeScreen | `/offices/clinical/roles/rmt/client-intake` | 2 | 1 | `LOW_INTERACTION` | 6 | 3 | massage, SOAP, billing | **Yes** |
| RmtAssessmentScreen | `/offices/clinical/roles/rmt/assessment` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | appointment, massage, SOAP, billing | **No** |
| RmtTreatmentNotesScreen | `/offices/clinical/roles/rmt/treatment-notes` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | massage, SOAP, billing | **Yes** |
| RmtExercisePlanScreen | `/offices/clinical/roles/rmt/exercise-plan` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | massage, SOAP, billing | **Yes** |
| RmtBillingLinkScreen | `/offices/clinical/roles/rmt/billing-link` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | massage, SOAP | **Yes** |
| RmtReportsScreen | `/offices/clinical/roles/rmt/reports` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | massage, SOAP, billing | **Yes** |
| MassageAssessmentScreen | `/offices/clinical/roles/rmt/massage-assessment` | 2 | 1 | `LOW_INTERACTION` | 6 | 4 | SOAP, billing | **Yes** |
| HomeCarePlanScreen | `/offices/clinical/roles/rmt/home-care-plan` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | appointment, massage, SOAP, billing | **No** |
| ClientProgressScreen | `/offices/clinical/roles/rmt/client-progress` | 2 | 1 | `LOW_INTERACTION` | 5 | 3 | massage, SOAP, billing | **Yes** |

## Screen Details

### RmtDashboardScreen

* **Route**: `/offices/clinical/roles/rmt/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 4
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 7
* **Role Expectation Score**: 6
* **Missing Business Features**: None
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: None
* **Next action**: None

### RmtAnalyticsScreen

* **Route**: `/offices/clinical/roles/rmt/analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_analytics_screen.dart`
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
* **Missing Business Features**: SOAP, treatment, billing, chart
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtComplianceScreen

* **Route**: `/offices/clinical/roles/rmt/compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_compliance_screen.dart`
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
* **Missing Business Features**: massage, SOAP, treatment, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtWorkflowScreen

* **Route**: `/offices/clinical/roles/rmt/workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_workflow_screen.dart`
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
* **Business Workflow Score**: 3
* **Role Expectation Score**: 3
* **Missing Business Features**: massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtCommandCenterScreen

* **Route**: `/offices/clinical/roles/rmt/command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_command_center_screen.dart`
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
* **Missing Business Features**: SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtAppointmentsScreen

* **Route**: `/offices/clinical/roles/rmt/appointments`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_appointments_screen.dart`
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
* **Business Workflow Score**: 7
* **Role Expectation Score**: 3
* **Missing Business Features**: massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtClientIntakeScreen

* **Route**: `/offices/clinical/roles/rmt/client-intake`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_client_intake_screen.dart`
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
* **Business Workflow Score**: 6
* **Role Expectation Score**: 3
* **Missing Business Features**: massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtAssessmentScreen

* **Route**: `/offices/clinical/roles/rmt/assessment`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_assessment_screen.dart`
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
* **Missing Business Features**: appointment, massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtTreatmentNotesScreen

* **Route**: `/offices/clinical/roles/rmt/treatment-notes`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_treatment_notes_screen.dart`
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
* **Missing Business Features**: massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtExercisePlanScreen

* **Route**: `/offices/clinical/roles/rmt/exercise-plan`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_exercise_plan_screen.dart`
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
* **Missing Business Features**: massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtBillingLinkScreen

* **Route**: `/offices/clinical/roles/rmt/billing-link`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_billing_link_screen.dart`
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
* **Role Expectation Score**: 4
* **Missing Business Features**: massage, SOAP
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### RmtReportsScreen

* **Route**: `/offices/clinical/roles/rmt/reports`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/rmt_reports_screen.dart`
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
* **Missing Business Features**: massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### MassageAssessmentScreen

* **Route**: `/offices/clinical/roles/rmt/massage-assessment`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/massage_assessment_screen.dart`
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
* **Business Workflow Score**: 6
* **Role Expectation Score**: 4
* **Missing Business Features**: SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### HomeCarePlanScreen

* **Route**: `/offices/clinical/roles/rmt/home-care-plan`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/home_care_plan_screen.dart`
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
* **Missing Business Features**: appointment, massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClientProgressScreen

* **Route**: `/offices/clinical/roles/rmt/client-progress`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/client_progress_screen.dart`
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
* **Missing Business Features**: massage, SOAP, billing
* **Purpose**: Registered Massage Therapist (RMT) dashboard to view appointments, manage schedules, and log patient clinical adjustment notes.
* **Primary user goal**: Manage patient appointments, track session progress, and log clinical treatment notes.
* **Expected user actions**: Select appointment from list, create adjust/progress note, update therapy schedule, submit bill.
* **Business reason**: Required to document therapy sessions for insurance claims and clinical oversight.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **RmtAnalyticsScreen** (Progress: 40%, Business Score: 2, Role Score: 2)  
   *Reason*: Missing core workflows/features: SOAP, treatment, billing, chart
2. **RmtComplianceScreen** (Progress: 50%, Business Score: 5, Role Score: 2)  
   *Reason*: Missing core workflows/features: massage, SOAP, treatment, billing
3. **RmtAssessmentScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: appointment, massage, SOAP, billing
4. **HomeCarePlanScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: appointment, massage, SOAP, billing

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- RmtAnalyticsScreen (Implement role-specific workflows and transactional features)
- RmtComplianceScreen (Implement role-specific workflows and transactional features)
- RmtAssessmentScreen (Implement role-specific workflows and transactional features)
- HomeCarePlanScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- RmtWorkflowScreen (Micro-interactions and design alignment polish)
- RmtDashboardScreen (Micro-interactions and design alignment polish)
- RmtCommandCenterScreen (Micro-interactions and design alignment polish)
- RmtAppointmentsScreen (Micro-interactions and design alignment polish)
- RmtClientIntakeScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
