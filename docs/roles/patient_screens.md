# Patient

## Role Summary

* **Role key**: `patient`
* **Role category**: `client`
* **Total screens**: 30
* **Business ready screens**: 0
* **Incomplete screens**: 30
* **False progress screens**: 1
* **Zero Screen-Body Interaction screens**: 2
* **Average progress**: 26.7%
* **Average screen-body interactions**: 5.2

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PatientDashboardScreen | `/offices/client/roles/client/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| PatientAnalyticsScreen | `/common/patient-analytics` | 2 | 0 | `LOW_INTERACTION` | 1 | 1 | booking, invoice, message, care-plan, tracker | **No** |
| PatientWorkflowScreen | `/common/patient-workflow` | 2 | 0 | `LOW_INTERACTION` | 1 | 2 | booking, invoice, message, care-plan | **No** |
| PatientCommandCenterScreen | `/common/patient-command-center` | 2 | 1 | `LOW_INTERACTION` | 3 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| PatientAppointmentsScreen | `/common/patient-appointments` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | booking, invoice, message, care-plan, tracker | **No** |
| PatientCarePlanScreen | `/common/patient-care-plan` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | booking, appointment, invoice, message, tracker | **No** |
| PatientMessagesScreen | `/common/patient-messages` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | booking, appointment, invoice, care-plan, tracker | **No** |
| PatientDocumentsScreen | `/common/patient-documents` | 2 | 1 | `LOW_INTERACTION` | 3 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| PatientBillingScreen | `/common/patient-billing` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | booking, invoice, message, care-plan, tracker | **No** |
| PatientProfileScreen | `/offices/client/roles/client/profile` | 2 | 1 | `LOW_INTERACTION` | 3 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| ClientIssueScreen | `/staff/client-issue` | 4 | 1 | `MEANINGFUL` | 3 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Client Book Appointment | `/generated/client-book-appointment` | 8 | 6 | `MEANINGFUL` | 8 | 2 | invoice, message, care-plan, tracker | **No** |
| Client Care Team | `/generated/client-care-team` | 8 | 6 | `MEANINGFUL` | 7 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Client Dashboard | `/generated/client-dashboard` | 8 | 6 | `MEANINGFUL` | 9 | 2 | booking, message, care-plan, tracker | **No** |
| Client My Appointments | `/generated/client-my-appointments` | 8 | 6 | `MEANINGFUL` | 7 | 2 | invoice, message, care-plan, tracker | **No** |
| Client Payments | `/generated/client-payments` | 8 | 6 | `MEANINGFUL` | 9 | 1 | booking, appointment, message, care-plan, tracker | **No** |
| Client Profile | `/clinic/client-profile` | 8 | 6 | `MEANINGFUL` | 8 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Client Treatment History | `/generated/client-treatment-history` | 8 | 6 | `MEANINGFUL` | 8 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Patient Book Appointment | `/offices/client/roles/client/book-appointment` | 8 | 6 | `MEANINGFUL` | 8 | 2 | invoice, message, care-plan, tracker | **No** |
| Patient Care Team | `/offices/client/roles/client/care-team` | 8 | 6 | `MEANINGFUL` | 7 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Patient My Appointments | `/offices/client/roles/client/my-appointments` | 8 | 6 | `MEANINGFUL` | 7 | 1 | booking, invoice, message, care-plan, tracker | **No** |
| Patient Payments | `/offices/client/roles/client/payments` | 8 | 6 | `MEANINGFUL` | 8 | 1 | booking, appointment, message, care-plan, tracker | **No** |
| Patient Treatment History | `/offices/client/roles/client/treatment-history` | 8 | 6 | `MEANINGFUL` | 9 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Psw Patient Profile | `/generated/psw-patient-profile` | 8 | 6 | `MEANINGFUL` | 7 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Patient Retention Analytics | `/generated/patient-retention-analytics` | 0 | 1 | `READ_ONLY_VALID` | 4 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Patient Case Study Repository | `/generated/patient-case-study-repository` | 3 | 2 | `MEANINGFUL` | 2 | 1 | booking, appointment, invoice, care-plan, tracker | **No** |
| Patient Acquisition Cost Tracker | `/generated/patient-acquisition-cost-tracker` | 0 | 1 | `ZERO_SCREEN_BODY_INTERACTION` | 3 | 2 | booking, appointment, invoice, care-plan | **No** |
| Patient Medication Adherence | `/generated/patient-medication-adherence` | 8 | 6 | `MEANINGFUL` | 7 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Patient Trial Outcomeser | `/generated/patient-trial-outcomeser` | 8 | 6 | `MEANINGFUL` | 7 | 0 | booking, appointment, invoice, message, care-plan, tracker | **No** |
| Remote Patient Monitoring Dashboard | `/generated/remote-patient-monitoring-dashboard` | 8 | 6 | `MEANINGFUL` | 7 | 1 | booking, appointment, invoice, message, care-plan | **No** |

## Screen Details

### PatientDashboardScreen

* **Route**: `/offices/client/roles/client/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_dashboard_screen.dart`
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
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for PatientDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientAnalyticsScreen

* **Route**: `/common/patient-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_analytics_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: booking, invoice, message, care-plan, tracker
* **Purpose**: Business intelligence analytics dashboard for PatientAnalyticsScreen to monitor performance trends.
* **Primary user goal**: Review historical metrics, filter performance reports, and analyze operational trends.
* **Expected user actions**: Select date range filter, export chart data to CSV, switch between metric tab displays.
* **Business reason**: Data-driven performance tracking and resource allocation forecasting.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientWorkflowScreen

