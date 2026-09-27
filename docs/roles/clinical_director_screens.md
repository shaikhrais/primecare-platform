# Clinical Director

## Role Summary

* **Role key**: `clinical_director`
* **Role category**: `clinical`
* **Total screens**: 22
* **Business ready screens**: 13
* **Incomplete screens**: 22
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 46.4%
* **Average screen-body interactions**: 2.8

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| ClinicalDashboardScreen | `/offices/clinical/roles/clinical_director/dashboard-dup-1` | 6 | 4 | `MEANINGFUL` | 5 | 1 | audit, incident, staff, training, policy, credential | **No** |
| ClinicDashboardScreen | `/offices/clinical/roles/clinical_director/clinic-dashboard` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | incident, training, credential | **Yes** |
| ClinicalAnalyticsScreen | `/offices/clinical/roles/clinical_director/analytics` | 2 | 0 | `LOW_INTERACTION` | 3 | 3 | audit, incident, policy, credential | **No** |
| ClinicalComplianceScreen | `/offices/clinical/roles/clinical_director/compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | incident, staff, credential | **Yes** |
| ClinicalWorkflowScreen | `/offices/clinical/roles/clinical_director/workflow` | 2 | 0 | `LOW_INTERACTION` | 3 | 4 | audit, incident, credential | **Yes** |
| ClinicAnalyticsScreen | `/offices/clinical/roles/clinical_director/clinic-analytics` | 2 | 0 | `LOW_INTERACTION` | 4 | 1 | audit, compliance, incident, staff, policy, credential | **No** |
| ClinicComplianceScreen | `/offices/clinical/roles/clinical_director/clinic-compliance` | 2 | 1 | `LOW_INTERACTION` | 5 | 5 | incident, credential | **Yes** |
| ClinicWorkflowScreen | `/offices/clinical/roles/clinical_director/clinic-workflow` | 2 | 0 | `LOW_INTERACTION` | 3 | 2 | audit, incident, training, policy, credential | **No** |
| ClinicalDirectorStaffQualityScreen | `/offices/clinical/roles/clinical_director/staff-quality` | 2 | 1 | `LOW_INTERACTION` | 3 | 5 | policy, credential | **Yes** |
| ClinicalDirectorIncidentReviewScreen | `/offices/clinical/roles/clinical_director/incident-review` | 2 | 1 | `LOW_INTERACTION` | 3 | 5 | policy, credential | **Yes** |
| ClinicalDirectorComplianceScreen | `/offices/clinical/roles/clinical_director/compliance-director` | 2 | 1 | `LOW_INTERACTION` | 4 | 4 | incident, policy, credential | **Yes** |
| ClinicalDirectorReportsScreen | `/offices/clinical/roles/clinical_director/reports` | 2 | 1 | `LOW_INTERACTION` | 4 | 4 | incident, policy, credential | **Yes** |
| ClinicalDirectorApprovalsScreen | `/offices/clinical/roles/clinical_director/approvals` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | incident, training, policy, credential | **No** |
| ClinicalDirectorPerformanceScreen | `/offices/clinical/roles/clinical_director/performance` | 2 | 1 | `LOW_INTERACTION` | 3 | 3 | incident, training, policy, credential | **No** |
| ClinicalQualityScreen | `/offices/clinical/roles/clinical_director/quality` | 2 | 1 | `LOW_INTERACTION` | 4 | 3 | incident, training, policy, credential | **No** |
| StaffPerformanceScreen | `/offices/clinical/roles/clinical_director/staff-performance` | 2 | 1 | `LOW_INTERACTION` | 3 | 5 | policy, credential | **Yes** |
| ComplianceReviewScreen | `/offices/clinical/roles/clinical_director/compliance-review` | 2 | 1 | `LOW_INTERACTION` | 5 | 4 | staff, policy, credential | **Yes** |
| IncidentOversightScreen | `/offices/clinical/roles/clinical_director/incident-oversight` | 2 | 1 | `LOW_INTERACTION` | 4 | 4 | staff, policy, credential | **Yes** |
| ClinicalOperations4KScreen | `/offices/clinical/roles/clinical_director/operations4k` | 2 | 1 | `LOW_INTERACTION` | 3 | 5 | policy, credential | **Yes** |
| Clinical Director Dashboard | `/offices/clinical/roles/clinical_director/dashboard` | 4 | 1 | `MEANINGFUL` | 3 | 3 | incident, staff, training, policy | **No** |
| Clinical Director Quality Metrics | `/generated/clinical-director-quality-metrics` | 8 | 6 | `MEANINGFUL` | 7 | 5 | training, policy | **Yes** |
| Clinical Director Staffing | `/generated/clinical-director-staffing` | 8 | 6 | `MEANINGFUL` | 7 | 1 | audit, compliance, incident, training, policy, credential | **No** |

## Screen Details

### ClinicalDashboardScreen

* **Route**: `/offices/clinical/roles/clinical_director/dashboard-dup-1`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/clinical_dashboard.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 6
  * **Buttons**: 5
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 4
* **Business Workflow Score**: 5
* **Role Expectation Score**: 1
* **Missing Business Features**: audit, incident, staff, training, policy, credential
* **Purpose**: Duplicate screen copy for ClinicalDashboardScreen. Created during route split or template duplication.
* **Primary user goal**: Re-route or consolidate user traffic back to the primary screen.
* **Expected user actions**: None. Consolidated into main dashboard.
* **Business reason**: Redundant route node; duplicate of main feature screen.
* **Missing items**: Missing core role features: audit, incident, staff, training, policy, credential
* **Next action**: Implement expected workflows for clinical_director role.

### ClinicDashboardScreen

* **Route**: `/offices/clinical/roles/clinical_director/clinic-dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/clinic_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Missing Business Features**: incident, training, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalAnalyticsScreen

* **Route**: `/offices/clinical/roles/clinical_director/analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_analytics_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: audit, incident, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalComplianceScreen

* **Route**: `/offices/clinical/roles/clinical_director/compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Missing Business Features**: incident, staff, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalWorkflowScreen

* **Route**: `/offices/clinical/roles/clinical_director/workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_workflow_screen.dart`
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
* **Role Expectation Score**: 4
* **Missing Business Features**: audit, incident, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicAnalyticsScreen

* **Route**: `/offices/clinical/roles/clinical_director/clinic-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/clinic_analytics_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: audit, compliance, incident, staff, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicComplianceScreen

* **Route**: `/offices/clinical/roles/clinical_director/clinic-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/clinic_compliance_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Role Expectation Score**: 5
* **Missing Business Features**: incident, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicWorkflowScreen

* **Route**: `/offices/clinical/roles/clinical_director/clinic-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/common/clinic_workflow_screen.dart`
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
* **Role Expectation Score**: 2
* **Missing Business Features**: audit, incident, training, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalDirectorStaffQualityScreen

* **Route**: `/offices/clinical/roles/clinical_director/staff-quality`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_staff_quality_screen.dart`
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
* **Role Expectation Score**: 5
* **Missing Business Features**: policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalDirectorIncidentReviewScreen

* **Route**: `/offices/clinical/roles/clinical_director/incident-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_incident_review_screen.dart`
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
* **Role Expectation Score**: 5
* **Missing Business Features**: policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalDirectorComplianceScreen

* **Route**: `/offices/clinical/roles/clinical_director/compliance-director`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_compliance_screen.dart`
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
* **Role Expectation Score**: 4
* **Missing Business Features**: incident, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalDirectorReportsScreen

* **Route**: `/offices/clinical/roles/clinical_director/reports`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_reports_screen.dart`
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
* **Role Expectation Score**: 4
* **Missing Business Features**: incident, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalDirectorApprovalsScreen

* **Route**: `/offices/clinical/roles/clinical_director/approvals`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_approvals_screen.dart`
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
* **Missing Business Features**: incident, training, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalDirectorPerformanceScreen

* **Route**: `/offices/clinical/roles/clinical_director/performance`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_director_performance_screen.dart`
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
* **Missing Business Features**: incident, training, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalQualityScreen

* **Route**: `/offices/clinical/roles/clinical_director/quality`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_quality_screen.dart`
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
* **Missing Business Features**: incident, training, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### StaffPerformanceScreen

* **Route**: `/offices/clinical/roles/clinical_director/staff-performance`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/staff_performance_screen.dart`
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
* **Role Expectation Score**: 5
* **Missing Business Features**: policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ComplianceReviewScreen

* **Route**: `/offices/clinical/roles/clinical_director/compliance-review`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/compliance_review_screen.dart`
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
* **Missing Business Features**: staff, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### IncidentOversightScreen

