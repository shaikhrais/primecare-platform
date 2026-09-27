# Training Director

## Role Summary

* **Role key**: `training_director`
* **Role category**: `corporate`
* **Total screens**: 18
* **Business ready screens**: 0
* **Incomplete screens**: 18
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 16.1%
* **Average screen-body interactions**: 6.1

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CourseArchitectDashboardScreen | `/common/course-architect-dashboard` | 2 | 1 | `LOW_INTERACTION` | 7 | 1 | certification, curriculum, instructor, validation | **No** |
| TrainingDirectorDashboardScreen | `/offices/corporate/roles/training_director/dashboard` | 4 | 1 | `MEANINGFUL` | 5 | 0 | course, certification, curriculum, instructor, validation | **No** |
| CourseArchitectWorkflowScreen | `/common/course-architect-workflow` | 2 | 0 | `LOW_INTERACTION` | 5 | 1 | certification, curriculum, instructor, validation | **No** |
| TrainingDirectorAnalyticsScreen | `/offices/corporate/roles/training_director/analytics` | 2 | 0 | `LOW_INTERACTION` | 0 | 0 | course, certification, curriculum, instructor, validation | **No** |
| TrainingDirectorComplianceScreen | `/executive/training-director-compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 0 | course, certification, curriculum, instructor, validation | **No** |
| TrainingDirectorWorkflowScreen | `/executive/training-director-workflow` | 2 | 1 | `LOW_INTERACTION` | 3 | 0 | course, certification, curriculum, instructor, validation | **No** |
| Training Director Assessments | `/offices/corporate/roles/training_director/assessments` | 8 | 6 | `MEANINGFUL` | 7 | 0 | course, certification, curriculum, instructor, validation | **No** |
| Training Director Certificates | `/offices/corporate/roles/training_director/certificates` | 8 | 6 | `MEANINGFUL` | 7 | 1 | certification, curriculum, instructor, validation | **No** |
| Training Director Certifications | `/offices/corporate/roles/training_director/certifications` | 8 | 6 | `MEANINGFUL` | 8 | 1 | course, curriculum, instructor, validation | **No** |
| Training Director Compliance Training | `/offices/corporate/roles/training_director/compliance-training` | 8 | 6 | `MEANINGFUL` | 7 | 1 | certification, curriculum, instructor, validation | **No** |
| Training Director Course Architect | `/offices/corporate/roles/training_director/course-architect` | 8 | 6 | `MEANINGFUL` | 7 | 2 | certification, instructor, validation | **No** |
| Training Director Course Library | `/offices/corporate/roles/training_director/course-library` | 8 | 6 | `MEANINGFUL` | 7 | 1 | certification, curriculum, instructor, validation | **No** |
| Training Director Hub | `/offices/corporate/roles/training_director/hub` | 8 | 6 | `MEANINGFUL` | 8 | 1 | certification, curriculum, instructor, validation | **No** |
| Training Director Reports | `/offices/corporate/roles/training_director/reports` | 8 | 6 | `MEANINGFUL` | 7 | 0 | course, certification, curriculum, instructor, validation | **No** |
| Training Director Staff Training Matrix | `/offices/corporate/roles/training_director/staff-training-matrix` | 8 | 6 | `MEANINGFUL` | 7 | 1 | certification, curriculum, instructor, validation | **No** |
| Training Director Trainer Assignments | `/offices/corporate/roles/training_director/trainer-assignments` | 8 | 6 | `MEANINGFUL` | 7 | 1 | certification, curriculum, instructor, validation | **No** |
| Training Director Training Programs | `/offices/corporate/roles/training_director/training-programs` | 8 | 6 | `MEANINGFUL` | 7 | 0 | course, certification, curriculum, instructor, validation | **No** |
| Course Architect | `/generated/course-architect` | 8 | 6 | `MEANINGFUL` | 9 | 2 | certification, instructor, validation | **No** |

## Screen Details

### CourseArchitectDashboardScreen

* **Route**: `/common/course-architect-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/course_architect_dashboard_screen.dart`
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
* **Business Workflow Score**: 7
* **Role Expectation Score**: 1
* **Missing Business Features**: certification, curriculum, instructor, validation
* **Purpose**: Management workspace screen for CourseArchitectDashboardScreen module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### TrainingDirectorDashboardScreen

* **Route**: `/offices/corporate/roles/training_director/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/training_director_dashboard_screen.dart`
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
* **Missing Business Features**: course, certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: course, certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### CourseArchitectWorkflowScreen

* **Route**: `/common/course-architect-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/course_architect_workflow_screen.dart`
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 1
* **Missing Business Features**: certification, curriculum, instructor, validation
* **Purpose**: Operational workflow configuration and tracking screen for CourseArchitectWorkflowScreen workflows.
* **Primary user goal**: Configure process tasks, track live workflow execution states, and review failed process blocks.
* **Expected user actions**: Edit task list nodes, restart failed workflow execution, sign off on completed steps.
* **Business reason**: Operational automation and validation of process steps.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### TrainingDirectorAnalyticsScreen

* **Route**: `/offices/corporate/roles/training_director/analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/training_director_analytics_screen.dart`
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
* **Business Workflow Score**: 0
* **Role Expectation Score**: 0
* **Missing Business Features**: course, certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### TrainingDirectorComplianceScreen

* **Route**: `/executive/training-director-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/training_director_compliance_screen.dart`
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
* **Missing Business Features**: course, certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### TrainingDirectorWorkflowScreen

* **Route**: `/executive/training-director-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/executive/training_director_workflow_screen.dart`
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
* **Missing Business Features**: course, certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Training Director Assessments

* **Route**: `/offices/corporate/roles/training_director/assessments`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_assessments_screen.dart`
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
* **Missing Business Features**: course, certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: course, certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Certificates