* **Route**: `/common/patient-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_workflow_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: booking, invoice, message, care-plan
* **Purpose**: Operational workflow configuration and tracking screen for PatientWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientCommandCenterScreen

* **Route**: `/common/patient-command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_command_center_screen.dart`
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
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for PatientCommandCenterScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientAppointmentsScreen

* **Route**: `/common/patient-appointments`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_appointments_screen.dart`
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
* **Missing Business Features**: booking, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for PatientAppointmentsScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientCarePlanScreen

* **Route**: `/common/patient-care-plan`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_care_plan_screen.dart`
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
* **Missing Business Features**: booking, appointment, invoice, message, tracker
* **Purpose**: Management workspace screen for PatientCarePlanScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientMessagesScreen

* **Route**: `/common/patient-messages`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_messages_screen.dart`
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
* **Missing Business Features**: booking, appointment, invoice, care-plan, tracker
* **Purpose**: Management workspace screen for PatientMessagesScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientDocumentsScreen

* **Route**: `/common/patient-documents`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_documents_screen.dart`
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
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for PatientDocumentsScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientBillingScreen

* **Route**: `/common/patient-billing`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_billing_screen.dart`
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
* **Missing Business Features**: booking, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for PatientBillingScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PatientProfileScreen

* **Route**: `/offices/client/roles/client/profile`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/patient_profile_screen.dart`
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
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for PatientProfileScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClientIssueScreen

* **Route**: `/staff/client-issue`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/client_issue_screen.dart`
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
* **Business Workflow Score**: 3
* **Role Expectation Score**: 0
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for ClientIssueScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Client Book Appointment

* **Route**: `/generated/client-book-appointment`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/client_book_appointment_screen.dart`
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
* **Missing Business Features**: invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Client Book Appointment module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Client Care Team

* **Route**: `/generated/client-care-team`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/client_care_team_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Client Care Team module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Client Dashboard

* **Route**: `/generated/client-dashboard`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/client_dashboard_screen.dart`
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
* **Missing Business Features**: booking, message, care-plan, tracker
* **Purpose**: Management workspace screen for Client Dashboard module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Client My Appointments

* **Route**: `/generated/client-my-appointments`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/client_my_appointments_screen.dart`
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
* **Missing Business Features**: invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Client My Appointments module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Client Payments

* **Route**: `/generated/client-payments`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/client_payments_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: booking, appointment, message, care-plan, tracker
* **Purpose**: Management workspace screen for Client Payments module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Client Profile

* **Route**: `/clinic/client-profile`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/client_profile_screen.dart`
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
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Client Profile module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Client Treatment History

* **Route**: `/generated/client-treatment-history`
* **Component file**: `apps/primecare_client/lib/features/generated_screens/client_treatment_history_screen.dart`
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
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Client Treatment History module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient Book Appointment

* **Route**: `/offices/client/roles/client/book-appointment`
* **Component file**: `apps/primecare_client/lib/features/patient/screens/patient_book_appointment_screen.dart`
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
* **Missing Business Features**: invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Patient Book Appointment module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient Care Team

* **Route**: `/offices/client/roles/client/care-team`
* **Component file**: `apps/primecare_client/lib/features/patient/screens/patient_care_team_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Patient Care Team module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient My Appointments

* **Route**: `/offices/client/roles/client/my-appointments`
* **Component file**: `apps/primecare_client/lib/features/patient/screens/patient_my_appointments_screen.dart`
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
* **Missing Business Features**: booking, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Patient My Appointments module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient Payments

* **Route**: `/offices/client/roles/client/payments`
* **Component file**: `apps/primecare_client/lib/features/patient/screens/patient_payments_screen.dart`
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
* **Missing Business Features**: booking, appointment, message, care-plan, tracker
* **Purpose**: Management workspace screen for Patient Payments module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient Treatment History

* **Route**: `/offices/client/roles/client/treatment-history`
* **Component file**: `apps/primecare_client/lib/features/patient/screens/patient_treatment_history_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Patient Treatment History module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Psw Patient Profile

