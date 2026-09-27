# Shift Supervisor

## Role Summary

* **Role key**: `scheduler`
* **Role category**: `franchise`
* **Total screens**: 20
* **Business ready screens**: 9
* **Incomplete screens**: 20
* **False progress screens**: 0
* **Zero Screen-Body Interaction screens**: 0
* **Average progress**: 27.5%
* **Average screen-body interactions**: 5.8

## Screen List

| Screen Name | Route Path | Body Interactions | Global Nav | Status | Business Score | Role Score | Missing Business Features | Business Ready |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SchedulerDashboardScreen | `/offices/franchise/roles/scheduler/dashboard` | 4 | 1 | `MEANINGFUL` | 6 | 3 | scheduling, calendar, availability | **Yes** |
| SchedulerAnalyticsScreen | `/staff/scheduler-analytics` | 3 | 0 | `MEANINGFUL` | 5 | 1 | scheduling, calendar, conflict, availability, provider | **No** |
| SchedulerWorkflowScreen | `/staff/scheduler-workflow` | 3 | 0 | `MEANINGFUL` | 4 | 1 | calendar, shift, conflict, availability, provider | **No** |
| SchedulerCommandCenterScreen | `/staff/scheduler-command-center` | 4 | 1 | `MEANINGFUL` | 6 | 2 | calendar, shift, conflict, availability | **No** |
| SchedulerCalendarScreen | `/staff/scheduler-calendar` | 4 | 1 | `MEANINGFUL` | 5 | 2 | scheduling, shift, conflict, availability | **No** |
| SchedulerBookingRequestsScreen | `/staff/scheduler-booking-requests` | 4 | 1 | `MEANINGFUL` | 6 | 1 | scheduling, calendar, shift, conflict, availability | **No** |
| SchedulerConflictsScreen | `/staff/scheduler-conflicts` | 4 | 1 | `MEANINGFUL` | 4 | 3 | calendar, shift, availability | **Yes** |
| SchedulerOpenShiftsScreen | `/staff/scheduler-open-shifts` | 4 | 1 | `MEANINGFUL` | 4 | 3 | calendar, conflict, availability | **Yes** |
| SchedulerProviderAvailabilityScreen | `/staff/scheduler-provider-availability` | 4 | 1 | `MEANINGFUL` | 4 | 2 | scheduling, calendar, shift, conflict | **No** |
| Scheduler Coordinator Appointment Calendar | `/offices/franchise/roles/scheduler_coordinator/appointment-calendar` | 8 | 6 | `MEANINGFUL` | 7 | 2 | scheduling, shift, conflict, availability | **No** |
| Scheduler Coordinator Assignments | `/offices/franchise/roles/scheduler_coordinator/assignments` | 8 | 6 | `MEANINGFUL` | 7 | 2 | scheduling, calendar, conflict, availability | **No** |
| Scheduler Coordinator Booking Requests | `/offices/franchise/roles/scheduler_coordinator/booking-requests` | 8 | 6 | `MEANINGFUL` | 9 | 1 | scheduling, calendar, shift, conflict, availability | **No** |
| Scheduler Coordinator Conflicts | `/offices/franchise/roles/scheduler_coordinator/conflicts` | 8 | 6 | `MEANINGFUL` | 7 | 4 | scheduling, calendar | **Yes** |
| Scheduler Coordinator Open Shifts | `/offices/franchise/roles/scheduler_coordinator/open-shifts` | 8 | 6 | `MEANINGFUL` | 7 | 3 | scheduling, calendar, availability | **Yes** |
| Scheduler Coordinator Provider Availability | `/offices/franchise/roles/scheduler_coordinator/provider-availability` | 8 | 6 | `MEANINGFUL` | 8 | 3 | scheduling, calendar, conflict | **Yes** |
| Scheduler Coordinator Reports | `/offices/franchise/roles/scheduler_coordinator/reports` | 8 | 6 | `MEANINGFUL` | 10 | 2 | scheduling, calendar, conflict, availability | **No** |
| Scheduler Coordinator Shift Calendar | `/offices/franchise/roles/scheduler_coordinator/shift-calendar` | 8 | 6 | `MEANINGFUL` | 7 | 4 | scheduling, conflict | **Yes** |
| Simulation Lab Scheduler | `/generated/simulation-lab-scheduler` | 3 | 2 | `MEANINGFUL` | 2 | 2 | scheduling, calendar, shift, conflict | **No** |
| Scheduler Availability | `/generated/scheduler-availability` | 8 | 6 | `MEANINGFUL` | 8 | 4 | conflict, provider | **Yes** |
| Scheduler Shifts | `/generated/scheduler-shifts` | 8 | 6 | `MEANINGFUL` | 7 | 3 | scheduling, availability, provider | **Yes** |

