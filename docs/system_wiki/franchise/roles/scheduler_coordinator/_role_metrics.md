# Role: Scheduler Coordinator
**Office:** [Franchise Administration](../../_overview.md)  
**Authority Level:** Level 2 (Active)

## Operational Summary
Assigning caregivers, managing shift overlaps and conflicts.

## Accessible Screens & Tasks

| Screen ID | Verified Component | Implementation Status | Core Operation / Task |
| :--- | :--- | :--- | :--- |
| [**FRA-803**](screens/fra_803/_screen_details.md) | `SchedulerDashboard` | ✅ Implemented | High-velocity overview of unfilled shifts, incoming bookings, and bottlenecks. |
| [**FRA-822**](screens/fra_822/_screen_details.md) | `SchedulerCoordinatorAppointmentCalendarScreen` | ✅ Implemented | Visual calendar interface for mapping clinical capacities per day/week. |
| [**FRA-823**](screens/fra_823/_screen_details.md) | `SchedulerCoordinatorShiftCalendarScreen` | ✅ Implemented | View and distribute blocks of generic shifts to specific geographic zones. |
| [**FRA-824**](screens/fra_824/_screen_details.md) | `SchedulerCoordinatorProviderAvailabilityScreen` | ✅ Implemented | Analyze Nurse and PSW blackout dates, vacation requests, and max capacities. |
| [**FRA-825**](screens/fra_825/_screen_details.md) | `SchedulerCoordinatorBookingRequestsScreen` | ✅ Implemented | Triage incoming booking requests originating from the Client portal. |
| [**FRA-826**](screens/fra_826/_screen_details.md) | `SchedulerCoordinatorOpenShiftsScreen` | ✅ Implemented | Broadcast unassigned shifts individually or en masse to eligible staff. |
| [**FRA-827**](screens/fra_827/_screen_details.md) | `SchedulerCoordinatorAssignmentsScreen` | ✅ Implemented | Finalize mapping of a specific clinical staff member to a patient ticket. |
| [**FRA-828**](screens/fra_828/_screen_details.md) | `SchedulerCoordinatorConflictsScreen` | ✅ Implemented | Auto-detect and resolve double-bookings or overtime threshold violations. |
| [**COR-768**](screens/cor_768/_screen_details.md) | `SchedulerCoordinatorReportsScreen` | ✅ Implemented | Generate analytics detailing fulfillment rates and scheduling velocity. |