* **Route**: `/offices/corporate/roles/training_director/certificates`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_certificates_screen.dart`
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
* **Missing Business Features**: certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Certifications

* **Route**: `/offices/corporate/roles/training_director/certifications`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_certifications_screen.dart`
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
* **Missing Business Features**: course, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: course, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Compliance Training

* **Route**: `/offices/corporate/roles/training_director/compliance-training`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_compliance_training_screen.dart`
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
* **Missing Business Features**: certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Course Architect

* **Route**: `/offices/corporate/roles/training_director/course-architect`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_course_architect_screen.dart`
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
* **Missing Business Features**: certification, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: certification, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Course Library

* **Route**: `/offices/corporate/roles/training_director/course-library`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_course_library_screen.dart`
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
* **Missing Business Features**: certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Hub

* **Route**: `/offices/corporate/roles/training_director/hub`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_hub_screen.dart`
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
* **Missing Business Features**: certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Reports

* **Route**: `/offices/corporate/roles/training_director/reports`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_reports_screen.dart`
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
* **Missing Business Features**: course, certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: course, certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Staff Training Matrix

* **Route**: `/offices/corporate/roles/training_director/staff-training-matrix`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_staff_training_matrix_screen.dart`
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
* **Missing Business Features**: certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Trainer Assignments

* **Route**: `/offices/corporate/roles/training_director/trainer-assignments`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_trainer_assignments_screen.dart`
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
* **Missing Business Features**: certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Training Director Training Programs

* **Route**: `/offices/corporate/roles/training_director/training-programs`
* **Component file**: `apps/primecare_corporate/lib/features/generated_screens/training_director_training_programs_screen.dart`
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
* **Missing Business Features**: course, certification, curriculum, instructor, validation
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: course, certification, curriculum, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

### Course Architect

* **Route**: `/generated/course-architect`
* **Component file**: `apps/primecare_corporate/lib/features/training/screens/course_architect_screen.dart`
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
* **Missing Business Features**: certification, instructor, validation
* **Purpose**: Management workspace screen for Course Architect module access.
* **Primary user goal**: Review system records and coordinate day-to-day administrative functions.
* **Expected user actions**: Filter records, view items list, click item detail card, click edit/update buttons.
* **Business reason**: Supports general administrative oversight and recordkeeping.
* **Missing items**: Missing core role features: certification, instructor, validation
* **Next action**: Implement expected workflows for training_director role.

## Screens to Fix First

1. **Training Director Assessments** (Progress: 0%, Business Score: 7, Role Score: 0)  
   *Reason*: Missing core workflows/features: course, certification, curriculum, instructor, validation
2. **Training Director Certificates** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: certification, curriculum, instructor, validation
3. **Training Director Certifications** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: course, curriculum, instructor, validation
4. **Training Director Compliance Training** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: certification, curriculum, instructor, validation
5. **Training Director Course Architect** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: certification, instructor, validation
6. **Training Director Course Library** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: certification, curriculum, instructor, validation
7. **Training Director Hub** (Progress: 0%, Business Score: 8, Role Score: 1)  
   *Reason*: Missing core workflows/features: certification, curriculum, instructor, validation
8. **Training Director Reports** (Progress: 0%, Business Score: 7, Role Score: 0)  
   *Reason*: Missing core workflows/features: course, certification, curriculum, instructor, validation
9. **Training Director Staff Training Matrix** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: certification, curriculum, instructor, validation
10. **Training Director Trainer Assignments** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: certification, curriculum, instructor, validation

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Training Director Assessments (Implement role-specific workflows and transactional features)
- Training Director Certificates (Implement role-specific workflows and transactional features)
- Training Director Certifications (Implement role-specific workflows and transactional features)
- Training Director Compliance Training (Implement role-specific workflows and transactional features)
- Training Director Course Architect (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