## Screen Details

### SchedulerDashboardScreen

* **Route**: `/offices/franchise/roles/scheduler/dashboard`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_dashboard_screen.dart`
* **Current stage**: Stage 5
* **Progress %**: 50%
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
* **Business Workflow Score**: 6
* **Role Expectation Score**: 3
* **Missing Business Features**: scheduling, calendar, availability
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: None
* **Next action**: None

### SchedulerAnalyticsScreen

* **Route**: `/staff/scheduler-analytics`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_analytics_screen.dart`
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 1
* **Missing Business Features**: scheduling, calendar, conflict, availability, provider
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: scheduling, calendar, conflict, availability, provider
* **Next action**: Implement expected workflows for scheduler role.

### SchedulerWorkflowScreen

* **Route**: `/staff/scheduler-workflow`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_workflow_screen.dart`
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
* **Missing Business Features**: calendar, shift, conflict, availability, provider
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: calendar, shift, conflict, availability, provider
* **Next action**: Implement expected workflows for scheduler role.

### SchedulerCommandCenterScreen

* **Route**: `/staff/scheduler-command-center`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_command_center_screen.dart`
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
* **Business Workflow Score**: 6
* **Role Expectation Score**: 2
* **Missing Business Features**: calendar, shift, conflict, availability
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: calendar, shift, conflict, availability
* **Next action**: Implement expected workflows for scheduler role.

### SchedulerCalendarScreen

* **Route**: `/staff/scheduler-calendar`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_calendar_screen.dart`
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
* **Business Workflow Score**: 5
* **Role Expectation Score**: 2
* **Missing Business Features**: scheduling, shift, conflict, availability
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: scheduling, shift, conflict, availability
* **Next action**: Implement expected workflows for scheduler role.

### SchedulerBookingRequestsScreen

* **Route**: `/staff/scheduler-booking-requests`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_booking_requests_screen.dart`
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
* **Business Workflow Score**: 6
* **Role Expectation Score**: 1
* **Missing Business Features**: scheduling, calendar, shift, conflict, availability
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: scheduling, calendar, shift, conflict, availability
* **Next action**: Implement expected workflows for scheduler role.

### SchedulerConflictsScreen

* **Route**: `/staff/scheduler-conflicts`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_conflicts_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 3
* **Missing Business Features**: calendar, shift, availability
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: None
* **Next action**: None

### SchedulerOpenShiftsScreen

* **Route**: `/staff/scheduler-open-shifts`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_open_shifts_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 3
* **Missing Business Features**: calendar, conflict, availability
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: None
* **Next action**: None

### SchedulerProviderAvailabilityScreen

* **Route**: `/staff/scheduler-provider-availability`
* **Component file**: `packages/primecare_ui/lib/src/screens/staff/scheduler_provider_availability_screen.dart`
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
* **Business Workflow Score**: 4
* **Role Expectation Score**: 2
* **Missing Business Features**: scheduling, calendar, shift, conflict
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: scheduling, calendar, shift, conflict
* **Next action**: Implement expected workflows for scheduler role.

### Scheduler Coordinator Appointment Calendar

