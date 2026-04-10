# Role: Personal Support Worker (PSW)
**Office:** [Clinical Operations (Field)](../offices/clinical.md)  
**Authority Level:** Level 1 (Field)

## Operational Summary
GPS-coordinated care provisioning, treatment tasks, and daily note filing.

## Accessible Screens & Tasks

| Screen ID | Verified Component | Implementation Status | Core Operation / Task |
| :--- | :--- | :--- | :--- |
| **RDB-203** | `ClinicDashboardScreenStitch` | ⏳ Stitch Pend | Overview of the day's scheduled care home visits and active alerts. |
| **CLN-301** | `ClinicCarePlanScreenStitch` | ⏳ Stitch Pend | Read-only access to the active ADL (Activities of Daily Living) care plan. |
| **CLN-302** | `ClinicCheckInOutScreenStitch` | ⏳ Stitch Pend | EVV (Electronic Visit Verification) check-in via geolocation upon client arrival. |
| **CLN-303** | `ClinicClientProfileScreenStitch` | ⏳ Stitch Pend | Review specific client behavioral notes, access codes, and family contacts. |
| **CLN-304** | `ClinicDailyNotesScreenStitch` | ⏳ Stitch Pend | Submit narrative summaries of the client's disposition and ADLs performed. |
| **CLN-305** | `ClinicIncidentReportScreenStitch` | ⏳ Stitch Pend | Report minor localized incidents or behavioral escalations. |
| **CLN-306** | `ClinicMyShiftsScreenStitch` | ⏳ Stitch Pend | Calendar view of accepted, pending, and completed care-worker shifts. |
| **CLN-307** | `ClinicShiftDetailsScreenStitch` | ⏳ Stitch Pend | Extract precise address, duration, and required physical tasks for a shift. |
| **CLN-310** | `HistoryLogsScreenStitch` | ✅ Foundation | Review past worked hours for upcoming payroll reconciliation. |
| **CLN-311** | `ProfileSettingsScreenStitch` | ✅ Foundation | Manage personal profile, active working hours availability, and certifications. |
| **CLN-312** | `MessagingScreenStitch` | ✅ Foundation | Communicate directly with the Scheduler or Nursing Lead regarding shift constraints. |
