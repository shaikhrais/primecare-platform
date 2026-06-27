# Chiropractor

## Role Summary

* **Role key**: `chiropractor`
* **Role category**: `clinical`
* **Total screens**: 16
* **Business ready screens**: 1
* **Incomplete screens**: 16
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 56.9%
* **Average screen-body interactions**: 2.0

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ChiropractorDashboardScreen | `/offices/clinical/roles/chiropractor/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | appointment, adjustment, SOAP, treatment, billing, x-ray | **No** |
| ChiropractorAnalyticsScreen | `/offices/clinical/roles/chiropractor/analytics` | 2 | 0 | `LOW_INTERACTION` | 4 | 3 | adjustment, SOAP, billing, x-ray | **No** |
| ChiropractorComplianceScreen | `/offices/clinical/roles/chiropractor/compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 3 | adjustment, SOAP, chart, x-ray | **No** |
| ChiropractorWorkflowScreen | `/offices/clinical/roles/chiropractor/workflow` | 2 | 0 | `LOW_INTERACTION` | 3 | 3 | adjustment, SOAP, billing, x-ray | **No** |
| ChiropractorCommandCenterScreen | `/offices/clinical/roles/chiropractor/command-center` | 2 | 1 | `LOW_INTERACTION` | 5 | 3 | appointment, SOAP, billing, x-ray | **No** |
| ChiropractorAppointmentsScreen | `/offices/clinical/roles/chiropractor/appointments` | 2 | 1 | `LOW_INTERACTION` | 3 | 3 | adjustment, SOAP, billing, x-ray | **No** |
| ChiropractorClientIntakeScreen | `/offices/clinical/roles/chiropractor/client-intake` | 2 | 1 | `LOW_INTERACTION` | 5 | 2 | appointment, adjustment, SOAP, billing, x-ray | **No** |
| ChiropractorAssessmentScreen | `/offices/clinical/roles/chiropractor/assessment` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | appointment, adjustment, SOAP, billing, x-ray | **No** |
| ChiropractorTreatmentNotesScreen | `/offices/clinical/roles/chiropractor/treatment-notes` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | appointment, adjustment, SOAP, billing, x-ray | **No** |
| ChiropractorExercisePlanScreen | `/offices/clinical/roles/chiropractor/exercise-plan` | 2 | 1 | `LOW_INTERACTION` | 6 | 3 | appointment, SOAP, billing, x-ray | **No** |
| ChiropractorBillingLinkScreen | `/offices/clinical/roles/chiropractor/billing-link` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | appointment, adjustment, SOAP, treatment, x-ray | **No** |
| ChiropractorReportsScreen | `/offices/clinical/roles/chiropractor/reports` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | appointment, adjustment, SOAP, treatment, billing, x-ray | **No** |
| ChiropracticAssessmentScreen | `/offices/clinical/roles/chiropractor/chiropractic-assessment` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | SOAP, billing, x-ray | **Yes** |
| AdjustmentNotesScreen | `/offices/clinical/roles/chiropractor/adjustment-notes` | 2 | 1 | `LOW_INTERACTION` | 3 | 3 | appointment, SOAP, billing, x-ray | **No** |
| XrayReviewScreen | `/offices/clinical/roles/chiropractor/xray-review` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | appointment, adjustment, SOAP, billing | **No** |
| ChiropracticProgressTrackingScreen | `/offices/clinical/roles/chiropractor/chiropractic-progress-tracking` | 2 | 1 | `LOW_INTERACTION` | 6 | 2 | appointment, adjustment, SOAP, billing, x-ray | **No** |

## Screen Details

### ChiropractorDashboardScreen

* **Route**: `/offices/clinical/roles/chiropractor/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/chiropractor_dashboard_screen.dart`
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
* **Missing Business Features**: appointment, adjustment, SOAP, treatment, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorAnalyticsScreen

* **Route**: `/offices/clinical/roles/chiropractor/analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/chiropractor_analytics_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 3
* **Missing Business Features**: adjustment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorComplianceScreen

* **Route**: `/offices/clinical/roles/chiropractor/compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/chiropractor_compliance_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: adjustment, SOAP, chart, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorWorkflowScreen

* **Route**: `/offices/clinical/roles/chiropractor/workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/chiropractor_workflow_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: adjustment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorCommandCenterScreen

* **Route**: `/offices/clinical/roles/chiropractor/command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_command_center_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: appointment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorAppointmentsScreen

* **Route**: `/offices/clinical/roles/chiropractor/appointments`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_appointments_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: adjustment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorClientIntakeScreen

* **Route**: `/offices/clinical/roles/chiropractor/client-intake`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_client_intake_screen.dart`
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
* **Missing Business Features**: appointment, adjustment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorAssessmentScreen

* **Route**: `/offices/clinical/roles/chiropractor/assessment`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_assessment_screen.dart`
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
* **Missing Business Features**: appointment, adjustment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorTreatmentNotesScreen

* **Route**: `/offices/clinical/roles/chiropractor/treatment-notes`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_treatment_notes_screen.dart`
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
* **Missing Business Features**: appointment, adjustment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorExercisePlanScreen

* **Route**: `/offices/clinical/roles/chiropractor/exercise-plan`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_exercise_plan_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: appointment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorBillingLinkScreen

* **Route**: `/offices/clinical/roles/chiropractor/billing-link`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_billing_link_screen.dart`
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
* **Missing Business Features**: appointment, adjustment, SOAP, treatment, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropractorReportsScreen

* **Route**: `/offices/clinical/roles/chiropractor/reports`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractor_reports_screen.dart`
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
* **Missing Business Features**: appointment, adjustment, SOAP, treatment, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropracticAssessmentScreen

* **Route**: `/offices/clinical/roles/chiropractor/chiropractic-assessment`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractic_assessment_screen.dart`
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
* **Missing Business Features**: SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### AdjustmentNotesScreen

* **Route**: `/offices/clinical/roles/chiropractor/adjustment-notes`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/adjustment_notes_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: appointment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### XrayReviewScreen

* **Route**: `/offices/clinical/roles/chiropractor/xray-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/xray_review_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: appointment, adjustment, SOAP, billing
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ChiropracticProgressTrackingScreen

* **Route**: `/offices/clinical/roles/chiropractor/chiropractic-progress-tracking`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/chiropractic_progress_tracking_screen.dart`
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
* **Missing Business Features**: appointment, adjustment, SOAP, billing, x-ray
* **Purpose**: Chiropractic command center to view adjustment appointments, review X-rays, and log adjustment notes.
* **Primary user goal**: Assess spine alignment records, review imaging, and log spine adjustment progress notes.
* **Expected user actions**: Open X-ray review panel, click adjustment notes, save chiropractic record, trigger billing.
* **Business reason**: Supports chiropractic clinical workflows and patient alignment history documentation.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **ChiropractorAnalyticsScreen** (Progress: 40%, Business Score: 4, Role Score: 3)  
   *Reason*: Missing core workflows/features: adjustment, SOAP, billing, x-ray
2. **ChiropractorDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: appointment, adjustment, SOAP, treatment, billing, x-ray
3. **ChiropractorComplianceScreen** (Progress: 50%, Business Score: 5, Role Score: 3)  
   *Reason*: Missing core workflows/features: adjustment, SOAP, chart, x-ray
4. **ChiropractorWorkflowScreen** (Progress: 50%, Business Score: 3, Role Score: 3)  
   *Reason*: Missing core workflows/features: adjustment, SOAP, billing, x-ray
5. **ChiropractorCommandCenterScreen** (Progress: 60%, Business Score: 5, Role Score: 3)  
   *Reason*: Missing core workflows/features: appointment, SOAP, billing, x-ray
6. **ChiropractorAppointmentsScreen** (Progress: 60%, Business Score: 3, Role Score: 3)  
   *Reason*: Missing core workflows/features: adjustment, SOAP, billing, x-ray
7. **ChiropractorClientIntakeScreen** (Progress: 60%, Business Score: 5, Role Score: 2)  
   *Reason*: Missing core workflows/features: appointment, adjustment, SOAP, billing, x-ray
8. **ChiropractorAssessmentScreen** (Progress: 60%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: appointment, adjustment, SOAP, billing, x-ray
9. **ChiropractorTreatmentNotesScreen** (Progress: 60%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: appointment, adjustment, SOAP, billing, x-ray
10. **ChiropractorExercisePlanScreen** (Progress: 60%, Business Score: 6, Role Score: 3)  
   *Reason*: Missing core workflows/features: appointment, SOAP, billing, x-ray

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- ChiropractorAnalyticsScreen (Implement role-specific workflows and transactional features)
- ChiropractorDashboardScreen (Implement role-specific workflows and transactional features)
- ChiropractorComplianceScreen (Implement role-specific workflows and transactional features)
- ChiropractorWorkflowScreen (Implement role-specific workflows and transactional features)
- ChiropractorCommandCenterScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- ChiropracticAssessmentScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
