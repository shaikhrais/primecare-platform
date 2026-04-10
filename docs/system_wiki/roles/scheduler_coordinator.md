# Role: Scheduler Coordinator
**Office:** [Franchise Administration](../offices/franchise.md)  
**Authority Level:** Level 2 (Active)

## Operational Summary
Assigning caregivers, managing shift overlaps and conflicts.

## Accessible Screens & Tasks

| Screen ID | Verified Component | Implementation Status | Core Operation / Task |
| :--- | :--- | :--- | :--- |
| **FRA-803** | `SchedulerDashboard` | ✅ Implemented | High-velocity overview of unfilled shifts, incoming bookings, and bottlenecks. |
| **FRA-822** | `SchedulerCoordinatorAppointmentCalendarScreen` | ✅ Implemented | Visual calendar interface for mapping clinical capacities per day/week. |
| **FRA-823** | `SchedulerCoordinatorShiftCalendarScreen` | ✅ Implemented | View and distribute blocks of generic shifts to specific geographic zones. |
| **FRA-824** | `SchedulerCoordinatorProviderAvailabilityScreen` | ✅ Implemented | Analyze Nurse and PSW blackout dates, vacation requests, and max capacities. |
| **FRA-825** | `SchedulerCoordinatorBookingRequestsScreen` | ✅ Implemented | Triage incoming booking requests originating from the Client portal. |
| **FRA-826** | `SchedulerCoordinatorOpenShiftsScreen` | ✅ Implemented | Broadcast unassigned shifts individually or en masse to eligible staff. |
| **FRA-827** | `SchedulerCoordinatorAssignmentsScreen` | ✅ Implemented | Finalize mapping of a specific clinical staff member to a patient ticket. |
| **FRA-828** | `SchedulerCoordinatorConflictsScreen` | ✅ Implemented | Auto-detect and resolve double-bookings or overtime threshold violations. |
| **COR-768** | `SchedulerCoordinatorReportsScreen` | ✅ Implemented | Generate analytics detailing fulfillment rates and scheduling velocity. |
