# Volunteer Coordinator

## Role Summary

* **Role key**: `volunteer_coordinator`
* **Role category**: `corporate`
* **Total screens**: 4
* **Business ready screens**: 0
* **Incomplete screens**: 4
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 45.0%
* **Average screen-body interactions**: 3.5

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| VolunteerCoordinatorDashboardScreen | `/offices/corporate/roles/volunteer_coordinator/dashboard` | 4 | 1 | `MEANINGFUL` | 5 | 1 | schedule, project, recruitment | **No** |
| VolunteerCoordinatorAnalyticsScreen | `/staff/volunteer-coordinator-analytics` | 3 | 0 | `MEANINGFUL` | 4 | 1 | schedule, project, recruitment | **No** |
| VolunteerCoordinatorComplianceScreen | `/staff/volunteer-coordinator-compliance` | 4 | 1 | `MEANINGFUL` | 4 | 1 | schedule, project, recruitment | **No** |
| VolunteerCoordinatorWorkflowScreen | `/staff/volunteer-coordinator-workflow` | 3 | 0 | `MEANINGFUL` | 2 | 1 | schedule, project, recruitment | **No** |

## Screen Details

### VolunteerCoordinatorDashboardScreen

* **Route**: `/offices/corporate/roles/volunteer_coordinator/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_dashboard_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: schedule, project, recruitment
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: schedule, project, recruitment
* **Next action**: Implement expected workflows for volunteer_coordinator role.

### VolunteerCoordinatorAnalyticsScreen

* **Route**: `/staff/volunteer-coordinator-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_analytics_screen.dart`
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
* **Role Expectation Score**: 1
* **Missing Business Features**: schedule, project, recruitment
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: schedule, project, recruitment
* **Next action**: Implement expected workflows for volunteer_coordinator role.

### VolunteerCoordinatorComplianceScreen

* **Route**: `/staff/volunteer-coordinator-compliance`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_compliance_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 1
* **Missing Business Features**: schedule, project, recruitment
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: schedule, project, recruitment
* **Next action**: Implement expected workflows for volunteer_coordinator role.

### VolunteerCoordinatorWorkflowScreen

* **Route**: `/staff/volunteer-coordinator-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/volunteer_coordinator_workflow_screen.dart`
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
* **Business Workflow Score**: 2
* **Role Expectation Score**: 1
* **Missing Business Features**: schedule, project, recruitment
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: schedule, project, recruitment
* **Next action**: Implement expected workflows for volunteer_coordinator role.

## Screens to Fix First

1. **VolunteerCoordinatorAnalyticsScreen** (Progress: 40%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: schedule, project, recruitment
2. **VolunteerCoordinatorWorkflowScreen** (Progress: 40%, Business Score: 2, Role Score: 1)  
   *Reason*: Missing core workflows/features: schedule, project, recruitment
3. **VolunteerCoordinatorDashboardScreen** (Progress: 50%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: schedule, project, recruitment
4. **VolunteerCoordinatorComplianceScreen** (Progress: 50%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: schedule, project, recruitment

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- VolunteerCoordinatorAnalyticsScreen (Implement role-specific workflows and transactional features)
- VolunteerCoordinatorWorkflowScreen (Implement role-specific workflows and transactional features)
- VolunteerCoordinatorDashboardScreen (Implement role-specific workflows and transactional features)
- VolunteerCoordinatorComplianceScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- None (All screens fully completed and polished)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
