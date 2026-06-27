# Therapist

## Role Summary

* **Role key**: `therapist`
* **Role category**: `clinical`
* **Total screens**: 3
* **Business ready screens**: 1
* **Incomplete screens**: 3
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 60.0%
* **Average screen-body interactions**: 2.7

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TherapistDashboardScreen | `/offices/clinical/roles/therapist/dashboard` | 4 | 1 | `MEANINGFUL` | 5 | 3 | consultation, schedule, assessment | **Yes** |
| Therapist Analytics | `/offices/clinical/roles/therapist/analytics` | 2 | 1 | `LOW_INTERACTION` | 3 | 2 | consultation, session, notes, assessment | **No** |
| Therapist Compliance Workflow | `/offices/clinical/roles/therapist/workflow` | 2 | 1 | `LOW_INTERACTION` | 3 | 1 | consultation, session, schedule, notes, assessment | **No** |

## Screen Details

### TherapistDashboardScreen

* **Route**: `/offices/clinical/roles/therapist/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/therapist_dashboard_screen.dart`
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 3
* **Missing Business Features**: consultation, schedule, assessment
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: None
* **Next action**: None

### Therapist Analytics

* **Route**: `/offices/clinical/roles/therapist/analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/therapist_analytics_screen.dart`
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
* **Missing Business Features**: consultation, session, notes, assessment
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Therapist Compliance Workflow

* **Route**: `/offices/clinical/roles/therapist/workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/allied/therapist_workflow_screen.dart`
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
* **Missing Business Features**: consultation, session, schedule, notes, assessment
* **Purpose**: Therapist workspace for tracking patient clinical records, managing consultation schedules, and recording progress notes.
* **Primary user goal**: Assess client therapy goals, schedule sessions, and document therapy progress.
* **Expected user actions**: View calendar, launch therapy progress sheet, submit notes, contact patient.
* **Business reason**: Ensures therapists can track ongoing cognitive or physical rehabilitation sessions.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

## Screens to Fix First

1. **Therapist Analytics** (Progress: 60%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: consultation, session, notes, assessment
2. **Therapist Compliance Workflow** (Progress: 60%, Business Score: 3, Role Score: 1)  
   *Reason*: Missing core workflows/features: consultation, session, schedule, notes, assessment

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Therapist Analytics (Implement role-specific workflows and transactional features)
- Therapist Compliance Workflow (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- TherapistDashboardScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
