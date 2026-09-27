# Intake Coordinator

## Role Summary

* **Role key**: `intake`
* **Role category**: `clinical`
* **Total screens**: 26
* **Business ready screens**: 0
* **Incomplete screens**: 26
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 38.8%
* **Average screen-body interactions**: 3.8

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| IntakeDashboardScreen | `/offices/clinical/roles/intake_coordinator/dashboard-dup-1` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | referral, registration, assessment, scheduling, insurance, onboarding | **No** |
| IntakeCoordinatorDashboardScreen | `/offices/clinical/roles/intake_coordinator/dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | referral, registration, assessment, scheduling, insurance, onboarding | **No** |
| IntakeAnalyticsScreen | `/offices/clinical/roles/intake_coordinator/analytics` | 2 | 0 | `LOW_INTERACTION` | 1 | 2 | registration, assessment, insurance, onboarding | **No** |
| IntakeComplianceScreen | `/offices/clinical/roles/intake_coordinator/compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | referral, registration, assessment, scheduling, insurance, onboarding | **No** |
| IntakeWorkflowScreen | `/offices/clinical/roles/intake_coordinator/workflow` | 2 | 0 | `LOW_INTERACTION` | 2 | 2 | registration, assessment, insurance, onboarding | **No** |
| IntakeCoordinatorAnalyticsScreen | `/offices/clinical/roles/intake_coordinator/coordinator-analytics` | 3 | 0 | `MEANINGFUL` | 3 | 2 | registration, assessment, insurance, onboarding | **No** |
| IntakeCoordinatorComplianceScreen | `/offices/clinical/roles/intake_coordinator/coordinator-compliance` | 4 | 1 | `MEANINGFUL` | 5 | 0 | referral, registration, assessment, scheduling, insurance, onboarding | **No** |
| IntakeCoordinatorWorkflowScreen | `/offices/clinical/roles/intake_coordinator/coordinator-workflow` | 3 | 0 | `MEANINGFUL` | 4 | 2 | registration, assessment, insurance, onboarding | **No** |
| IntakeCoordinatorReferralsScreen | `/executive/intake-coordinator-referrals` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | registration, assessment, scheduling, insurance, onboarding | **No** |
| IntakeCoordinatorNewClientIntakeScreen | `/executive/intake-coordinator-new-client-intake` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | referral, registration, assessment, insurance, onboarding | **No** |
| IntakeCoordinatorAssessmentQueueScreen | `/executive/intake-coordinator-assessment-queue` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | referral, registration, insurance, onboarding | **No** |
| IntakeCoordinatorBookingScreen | `/executive/intake-coordinator-booking` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | referral, registration, assessment, insurance, onboarding | **No** |
| IntakeCoordinatorDocumentsScreen | `/executive/intake-coordinator-documents` | 2 | 1 | `LOW_INTERACTION` | 4 | 0 | referral, registration, assessment, scheduling, insurance, onboarding | **No** |
| IntakeCoordinatorFollowUpScreen | `/executive/intake-coordinator-follow-up` | 2 | 1 | `LOW_INTERACTION` | 4 | 1 | referral, registration, assessment, insurance, onboarding | **No** |
| ReferralManagementScreen | `/offices/clinical/roles/intake_coordinator/referral-management` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | registration, assessment, scheduling, insurance, onboarding | **No** |
| ClientIntakeScreen | `/offices/clinical/roles/intake_coordinator/client-intake` | 2 | 1 | `LOW_INTERACTION` | 6 | 0 | referral, registration, assessment, scheduling, insurance, onboarding | **No** |
| BookingScreen | `/offices/clinical/roles/intake_coordinator/booking` | 2 | 1 | `LOW_INTERACTION` | 5 | 1 | referral, registration, assessment, insurance, onboarding | **No** |
| FollowupScreen | `/offices/clinical/roles/intake_coordinator/followup` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | registration, assessment, insurance, onboarding | **No** |
| Intake Coordinator Assessments | `/generated/intake-coordinator-assessments` | 8 | 6 | `MEANINGFUL` | 9 | 2 | registration, scheduling, insurance, onboarding | **No** |
| Intake Coordinator Client Assignment | `/generated/intake-coordinator-client-assignment` | 8 | 6 | `MEANINGFUL` | 7 | 2 | referral, registration, scheduling, insurance | **No** |
| Intake Coordinator Eligibility | `/generated/intake-coordinator-eligibility` | 8 | 6 | `MEANINGFUL` | 9 | 1 | referral, registration, assessment, scheduling, onboarding | **No** |
| Intake Coordinator Intake Forms | `/generated/intake-coordinator-intake-forms` | 8 | 6 | `MEANINGFUL` | 7 | 1 | registration, assessment, scheduling, insurance, onboarding | **No** |
| Intake Coordinator New Intakes | `/generated/intake-coordinator-new-intakes` | 8 | 6 | `MEANINGFUL` | 7 | 1 | referral, registration, scheduling, insurance, onboarding | **No** |
| Intake Coordinator Reports | `/generated/intake-coordinator-reports` | 8 | 6 | `MEANINGFUL` | 8 | 1 | referral, registration, scheduling, insurance, onboarding | **No** |
| Intake Coordinator Scheduling | `/generated/intake-coordinator-scheduling` | 8 | 6 | `MEANINGFUL` | 7 | 2 | referral, registration, insurance, onboarding | **No** |
| IntakeCoordinatorDashboardScreen | `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | referral, registration, assessment, scheduling, insurance, onboarding | **No** |

## Screen Details

### IntakeDashboardScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/dashboard-dup-1`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/intake_dashboard_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Duplicate screen copy for IntakeDashboardScreen. Created during route split or template duplication.
* **Primary user goal**: Re-route or consolidate user traffic back to the primary screen.
* **Expected user actions**: None. Consolidated into main dashboard.
* **Business reason**: Redundant route node; duplicate of main feature screen.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeCoordinatorDashboardScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeAnalyticsScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/intake_analytics_screen.dart`
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
* **Missing Business Features**: registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeComplianceScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/intake_compliance_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeWorkflowScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/intake_workflow_screen.dart`
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
* **Missing Business Features**: registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeCoordinatorAnalyticsScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/coordinator-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_analytics_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: registration, assessment, insurance, onboarding
* **Next action**: Implement expected workflows for intake role.

### IntakeCoordinatorComplianceScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/coordinator-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 0
* **Missing Business Features**: referral, registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: referral, registration, assessment, scheduling, insurance, onboarding
* **Next action**: Implement expected workflows for intake role.

### IntakeCoordinatorWorkflowScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/coordinator-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_workflow_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 2
* **Missing Business Features**: registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: registration, assessment, insurance, onboarding
* **Next action**: Implement expected workflows for intake role.

### IntakeCoordinatorReferralsScreen

* **Route**: `/executive/intake-coordinator-referrals`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_referrals_screen.dart`
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
* **Missing Business Features**: registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeCoordinatorNewClientIntakeScreen

* **Route**: `/executive/intake-coordinator-new-client-intake`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_new_client_intake_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeCoordinatorAssessmentQueueScreen

* **Route**: `/executive/intake-coordinator-assessment-queue`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_assessment_queue_screen.dart`
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
* **Missing Business Features**: referral, registration, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeCoordinatorBookingScreen

* **Route**: `/executive/intake-coordinator-booking`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_booking_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeCoordinatorDocumentsScreen

* **Route**: `/executive/intake-coordinator-documents`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_documents_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IntakeCoordinatorFollowUpScreen

* **Route**: `/executive/intake-coordinator-follow-up`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/intake_coordinator_follow_up_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ReferralManagementScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/referral-management`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/referral_management_screen.dart`
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
* **Missing Business Features**: registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClientIntakeScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/client-intake`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/client_intake_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### BookingScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/booking`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/booking_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### FollowupScreen