* **Route**: `/offices/clinical/roles/clinical_director/incident-oversight`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/incident_oversight_screen.dart`
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
* **Role Expectation Score**: 4
* **Missing Business Features**: staff, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### ClinicalOperations4KScreen

* **Route**: `/offices/clinical/roles/clinical_director/operations4k`
* **Component file**: `packages/primecare_ui/lib/src/screens/clinical/clinical_operations4_k_screen.dart`
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
* **Role Expectation Score**: 5
* **Missing Business Features**: policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Low interaction count in body. Verify user action density.
* **Next action**: Increase actionable widgets.

### Clinical Director Dashboard

* **Route**: `/offices/clinical/roles/clinical_director/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/clinical_director_dashboard.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 4
  * **Buttons**: 1
  * **Forms**: 1
  * **Filters**: 0
  * **Table Actions**: 1
  * **Clickable Cards**: 1
* **Global Navigation Count**: 1
* **Business Workflow Score**: 3
* **Role Expectation Score**: 3
* **Missing Business Features**: incident, staff, training, policy
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: incident, staff, training, policy
* **Next action**: Implement expected workflows for clinical_director role.

### Clinical Director Quality Metrics

* **Route**: `/generated/clinical-director-quality-metrics`
* **Component file**: `apps/primecare_clinic/lib/features/generated_screens/clinical_director_quality_metrics_screen.dart`
* **Current stage**: Stage 0
* **Progress %**: 0%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `Yes`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 8
  * **Buttons**: 4
  * **Forms**: 3
  * **Filters**: 1
  * **Table Actions**: 0
  * **Clickable Cards**: 0
* **Global Navigation Count**: 6
* **Business Workflow Score**: 7
* **Role Expectation Score**: 5
* **Missing Business Features**: training, policy
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: None
* **Next action**: None

### Clinical Director Staffing

* **Route**: `/generated/clinical-director-staffing`
* **Component file**: `apps/primecare_clinic/lib/features/generated_screens/clinical_director_staffing_screen.dart`
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
* **Missing Business Features**: audit, compliance, incident, training, policy, credential
* **Purpose**: Chief Technology Officer hub to track system health, API response telemetry, and release cycles.
* **Primary user goal**: Monitor system uptime, review security logs, and inspect continuous integration/deployment runs.
* **Expected user actions**: Refresh uptime chart, view API response latency log, trigger system deployment rollbacks.
* **Business reason**: Protects system availability, technical performance monitoring, and secure software distribution.
* **Missing items**: Missing core role features: audit, compliance, incident, training, policy, credential
* **Next action**: Implement expected workflows for clinical_director role.

## Screens to Fix First

1. **ClinicalDashboardScreen** (Progress: 0%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: audit, incident, staff, training, policy, credential
2. **Clinical Director Staffing** (Progress: 0%, Business Score: 7, Role Score: 1)  
   *Reason*: Missing core workflows/features: audit, compliance, incident, training, policy, credential
3. **ClinicalAnalyticsScreen** (Progress: 40%, Business Score: 3, Role Score: 3)  
   *Reason*: Missing core workflows/features: audit, incident, policy, credential
4. **ClinicAnalyticsScreen** (Progress: 40%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: audit, compliance, incident, staff, policy, credential
5. **ClinicWorkflowScreen** (Progress: 40%, Business Score: 3, Role Score: 2)  
   *Reason*: Missing core workflows/features: audit, incident, training, policy, credential
6. **Clinical Director Dashboard** (Progress: 50%, Business Score: 3, Role Score: 3)  
   *Reason*: Missing core workflows/features: incident, staff, training, policy
7. **ClinicalDirectorApprovalsScreen** (Progress: 60%, Business Score: 4, Role Score: 3)  
   *Reason*: Missing core workflows/features: incident, training, policy, credential
8. **ClinicalDirectorPerformanceScreen** (Progress: 60%, Business Score: 3, Role Score: 3)  
   *Reason*: Missing core workflows/features: incident, training, policy, credential
9. **ClinicalQualityScreen** (Progress: 60%, Business Score: 4, Role Score: 3)  
   *Reason*: Missing core workflows/features: incident, training, policy, credential

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- ClinicalDashboardScreen (Implement role-specific workflows and transactional features)
- Clinical Director Staffing (Implement role-specific workflows and transactional features)
- ClinicalAnalyticsScreen (Implement role-specific workflows and transactional features)
- ClinicAnalyticsScreen (Implement role-specific workflows and transactional features)
- ClinicWorkflowScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Clinical Director Quality Metrics (Micro-interactions and design alignment polish)
- ClinicalWorkflowScreen (Micro-interactions and design alignment polish)
- ClinicDashboardScreen (Micro-interactions and design alignment polish)
- ClinicalComplianceScreen (Micro-interactions and design alignment polish)
- ClinicComplianceScreen (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- ClinicalDashboardScreen (Consolidate redundant route split entries)
