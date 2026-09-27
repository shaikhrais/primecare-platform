# Physiotherapist

## Role Summary

* **Role key**: `physio`
* **Role category**: `clinical`
* **Total screens**: 16
* **Business ready screens**: 0
* **Incomplete screens**: 16
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 55.6%
* **Average screen-body interactions**: 2.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PhysiotherapistDashboardScreen | `/offices/clinical/roles/physiotherapist/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | rehabilitation, exercise, treatment, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistAnalyticsScreen | `/offices/clinical/roles/physiotherapist/analytics` | 2 | 0 | `LOW_INTERACTION` | 3 | 1 | rehabilitation, exercise, booking, SOAP, chart, range-of-motion | **No** |
| PhysiotherapistComplianceScreen | `/offices/clinical/roles/physiotherapist/compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | rehabilitation, exercise, booking, SOAP, chart, range-of-motion | **No** |
| PhysiotherapistWorkflowScreen | `/offices/clinical/roles/physiotherapist/workflow` | 2 | 0 | `LOW_INTERACTION` | 2 | 1 | rehabilitation, exercise, booking, SOAP, chart, range-of-motion | **No** |
| PhysiotherapistCommandCenterScreen | `/offices/clinical/roles/physiotherapist/command-center` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | rehabilitation, exercise, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistAppointmentsScreen | `/offices/clinical/roles/physiotherapist/appointments` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | rehabilitation, exercise, treatment, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistClientIntakeScreen | `/offices/clinical/roles/physiotherapist/client-intake` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | rehabilitation, exercise, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistAssessmentScreen | `/offices/clinical/roles/physiotherapist/assessment` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | rehabilitation, exercise, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistTreatmentNotesScreen | `/offices/clinical/roles/physiotherapist/treatment-notes` | 2 | 1 | `LOW_INTERACTION` | 6 | 2 | rehabilitation, exercise, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistExercisePlanScreen | `/offices/clinical/roles/physiotherapist/exercise-plan` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | rehabilitation, treatment, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistBillingLinkScreen | `/offices/clinical/roles/physiotherapist/billing-link` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | rehabilitation, exercise, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistReportsScreen | `/offices/clinical/roles/physiotherapist/reports` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | rehabilitation, exercise, booking, SOAP, range-of-motion | **No** |
| TreatmentPlanScreen | `/offices/clinical/roles/physiotherapist/treatment-plan` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | rehabilitation, exercise, booking, SOAP, range-of-motion | **No** |
| ExercisePrescriptionScreen | `/offices/clinical/roles/physiotherapist/exercise-prescription` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | rehabilitation, treatment, booking, SOAP, range-of-motion | **No** |
| ProgressTrackingScreen | `/offices/clinical/roles/physiotherapist/progress-tracking` | 2 | 1 | `LOW_INTERACTION` | 4 | 2 | rehabilitation, exercise, booking, SOAP, range-of-motion | **No** |
| PhysiotherapistDashboardScreen | `packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | rehabilitation, exercise, treatment, booking, SOAP, range-of-motion | **No** |

## Screen Details

### PhysiotherapistDashboardScreen

* **Route**: `/offices/clinical/roles/physiotherapist/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, treatment, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistAnalyticsScreen

* **Route**: `/offices/clinical/roles/physiotherapist/analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_analytics_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, chart, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistComplianceScreen

* **Route**: `/offices/clinical/roles/physiotherapist/compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_compliance_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, chart, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistWorkflowScreen

* **Route**: `/offices/clinical/roles/physiotherapist/workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_workflow_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, chart, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistCommandCenterScreen

* **Route**: `/offices/clinical/roles/physiotherapist/command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_command_center_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistAppointmentsScreen

* **Route**: `/offices/clinical/roles/physiotherapist/appointments`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_appointments_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, treatment, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistClientIntakeScreen

* **Route**: `/offices/clinical/roles/physiotherapist/client-intake`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_client_intake_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistAssessmentScreen

* **Route**: `/offices/clinical/roles/physiotherapist/assessment`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_assessment_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistTreatmentNotesScreen

* **Route**: `/offices/clinical/roles/physiotherapist/treatment-notes`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_treatment_notes_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistExercisePlanScreen

* **Route**: `/offices/clinical/roles/physiotherapist/exercise-plan`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_exercise_plan_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: rehabilitation, treatment, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistBillingLinkScreen

* **Route**: `/offices/clinical/roles/physiotherapist/billing-link`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_billing_link_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistReportsScreen

* **Route**: `/offices/clinical/roles/physiotherapist/reports`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/physiotherapist_reports_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### TreatmentPlanScreen

* **Route**: `/offices/clinical/roles/physiotherapist/treatment-plan`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/treatment_plan_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ExercisePrescriptionScreen

* **Route**: `/offices/clinical/roles/physiotherapist/exercise-prescription`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/exercise_prescription_screen.dart`
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
* **Missing Business Features**: rehabilitation, treatment, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ProgressTrackingScreen

* **Route**: `/offices/clinical/roles/physiotherapist/progress-tracking`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/progress_tracking_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### PhysiotherapistDashboardScreen

* **Route**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart`
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
* **Missing Business Features**: rehabilitation, exercise, treatment, booking, SOAP, range-of-motion
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **PhysiotherapistAnalyticsScreen** (Progress: 40%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, booking, SOAP, chart, range-of-motion
2. **PhysiotherapistWorkflowScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, booking, SOAP, chart, range-of-motion
3. **PhysiotherapistDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, treatment, booking, SOAP, range-of-motion
4. **PhysiotherapistComplianceScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, booking, SOAP, chart, range-of-motion
5. **PhysiotherapistDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, treatment, booking, SOAP, range-of-motion
6. **PhysiotherapistCommandCenterScreen** (Progress: 60%, Business Score: 5, Role Score: 2)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, booking, SOAP, range-of-motion
7. **PhysiotherapistAppointmentsScreen** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, treatment, booking, SOAP, range-of-motion
8. **PhysiotherapistClientIntakeScreen** (Progress: 60%, Business Score: 5, Role Score: 2)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, booking, SOAP, range-of-motion
9. **PhysiotherapistAssessmentScreen** (Progress: 60%, Business Score: 5, Role Score: 2)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, booking, SOAP, range-of-motion
10. **PhysiotherapistTreatmentNotesScreen** (Progress: 60%, Business Score: 6, Role Score: 2)  
   *Reason*: Missing core workflows/features: rehabilitation, exercise, booking, SOAP, range-of-motion

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- PhysiotherapistAnalyticsScreen (Implement role-specific workflows and transactional features)
- PhysiotherapistWorkflowScreen (Implement role-specific workflows and transactional features)
- PhysiotherapistDashboardScreen (Implement role-specific workflows and transactional features)
- PhysiotherapistComplianceScreen (Implement role-specific workflows and transactional features)
- PhysiotherapistDashboardScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