* **Route**: `/offices/clinical/roles/intake_coordinator/followup`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/followup_screen.dart`
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
* **Missing Business Features**: registration, assessment, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Intake Coordinator Assessments

* **Route**: `/generated/intake-coordinator-assessments`
* **Component file**: `apps/primecare_clinic/lib/features/generated_screens/intake_coordinator_assessments_screen.dart`
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
* **Missing Business Features**: registration, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: registration, scheduling, insurance, onboarding
* **Next action**: Implement expected workflows for intake role.

### Intake Coordinator Client Assignment

* **Route**: `/generated/intake-coordinator-client-assignment`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/intake_coordinator_client_assignment_screen.dart`
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
* **Missing Business Features**: referral, registration, scheduling, insurance
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: referral, registration, scheduling, insurance
* **Next action**: Implement expected workflows for intake role.

### Intake Coordinator Eligibility

* **Route**: `/generated/intake-coordinator-eligibility`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/intake_coordinator_eligibility_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, scheduling, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: referral, registration, assessment, scheduling, onboarding
* **Next action**: Implement expected workflows for intake role.

### Intake Coordinator Intake Forms

* **Route**: `/generated/intake-coordinator-intake-forms`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/intake_coordinator_intake_forms_screen.dart`
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
* **Missing Business Features**: registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: registration, assessment, scheduling, insurance, onboarding
* **Next action**: Implement expected workflows for intake role.

### Intake Coordinator New Intakes

* **Route**: `/generated/intake-coordinator-new-intakes`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/intake_coordinator_new_intakes_screen.dart`
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
* **Missing Business Features**: referral, registration, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: referral, registration, scheduling, insurance, onboarding
* **Next action**: Implement expected workflows for intake role.

### Intake Coordinator Reports

* **Route**: `/generated/intake-coordinator-reports`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/intake_coordinator_reports_screen.dart`
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
* **Missing Business Features**: referral, registration, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: referral, registration, scheduling, insurance, onboarding
* **Next action**: Implement expected workflows for intake role.

### Intake Coordinator Scheduling

* **Route**: `/generated/intake-coordinator-scheduling`
* **Component file**: `apps/primecare_support/lib/features/generated_screens/intake_coordinator_scheduling_screen.dart`
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
* **Missing Business Features**: referral, registration, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: referral, registration, insurance, onboarding
* **Next action**: Implement expected workflows for intake role.

### IntakeCoordinatorDashboardScreen

* **Route**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart`
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
* **Missing Business Features**: referral, registration, assessment, scheduling, insurance, onboarding
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **Intake Coordinator Assessments** (Progress: 0%, Business Score: 9, Role Score: 2)  
   *Reason*: Missing core workflows/features: registration, scheduling, insurance, onboarding
2. **Intake Coordinator Client Assignment** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: referral, registration, scheduling, insurance
3. **Intake Coordinator Eligibility** (Progress: 0%, Business Score: 9, Role Score: 1)  
   *Reason*: Missing core workflows/features: referral, registration, assessment, scheduling, onboarding
4. **Intake Coordinator Intake Forms** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: registration, assessment, scheduling, insurance, onboarding
5. **Intake Coordinator New Intakes** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: referral, registration, scheduling, insurance, onboarding
6. **Intake Coordinator Reports** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: referral, registration, scheduling, insurance, onboarding
7. **Intake Coordinator Scheduling** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: referral, registration, insurance, onboarding
8. **IntakeAnalyticsScreen** (Progress: 40%, Business Score: 1, Role Score: 2)  
   *Reason*: Missing core workflows/features: registration, assessment, insurance, onboarding
9. **IntakeWorkflowScreen** (Progress: 40%, Business Score: 2, Role Score: 2)  
   *Reason*: Missing core workflows/features: registration, assessment, insurance, onboarding
10. **IntakeCoordinatorAnalyticsScreen** (Progress: 40%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: registration, assessment, insurance, onboarding

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Intake Coordinator Assessments (Implement role-specific workflows and transactional features)
- Intake Coordinator Client Assignment (Implement role-specific workflows and transactional features)
- Intake Coordinator Eligibility (Implement role-specific workflows and transactional features)
- Intake Coordinator Intake Forms (Implement role-specific workflows and transactional features)
- Intake Coordinator New Intakes (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- IntakeDashboardScreen (Consolidate redundant route split entries)