* **Route**: `/offices/franchise/roles/scheduler_coordinator/appointment-calendar`
* **Component file**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_appointment_calendar_screen.dart`
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
* **Missing Business Features**: scheduling, shift, conflict, availability
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: scheduling, shift, conflict, availability
* **Next action**: Implement expected workflows for scheduler role.

### Scheduler Coordinator Assignments

* **Route**: `/offices/franchise/roles/scheduler_coordinator/assignments`
* **Component file**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_assignments_screen.dart`
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
* **Missing Business Features**: scheduling, calendar, conflict, availability
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: scheduling, calendar, conflict, availability
* **Next action**: Implement expected workflows for scheduler role.

### Scheduler Coordinator Booking Requests

* **Route**: `/offices/franchise/roles/scheduler_coordinator/booking-requests`
* **Component file**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_booking_requests_screen.dart`
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
* **Missing Business Features**: scheduling, calendar, shift, conflict, availability
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: scheduling, calendar, shift, conflict, availability
* **Next action**: Implement expected workflows for scheduler role.

### Scheduler Coordinator Conflicts

* **Route**: `/offices/franchise/roles/scheduler_coordinator/conflicts`
* **Component file**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_conflicts_screen.dart`
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
* **Role Expectation Score**: 4
* **Missing Business Features**: scheduling, calendar
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: None
* **Next action**: None

### Scheduler Coordinator Open Shifts

* **Route**: `/offices/franchise/roles/scheduler_coordinator/open-shifts`
* **Component file**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_open_shifts_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: scheduling, calendar, availability
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: None
* **Next action**: None

### Scheduler Coordinator Provider Availability

* **Route**: `/offices/franchise/roles/scheduler_coordinator/provider-availability`
* **Component file**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_provider_availability_screen.dart`
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
* **Business Workflow Score**: 8
* **Role Expectation Score**: 3
* **Missing Business Features**: scheduling, calendar, conflict
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: None
* **Next action**: None

### Scheduler Coordinator Reports

* **Route**: `/offices/franchise/roles/scheduler_coordinator/reports`
* **Component file**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_reports_screen.dart`
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
* **Business Workflow Score**: 10
* **Role Expectation Score**: 2
* **Missing Business Features**: scheduling, calendar, conflict, availability
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: Missing core role features: scheduling, calendar, conflict, availability
* **Next action**: Implement expected workflows for scheduler role.

### Scheduler Coordinator Shift Calendar

* **Route**: `/offices/franchise/roles/scheduler_coordinator/shift-calendar`
* **Component file**: `apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_shift_calendar_screen.dart`
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
* **Role Expectation Score**: 4
* **Missing Business Features**: scheduling, conflict
* **Purpose**: Chief Operations Officer command center for monitoring clinic operations, branch comparisons, and staffing health.
* **Primary user goal**: Oversee operational KPIs, compare performance across branches, and manage staff escalations.
* **Expected user actions**: Filter branch comparative metrics, view scheduling health graphs, open operational escalations.
* **Business reason**: Enables executive oversight of clinical logistics, staffing efficiency, and branch performance.
* **Missing items**: None
* **Next action**: None

### Simulation Lab Scheduler

* **Route**: `/generated/simulation-lab-scheduler`
* **Component file**: `packages/primecare_ui/lib/src/features/education/simulation_lab_scheduler.dart`
* **Current stage**: Stage 6
* **Progress %**: 60%
* **Visual status**: `INTERACTIVE`
* **Business ready**: `No`
* **Meaningful Interaction Status**: `MEANINGFUL`
* **Screen Body Interactions**: 3
  * **Buttons**: 1
  * **Forms**: 0
  * **Filters**: 0
  * **Table Actions**: 1
  * **Clickable Cards**: 1
* **Global Navigation Count**: 2
* **Business Workflow Score**: 2
* **Role Expectation Score**: 2
* **Missing Business Features**: scheduling, calendar, shift, conflict
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: Missing core role features: scheduling, calendar, shift, conflict
* **Next action**: Implement expected workflows for scheduler role.

### Scheduler Availability