* **Route**: `/generated/psw-patient-profile`
* **Component file**: `apps/primecare_clinic/lib/features/generated_screens/psw_patient_profile_screen.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Personal Support Worker (PSW) client visit logger to record care plans, vitals, and daily notes.
* **Primary user goal**: Review client visit schedules, check off care tasks, and submit daily notes.
* **Expected user actions**: Check off daily ADL checklist, write visit note, log client vitals, submit shift summary.
* **Business reason**: Documents direct daily living support services for client invoicing and care plan updates.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient Retention Analytics

* **Route**: `/generated/patient-retention-analytics`
* **Component file**: `packages/primecare_ui/lib/src/features/analytics/patient_retention_analytics.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `NON_INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `READ_ONLY_VALID`
* **Screen Body Interactions**: 0
  * **Buttons**: 0
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 4
* **Role Expectation Score**: 0
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Non-interactive visual placeholder. Screen has no actionable widgets or controls.
* **Primary user goal**: None - no user goals can be accomplished on this screen.
* **Expected user actions**: None
* **Business reason**: Empty stub or placeholder showing no read-only or transactional value.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient Case Study Repository

* **Route**: `/generated/patient-case-study-repository`
* **Component file**: `packages/primecare_ui/lib/src/features/education/patient_case_study_repository.dart`
* **Current stage**: Stage 7
* **Progress %**: 70%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 1
  * **Forms**: 0
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 1
* **Global Navigation Count**: 2
* **Business Workflow Score**: 2
* **Role Expectation Score**: 1
* **Missing Business Features**: booking, appointment, invoice, care-plan, tracker
* **Purpose**: Management workspace screen for Patient Case Study Repository module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient Acquisition Cost Tracker

* **Route**: `/generated/patient-acquisition-cost-tracker`
* **Component file**: `packages/primecare_ui/lib/src/features/marketing/patient_acquisition_cost_tracker.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `NON_INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `ZERO_SCREEN_BODY_INTERACTION`
* **Screen Body Interactions**: 0
  * **Buttons**: 0
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 2
* **Missing Business Features**: booking, appointment, invoice, care-plan
* **Purpose**: Non-interactive visual placeholder. Screen has no actionable widgets or controls.
* **Primary user goal**: None - no user goals can be accomplished on this screen.
* **Expected user actions**: None
* **Business reason**: Empty stub or placeholder showing no read-only or transactional value.
* **Missing items**: Zero screen-body interactions. Only global navigation elements found.
* **Next action**: Wired page actions and form controls directly in body.

### Patient Medication Adherence

* **Route**: `/generated/patient-medication-adherence`
* **Component file**: `packages/primecare_ui/lib/src/features/pharmacy/patient_medication_adherence.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Patient Medication Adherence module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Patient Trial Outcomeser

* **Route**: `/generated/patient-trial-outcomeser`
* **Component file**: `packages/primecare_ui/lib/src/features/research/patient_trial_outcomes_viewer.dart`
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
* **Role Expectation Score**: 0
* **Missing Business Features**: booking, appointment, invoice, message, care-plan, tracker
* **Purpose**: Management workspace screen for Patient Trial Outcomeser module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan, tracker
* **Next action**: Implement expected workflows for patient role.

### Remote Patient Monitoring Dashboard

* **Route**: `/generated/remote-patient-monitoring-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/features/telehealth/remote_patient_monitoring_dashboard.dart`
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
* **Missing Business Features**: booking, appointment, invoice, message, care-plan
* **Purpose**: Platform governance dashboard to view audit trails, runtime checks, database drift, and telemetry logs.
* **Primary user goal**: Verify system integrity, inspect security audit logs, and remediate registry configuration drift.
* **Expected user actions**: Run security sweep, download compliance audit files, approve database schema alterations.
* **Business reason**: Maintains platform regulatory security standards and code governance control rooms.
* **Missing items**: Missing core role features: booking, appointment, invoice, message, care-plan
* **Next action**: Implement expected workflows for patient role.

## Screens to Fix First

1. **Client Book Appointment** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: invoice, message, care-plan, tracker
2. **Client Care Team** (Progress: 0%, Business Score: 7, Role Score: 0)  
   *Reason*: Missing core workflows/features: booking, appointment, invoice, message, care-plan, tracker
3. **Client Dashboard** (Progress: 0%, Business Score: 9, Role Score: 2)  
   *Reason*: Missing core workflows/features: booking, message, care-plan, tracker
4. **Client My Appointments** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: invoice, message, care-plan, tracker
5. **Client Payments** (Progress: 0%, Business Score: 9, Role Score: 1)  
   *Reason*: Missing core workflows/features: booking, appointment, message, care-plan, tracker
6. **Client Profile** (Progress: 0%, Business Score: 8, Role Score: 0)  
   *Reason*: Missing core workflows/features: booking, appointment, invoice, message, care-plan, tracker
7. **Client Treatment History** (Progress: 0%, Business Score: 8, Role Score: 0)  
   *Reason*: Missing core workflows/features: booking, appointment, invoice, message, care-plan, tracker
8. **Patient Book Appointment** (Progress: 0%, Business Score: 8, Role Score: 2)  
   *Reason*: Missing core workflows/features: invoice, message, care-plan, tracker
9. **Patient Care Team** (Progress: 0%, Business Score: 7, Role Score: 0)  
   *Reason*: Missing core workflows/features: booking, appointment, invoice, message, care-plan, tracker
10. **Patient My Appointments** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: booking, invoice, message, care-plan, tracker

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Client Book Appointment (Implement role-specific workflows and transactional features)
- Client Care Team (Implement role-specific workflows and transactional features)
- Client Dashboard (Implement role-specific workflows and transactional features)
- Client My Appointments (Implement role-specific workflows and transactional features)
- Client Payments (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