* **Route**: `/generated/scheduler-availability`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/scheduler_availability_screen.dart`
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
* **Business Workflow Score**: 8
* **Role Expectation Score**: 4
* **Missing Business Features**: conflict, provider
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: None
* **Next action**: None

### Scheduler Shifts

* **Route**: `/generated/scheduler-shifts`
* **Component file**: `packages/primecare_ui/lib/src/features/generated_screens/scheduler_shifts_screen.dart`
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
* **Role Expectation Score**: 3
* **Missing Business Features**: scheduling, availability, provider
* **Purpose**: Scheduling administrator workspace to resolve booking conflicts, open shifts, and provider availability.
* **Primary user goal**: Ensure all client shifts are filled, resolve calendar conflicts, and approve booking requests.
* **Expected user actions**: Drag and drop shift blocks, click conflict resolver, approve shift request, notify provider.
* **Business reason**: Core logistics system mapping patient needs to caregiver resources efficiently.
* **Missing items**: None
* **Next action**: None

## Screens to Fix First

1. **Scheduler Coordinator Appointment Calendar** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: scheduling, shift, conflict, availability
2. **Scheduler Coordinator Assignments** (Progress: 0%, Business Score: 7, Role Score: 2)  
   *Reason*: Missing core workflows/features: scheduling, calendar, conflict, availability
3. **Scheduler Coordinator Booking Requests** (Progress: 0%, Business Score: 9, Role Score: 1)  
   *Reason*: Missing core workflows/features: scheduling, calendar, shift, conflict, availability
4. **Scheduler Coordinator Reports** (Progress: 0%, Business Score: 10, Role Score: 2)  
   *Reason*: Missing core workflows/features: scheduling, calendar, conflict, availability
5. **SchedulerAnalyticsScreen** (Progress: 40%, Business Score: 5, Role Score: 1)  
   *Reason*: Missing core workflows/features: scheduling, calendar, conflict, availability, provider
6. **SchedulerWorkflowScreen** (Progress: 40%, Business Score: 4, Role Score: 1)  
   *Reason*: Missing core workflows/features: calendar, shift, conflict, availability, provider
7. **SchedulerCommandCenterScreen** (Progress: 60%, Business Score: 6, Role Score: 2)  
   *Reason*: Missing core workflows/features: calendar, shift, conflict, availability
8. **SchedulerCalendarScreen** (Progress: 60%, Business Score: 5, Role Score: 2)  
   *Reason*: Missing core workflows/features: scheduling, shift, conflict, availability
9. **SchedulerBookingRequestsScreen** (Progress: 60%, Business Score: 6, Role Score: 1)  
   *Reason*: Missing core workflows/features: scheduling, calendar, shift, conflict, availability
10. **SchedulerProviderAvailabilityScreen** (Progress: 60%, Business Score: 4, Role Score: 2)  
   *Reason*: Missing core workflows/features: scheduling, calendar, shift, conflict

## Recommended Build Order

### 1. Must Fix Now (High Priority)
- Scheduler Coordinator Appointment Calendar (Implement role-specific workflows and transactional features)
- Scheduler Coordinator Assignments (Implement role-specific workflows and transactional features)
- Scheduler Coordinator Booking Requests (Implement role-specific workflows and transactional features)
- Scheduler Coordinator Reports (Implement role-specific workflows and transactional features)
- SchedulerAnalyticsScreen (Implement role-specific workflows and transactional features)

### 2. Fix Next (Medium Priority)
- None (All screens are functionally complete)

### 3. Polish Later (Low Priority)
- Scheduler Coordinator Conflicts (Micro-interactions and design alignment polish)
- Scheduler Coordinator Open Shifts (Micro-interactions and design alignment polish)
- Scheduler Coordinator Provider Availability (Micro-interactions and design alignment polish)
- Scheduler Coordinator Shift Calendar (Micro-interactions and design alignment polish)
- Scheduler Availability (Micro-interactions and design alignment polish)

### 4. Consider Merging / Deleting
- None (Zero duplicate screens identified)
