# Screenshot Failure Index Report

| Role | Screen ID | Screen Name | Route | Expected Sidebar Label | Actual Sidebar Links Found | Screenshot Path | Failure Reason | Source File | DB Record Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| rmt | 1 | RmtDashboardScreen | /offices/clinical/roles/rmt/dashboard | RMT Dashboard | N/A | cypress/screenshots/failures/rmt/rmt_dashboard__failure.png | Timed out retrying after 5000ms: `cy.wait()` timed out waiting `5000ms` for the 1st request to the route: `api_v1_rmt_list_get`. No request ever occurred.

https://on.cypress.io/wait | packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| rmt | 1 | RmtDashboardScreen | /offices/clinical/roles/rmt/dashboard | RMT Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\rmt_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| rmt | 1 | RmtDashboardScreen | /offices/clinical/roles/rmt/dashboard | RMT Dashboard | N/A | cypress/screenshots/failures/rmt/rmt_dashboard__failure.png | Timed out retrying after 5000ms: `cy.wait()` timed out waiting `5000ms` for the 1st request to the route: `api_v1_rmt_list_get`. No request ever occurred.

https://on.cypress.io/wait | packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| rmt | 1 | RmtDashboardScreen | /offices/clinical/roles/rmt/dashboard | RMT Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\rmt_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| rmt | 1 | RmtDashboardScreen | /offices/clinical/roles/rmt/dashboard | RMT Dashboard | N/A | cypress/screenshots/failures/rmt/rmt_dashboard__failure.png | Timed out retrying after 15000ms: Expected to find element: `[aria-label*="data-cy:sim-btn-loading"], [data-cy="sim-btn-loading"], flt-semantics:contains("data-cy:sim-btn-loading")`, but never found it. | packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| rmt | 1 | RmtDashboardScreen | /offices/clinical/roles/rmt/dashboard | RMT Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\rmt_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | cypress/screenshots/failures/psw/psw_dashboard__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Dashboard' | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 231 | PswAnalyticsScreen | /offices/clinical/roles/psw/reports | PSW Analytics | N/A | cypress/screenshots/failures/psw/psw_analytics__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Analytics' | packages/primecare_ui/lib/src/screens/psw/psw_analytics_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 232 | PswClientsScreen | /offices/clinical/roles/psw/patient-profile | PSW Clients | N/A | cypress/screenshots/failures/psw/psw_clients__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Clients' | packages/primecare_ui/lib/src/screens/psw/psw_clients_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 233 | PswComplianceScreen | /offices/clinical/roles/psw/help-support | PSW Compliance | N/A | cypress/screenshots/failures/psw/psw_compliance__failure.png | The following error originated from your application code, not from Cypress. It was caused by an unhandled promise rejection.

  > Cypress detected that you returned a promise from a command while also invoking one or more cy commands in that promise.

The command that returned the promise was:

  > `cy.wait()`

The cy command you invoked inside the promise was:

  > `cy.screenshot()`

Because Cypress commands are already promise-like, you don't need to wrap them or return your own promise.

Cypress will resolve your command with whatever the final Cypress command yields.

The reason this is an error instead of a warning is because Cypress internally queues commands serially whereas Promises execute as soon as they are invoked. Attempting to reconcile this would prevent Cypress from ever resolving.

https://on.cypress.io/returning-promise-and-commands-in-another-command

When Cypress detects uncaught errors originating from your application it will automatically fail the current test.

This behavior is configurable, and you can choose to turn this off by listening to the `uncaught:exception` event.

https://on.cypress.io/uncaught-exception-from-application | packages/primecare_ui/lib/src/screens/psw/psw_compliance_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 234 | PswMessagesScreen | /offices/clinical/roles/psw/messages | PSW Messages | N/A | cypress/screenshots/failures/psw/psw_messages__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Messages' | packages/primecare_ui/lib/src/screens/psw/psw_messages_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 235 | PswShiftTrackerScreen | /offices/clinical/roles/psw/schedule | PSW Shift Tracker | N/A | cypress/screenshots/failures/psw/psw_shift_tracker__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Shift Tracker' | packages/primecare_ui/lib/src/screens/psw/psw_shift_tracker_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 236 | PswTasksScreen | /offices/clinical/roles/psw/visit-checklist | PSW Tasks | N/A | cypress/screenshots/failures/psw/psw_tasks__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Tasks' | packages/primecare_ui/lib/src/screens/psw/psw_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 237 | PswVisitNotesScreen | /offices/clinical/roles/psw/visit-notes | PSW Visit Notes | N/A | cypress/screenshots/failures/psw/psw_visit_notes__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Visit Notes' | packages/primecare_ui/lib/src/screens/psw/psw_visit_notes_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 238 | PswWorkflowScreen | /offices/clinical/roles/psw/psw-workflow | PSW Workflow | N/A | cypress/screenshots/failures/psw/psw_workflow__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Workflow' | packages/primecare_ui/lib/src/screens/psw/psw_workflow_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 343 | PswCommandCenterScreen | /offices/clinical/roles/psw/system-logs | PSW Command Center | N/A | cypress/screenshots/failures/psw/psw_command_center__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Command Center' | packages/primecare_ui/lib/src/screens/psw/psw_command_center_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 344 | PswMyShiftsScreen | /offices/clinical/roles/psw/psw-my-shifts | PSW My Shifts | N/A | cypress/screenshots/failures/psw/psw_my_shifts__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW My Shifts' | packages/primecare_ui/lib/src/screens/psw/psw_my_shifts_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 345 | PswClientProfileScreen | /offices/clinical/roles/psw/profile | PSW Client Profile | N/A | cypress/screenshots/failures/psw/psw_client_profile__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Client Profile' | packages/primecare_ui/lib/src/screens/psw/psw_client_profile_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 347 | PswVitalsLogScreen | /offices/clinical/roles/psw/observation-vitals-log | PSW Vitals Log | N/A | cypress/screenshots/failures/psw/psw_vitals_log__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Vitals Log' | packages/primecare_ui/lib/src/screens/psw/psw_vitals_log_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 348 | PswIncidentReportScreen | /offices/clinical/roles/psw/incident-report | PSW Incident Report | N/A | cypress/screenshots/failures/psw/psw_incident_report__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Incident Report' | packages/primecare_ui/lib/src/screens/psw/psw_incident_report_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 349 | PswCarePlanScreen | /offices/clinical/roles/psw/care-plan | PSW Care Plan | N/A | cypress/screenshots/failures/psw/psw_care_plan__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Care Plan' | packages/primecare_ui/lib/src/screens/psw/psw_care_plan_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 351 | PswDocumentsScreen | /offices/clinical/roles/psw/documents | PSW Documents | N/A | cypress/screenshots/failures/psw/psw_documents__failure.png | Timed out retrying after 15000ms: expected '<flt-semantics#flt-semantic-node-12>' to contain 'PSW Documents' | packages/primecare_ui/lib/src/screens/psw/psw_documents_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 533 | ShiftTasksScreen | /offices/clinical/roles/psw/shift-tasks | Shift Tasks | N/A | cypress/screenshots/failures/psw/shift_tasks__failure.png | The following error originated from your application code, not from Cypress. It was caused by an unhandled promise rejection.

  > Cypress detected that you returned a promise from a command while also invoking one or more cy commands in that promise.

The command that returned the promise was:

  > `cy.wait()`

The cy command you invoked inside the promise was:

  > `cy.screenshot()`

Because Cypress commands are already promise-like, you don't need to wrap them or return your own promise.

Cypress will resolve your command with whatever the final Cypress command yields.

The reason this is an error instead of a warning is because Cypress internally queues commands serially whereas Promises execute as soon as they are invoked. Attempting to reconcile this would prevent Cypress from ever resolving.

https://on.cypress.io/returning-promise-and-commands-in-another-command

When Cypress detects uncaught errors originating from your application it will automatically fail the current test.

This behavior is configurable, and you can choose to turn this off by listening to the `uncaught:exception` event.

https://on.cypress.io/uncaught-exception-from-application | packages/primecare_ui/lib/src/screens/psw/shift_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 535 | VitalsEntryScreen | /offices/clinical/roles/psw/vitals-entry | Vitals Entry | N/A | cypress/screenshots/failures/psw/vitals_entry__failure.png | Timed out retrying after 15000ms: Expected to find element: `[aria-label*="data-cy:vitals_entry-screen"], [data-cy="vitals_entry-screen"], flt-semantics:contains("data-cy:vitals_entry-screen")`, but never found it. | packages/primecare_ui/lib/src/screens/psw/vitals_entry_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 231 | PswAnalyticsScreen | /offices/clinical/roles/psw/reports | PSW Analytics | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_analytics_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_analytics_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 232 | PswClientsScreen | /offices/clinical/roles/psw/patient-profile | PSW Clients | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_clients_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_clients_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 233 | PswComplianceScreen | /offices/clinical/roles/psw/help-support | PSW Compliance | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_compliance_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_compliance_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 234 | PswMessagesScreen | /offices/clinical/roles/psw/messages | PSW Messages | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_messages_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_messages_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 235 | PswShiftTrackerScreen | /offices/clinical/roles/psw/schedule | PSW Shift Tracker | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_shift_tracker_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_shift_tracker_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 236 | PswTasksScreen | /offices/clinical/roles/psw/visit-checklist | PSW Tasks | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_tasks_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 237 | PswVisitNotesScreen | /offices/clinical/roles/psw/visit-notes | PSW Visit Notes | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_visit_notes_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_visit_notes_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 238 | PswWorkflowScreen | /offices/clinical/roles/psw/psw-workflow | PSW Workflow | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_workflow_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_workflow_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 343 | PswCommandCenterScreen | /offices/clinical/roles/psw/system-logs | PSW Command Center | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_command_center_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_command_center_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 344 | PswMyShiftsScreen | /offices/clinical/roles/psw/psw-my-shifts | PSW My Shifts | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_my_shifts_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_my_shifts_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 345 | PswClientProfileScreen | /offices/clinical/roles/psw/profile | PSW Client Profile | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_client_profile_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_client_profile_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 347 | PswVitalsLogScreen | /offices/clinical/roles/psw/observation-vitals-log | PSW Vitals Log | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_vitals_log_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_vitals_log_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 348 | PswIncidentReportScreen | /offices/clinical/roles/psw/incident-report | PSW Incident Report | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_incident_report_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_incident_report_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 349 | PswCarePlanScreen | /offices/clinical/roles/psw/care-plan | PSW Care Plan | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_care_plan_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_care_plan_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 351 | PswDocumentsScreen | /offices/clinical/roles/psw/documents | PSW Documents | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_documents_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_documents_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 533 | ShiftTasksScreen | /offices/clinical/roles/psw/shift-tasks | Shift Tasks | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\shift_tasks_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/shift_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 535 | VitalsEntryScreen | /offices/clinical/roles/psw/vitals-entry | Vitals Entry | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\vitals_entry_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/vitals_entry_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | cypress/screenshots/failures/psw/psw_dashboard__failure.png | Timed out retrying after 15000ms: Expected to find element: `[aria-label*="data-cy:psw_dashboard-screen"], [data-cy="psw_dashboard-screen"], flt-semantics:contains("data-cy:psw_dashboard-screen")`, but never found it. | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | cypress/screenshots/failures/psw/psw_dashboard__failure.png | Timed out retrying after 15000ms: Expected to find element: `[aria-label*="data-cy:psw_dashboard-screen"], [data-cy="psw_dashboard-screen"], flt-semantics:contains("data-cy:psw_dashboard-screen")`, but never found it. | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | cypress/screenshots/failures/psw/psw_dashboard__failure.png | Timed out retrying after 15000ms: expected 'https://primecare-auth.pages.dev/login?redirect_uri=https://primecare-clinic.pages.dev/auth/callback&enable-semantics=true&cb=1782874640758' to include '/roles/psw/dashboard' | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | cypress/screenshots/failures/psw/psw_dashboard__MISSING_SIDEBAR_LINK.png | MISSING_SIDEBAR_LINK: Expected sidebar link "PSW Dashboard" is missing | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 231 | PswAnalyticsScreen | /offices/clinical/roles/psw/reports | PSW Analytics | N/A | cypress/screenshots/failures/psw/psw_analytics__failure.png | The following error originated from your application code, not from Cypress. It was caused by an unhandled promise rejection.

  > Cypress detected that you returned a promise from a command while also invoking one or more cy commands in that promise.

The command that returned the promise was:

  > `cy.wait()`

The cy command you invoked inside the promise was:

  > `cy.screenshot()`

Because Cypress commands are already promise-like, you don't need to wrap them or return your own promise.

Cypress will resolve your command with whatever the final Cypress command yields.

The reason this is an error instead of a warning is because Cypress internally queues commands serially whereas Promises execute as soon as they are invoked. Attempting to reconcile this would prevent Cypress from ever resolving.

https://on.cypress.io/returning-promise-and-commands-in-another-command

When Cypress detects uncaught errors originating from your application it will automatically fail the current test.

This behavior is configurable, and you can choose to turn this off by listening to the `uncaught:exception` event.

https://on.cypress.io/uncaught-exception-from-application | packages/primecare_ui/lib/src/screens/psw/psw_analytics_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 233 | PswComplianceScreen | /offices/clinical/roles/psw/help-support | PSW Compliance | N/A | cypress/screenshots/failures/psw/psw_compliance__failure.png | Timed out retrying after 15000ms: expected 'https://primecare-clinic.pages.dev/offices/clinical/roles/psw/psw-compliance' to include '/offices/clinical/roles/psw/help-support' | packages/primecare_ui/lib/src/screens/psw/psw_compliance_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 236 | PswTasksScreen | /offices/clinical/roles/psw/visit-checklist | PSW Tasks | N/A | cypress/screenshots/failures/psw/psw_tasks__failure.png | Timed out retrying after 15000ms: expected 'https://primecare-clinic.pages.dev/offices/clinical/roles/psw/shift-tasks' to include '/offices/clinical/roles/psw/visit-checklist' | packages/primecare_ui/lib/src/screens/psw/psw_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 343 | PswCommandCenterScreen | /offices/clinical/roles/psw/system-logs | PSW Command Center | N/A | cypress/screenshots/failures/psw/psw_command_center__failure.png | Timed out retrying after 15000ms: expected 'https://primecare-clinic.pages.dev/offices/clinical/roles/psw/psw-command-center' to include '/offices/clinical/roles/psw/system-logs' | packages/primecare_ui/lib/src/screens/psw/psw_command_center_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 345 | PswClientProfileScreen | /offices/clinical/roles/psw/profile | PSW Client Profile | N/A | cypress/screenshots/failures/psw/psw_client_profile__failure.png | Timed out retrying after 15000ms: expected 'https://primecare-clinic.pages.dev/offices/clinical/roles/psw/psw-client-profile' to include '/offices/clinical/roles/psw/profile' | packages/primecare_ui/lib/src/screens/psw/psw_client_profile_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 351 | PswDocumentsScreen | /offices/clinical/roles/psw/documents | PSW Documents | N/A | cypress/screenshots/failures/psw/psw_documents__failure.png | The following error originated from your application code, not from Cypress. It was caused by an unhandled promise rejection.

  > Cypress detected that you returned a promise from a command while also invoking one or more cy commands in that promise.

The command that returned the promise was:

  > `cy.wait()`

The cy command you invoked inside the promise was:

  > `cy.screenshot()`

Because Cypress commands are already promise-like, you don't need to wrap them or return your own promise.

Cypress will resolve your command with whatever the final Cypress command yields.

The reason this is an error instead of a warning is because Cypress internally queues commands serially whereas Promises execute as soon as they are invoked. Attempting to reconcile this would prevent Cypress from ever resolving.

https://on.cypress.io/returning-promise-and-commands-in-another-command

When Cypress detects uncaught errors originating from your application it will automatically fail the current test.

This behavior is configurable, and you can choose to turn this off by listening to the `uncaught:exception` event.

https://on.cypress.io/uncaught-exception-from-application | packages/primecare_ui/lib/src/screens/psw/psw_documents_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 535 | VitalsEntryScreen | /offices/clinical/roles/psw/vitals-entry | Vitals Entry | N/A | cypress/screenshots/failures/psw/vitals_entry__failure.png | The following error originated from your application code, not from Cypress. It was caused by an unhandled promise rejection.

  > Cypress detected that you returned a promise from a command while also invoking one or more cy commands in that promise.

The command that returned the promise was:

  > `cy.wait()`

The cy command you invoked inside the promise was:

  > `cy.screenshot()`

Because Cypress commands are already promise-like, you don't need to wrap them or return your own promise.

Cypress will resolve your command with whatever the final Cypress command yields.

The reason this is an error instead of a warning is because Cypress internally queues commands serially whereas Promises execute as soon as they are invoked. Attempting to reconcile this would prevent Cypress from ever resolving.

https://on.cypress.io/returning-promise-and-commands-in-another-command

When Cypress detects uncaught errors originating from your application it will automatically fail the current test.

This behavior is configurable, and you can choose to turn this off by listening to the `uncaught:exception` event.

https://on.cypress.io/uncaught-exception-from-application | packages/primecare_ui/lib/src/screens/psw/vitals_entry_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 231 | PswAnalyticsScreen | /offices/clinical/roles/psw/reports | PSW Analytics | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_analytics_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_analytics_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 232 | PswClientsScreen | /offices/clinical/roles/psw/patient-profile | PSW Clients | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_clients_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_clients_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 233 | PswComplianceScreen | /offices/clinical/roles/psw/help-support | PSW Compliance | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_compliance_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_compliance_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 234 | PswMessagesScreen | /offices/clinical/roles/psw/messages | PSW Messages | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_messages_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_messages_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 235 | PswShiftTrackerScreen | /offices/clinical/roles/psw/schedule | PSW Shift Tracker | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_shift_tracker_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_shift_tracker_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 236 | PswTasksScreen | /offices/clinical/roles/psw/visit-checklist | PSW Tasks | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_tasks_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 237 | PswVisitNotesScreen | /offices/clinical/roles/psw/visit-notes | PSW Visit Notes | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_visit_notes_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_visit_notes_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 238 | PswWorkflowScreen | /offices/clinical/roles/psw/psw-workflow | PSW Workflow | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_workflow_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_workflow_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 343 | PswCommandCenterScreen | /offices/clinical/roles/psw/system-logs | PSW Command Center | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_command_center_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_command_center_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 344 | PswMyShiftsScreen | /offices/clinical/roles/psw/psw-my-shifts | PSW My Shifts | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_my_shifts_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_my_shifts_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 345 | PswClientProfileScreen | /offices/clinical/roles/psw/profile | PSW Client Profile | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_client_profile_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_client_profile_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 347 | PswVitalsLogScreen | /offices/clinical/roles/psw/observation-vitals-log | PSW Vitals Log | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_vitals_log_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_vitals_log_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 348 | PswIncidentReportScreen | /offices/clinical/roles/psw/incident-report | PSW Incident Report | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_incident_report_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_incident_report_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 349 | PswCarePlanScreen | /offices/clinical/roles/psw/care-plan | PSW Care Plan | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_care_plan_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_care_plan_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 351 | PswDocumentsScreen | /offices/clinical/roles/psw/documents | PSW Documents | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_documents_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_documents_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 533 | ShiftTasksScreen | /offices/clinical/roles/psw/shift-tasks | Shift Tasks | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\shift_tasks_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/shift_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 535 | VitalsEntryScreen | /offices/clinical/roles/psw/vitals-entry | Vitals Entry | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\vitals_entry_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/vitals_entry_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 231 | PswAnalyticsScreen | /offices/clinical/roles/psw/reports | PSW Analytics | N/A | cypress/screenshots/failures/psw/psw_analytics__failure.png | Timed out retrying after 15000ms: expected 'https://primecare-clinic.pages.dev/offices/clinical/roles/psw/psw-analytics' to include '/offices/clinical/roles/psw/reports' | packages/primecare_ui/lib/src/screens/psw/psw_analytics_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 234 | PswMessagesScreen | /offices/clinical/roles/psw/messages | PSW Messages | N/A | cypress/screenshots/failures/psw/psw_messages__failure.png | A callback was provided to intercept the upstream response, but a network error occurred while making the request:

Error: Socket closed before finished writing response
    at <embedded>:2599:53868
    at tryCatcher (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\util.js:16:23)
    at Promise._settlePromiseFromHandler (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\promise.js:547:31)
    at Promise._settlePromise (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\promise.js:604:18)
    at Promise._settlePromise0 (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\promise.js:649:10)
    at Promise._settlePromises (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\promise.js:729:18)
    at _drainQueueStep (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\async.js:93:12)
    at _drainQueue (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\async.js:86:9)
    at Async._drainQueues (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\async.js:102:5)
    at Immediate._onImmediate (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\async.js:15:14)
    at process.processImmediate (node:internal/timers:485:21)

Route: {
  "url": "**"
}

Intercepted request: {
  "headers": {
    "host": "primecare-clinic.pages.dev",
    "connection": "keep-alive",
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
    "upgrade-insecure-requests": "1",
    "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Cypress/15.16.0 Chrome/138.0.7204.251 Electron/37.6.0 Safari/537.36",
    "sec-fetch-site": "cross-site",
    "sec-fetch-mode": "navigate",
    "sec-fetch-dest": "iframe",
    "sec-fetch-storage-access": "active",
    "referer": "https://primecare-auth.pages.dev/",
    "accept-encoding": "gzip, deflate, br, zstd",
    "accept-language": "en-US"
  },
  "url": "https://primecare-clinic.pages.dev/auth/callback?token=mock-jwt-token-psw&role=psw&userId=unknown",
  "method": "GET",
  "httpVersion": "1.1",
  "resourceType": "other",
  "query": {
    "token": "mock-jwt-token-psw",
    "role": "psw",
    "userId": "unknown"
  },
  "body": "",
  "responseTimeout": 30000
}

https://on.cypress.io/intercept | packages/primecare_ui/lib/src/screens/psw/psw_messages_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 231 | PswAnalyticsScreen | /offices/clinical/roles/psw/reports | PSW Analytics | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_analytics_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_analytics_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 232 | PswClientsScreen | /offices/clinical/roles/psw/patient-profile | PSW Clients | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_clients_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_clients_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 233 | PswComplianceScreen | /offices/clinical/roles/psw/help-support | PSW Compliance | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_compliance_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_compliance_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 234 | PswMessagesScreen | /offices/clinical/roles/psw/messages | PSW Messages | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_messages_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_messages_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 235 | PswShiftTrackerScreen | /offices/clinical/roles/psw/schedule | PSW Shift Tracker | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_shift_tracker_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_shift_tracker_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 236 | PswTasksScreen | /offices/clinical/roles/psw/visit-checklist | PSW Tasks | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_tasks_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 237 | PswVisitNotesScreen | /offices/clinical/roles/psw/visit-notes | PSW Visit Notes | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_visit_notes_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_visit_notes_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 238 | PswWorkflowScreen | /offices/clinical/roles/psw/psw-workflow | PSW Workflow | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_workflow_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_workflow_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 343 | PswCommandCenterScreen | /offices/clinical/roles/psw/system-logs | PSW Command Center | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_command_center_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_command_center_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 344 | PswMyShiftsScreen | /offices/clinical/roles/psw/psw-my-shifts | PSW My Shifts | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_my_shifts_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_my_shifts_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 345 | PswClientProfileScreen | /offices/clinical/roles/psw/profile | PSW Client Profile | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_client_profile_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_client_profile_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 347 | PswVitalsLogScreen | /offices/clinical/roles/psw/observation-vitals-log | PSW Vitals Log | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_vitals_log_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_vitals_log_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 348 | PswIncidentReportScreen | /offices/clinical/roles/psw/incident-report | PSW Incident Report | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_incident_report_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_incident_report_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 349 | PswCarePlanScreen | /offices/clinical/roles/psw/care-plan | PSW Care Plan | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_care_plan_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_care_plan_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 351 | PswDocumentsScreen | /offices/clinical/roles/psw/documents | PSW Documents | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_documents_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_documents_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 533 | ShiftTasksScreen | /offices/clinical/roles/psw/shift-tasks | Shift Tasks | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\shift_tasks_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/shift_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 535 | VitalsEntryScreen | /offices/clinical/roles/psw/vitals-entry | Vitals Entry | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\vitals_entry_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/vitals_entry_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 344 | PswMyShiftsScreen | /offices/clinical/roles/psw/psw-my-shifts | PSW My Shifts | N/A | cypress/screenshots/failures/psw/psw_my_shifts__failure.png | A callback was provided to intercept the upstream response, but a network error occurred while making the request:

Error: Socket closed before finished writing response
    at <embedded>:2599:53868
    at tryCatcher (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\util.js:16:23)
    at Promise._settlePromiseFromHandler (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\promise.js:547:31)
    at Promise._settlePromise (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\promise.js:604:18)
    at Promise._settlePromise0 (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\promise.js:649:10)
    at Promise._settlePromises (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\promise.js:729:18)
    at _drainQueueStep (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\async.js:93:12)
    at _drainQueue (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\async.js:86:9)
    at Async._drainQueues (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\async.js:102:5)
    at Immediate._onImmediate (C:\Users\Admin2\AppData\Local\Cypress\Cache\15.16.0\Cypress\resources\app\node_modules\bluebird\js\release\async.js:15:14)
    at process.processImmediate (node:internal/timers:485:21)

Route: {
  "url": "**"
}

Intercepted request: {
  "headers": {
    "host": "primecare-clinic.pages.dev",
    "connection": "keep-alive",
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
    "upgrade-insecure-requests": "1",
    "user-agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Cypress/15.16.0 Chrome/138.0.7204.251 Electron/37.6.0 Safari/537.36",
    "sec-fetch-site": "cross-site",
    "sec-fetch-mode": "navigate",
    "sec-fetch-dest": "iframe",
    "sec-fetch-storage-access": "active",
    "referer": "https://primecare-auth.pages.dev/",
    "accept-encoding": "gzip, deflate, br, zstd",
    "accept-language": "en-US"
  },
  "url": "https://primecare-clinic.pages.dev/auth/callback?token=mock-jwt-token-psw&role=psw&userId=unknown",
  "method": "GET",
  "httpVersion": "1.1",
  "resourceType": "other",
  "query": {
    "token": "mock-jwt-token-psw",
    "role": "psw",
    "userId": "unknown"
  },
  "body": "",
  "responseTimeout": 30000
}

https://on.cypress.io/intercept | packages/primecare_ui/lib/src/screens/psw/psw_my_shifts_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 61 | PswDashboardScreen | /offices/clinical/roles/psw/dashboard | PSW Dashboard | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_dashboard_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 231 | PswAnalyticsScreen | /offices/clinical/roles/psw/reports | PSW Analytics | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_analytics_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_analytics_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 232 | PswClientsScreen | /offices/clinical/roles/psw/patient-profile | PSW Clients | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_clients_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_clients_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 233 | PswComplianceScreen | /offices/clinical/roles/psw/help-support | PSW Compliance | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_compliance_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_compliance_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 234 | PswMessagesScreen | /offices/clinical/roles/psw/messages | PSW Messages | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_messages_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_messages_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 235 | PswShiftTrackerScreen | /offices/clinical/roles/psw/schedule | PSW Shift Tracker | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_shift_tracker_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_shift_tracker_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 236 | PswTasksScreen | /offices/clinical/roles/psw/visit-checklist | PSW Tasks | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_tasks_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 237 | PswVisitNotesScreen | /offices/clinical/roles/psw/visit-notes | PSW Visit Notes | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_visit_notes_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_visit_notes_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 238 | PswWorkflowScreen | /offices/clinical/roles/psw/psw-workflow | PSW Workflow | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_workflow_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_workflow_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 343 | PswCommandCenterScreen | /offices/clinical/roles/psw/system-logs | PSW Command Center | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_command_center_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_command_center_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 344 | PswMyShiftsScreen | /offices/clinical/roles/psw/psw-my-shifts | PSW My Shifts | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_my_shifts_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_my_shifts_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 345 | PswClientProfileScreen | /offices/clinical/roles/psw/profile | PSW Client Profile | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_client_profile_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_client_profile_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 347 | PswVitalsLogScreen | /offices/clinical/roles/psw/observation-vitals-log | PSW Vitals Log | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_vitals_log_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_vitals_log_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 348 | PswIncidentReportScreen | /offices/clinical/roles/psw/incident-report | PSW Incident Report | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_incident_report_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_incident_report_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 349 | PswCarePlanScreen | /offices/clinical/roles/psw/care-plan | PSW Care Plan | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_care_plan_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_care_plan_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 351 | PswDocumentsScreen | /offices/clinical/roles/psw/documents | PSW Documents | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\psw_documents_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/psw_documents_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 533 | ShiftTasksScreen | /offices/clinical/roles/psw/shift-tasks | Shift Tasks | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\shift_tasks_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/shift_tasks_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
| psw | 535 | VitalsEntryScreen | /offices/clinical/roles/psw/vitals-entry | Vitals Entry | N/A | C:\Users\Admin2\.gemini\antigravity-ide\brain\26b1218b-e518-4477-8a4e-2789a840acc1\vitals_entry_runtime.png | Cypress execution returned non-zero exit code | packages/primecare_ui/lib/src/screens/psw/vitals_entry_screen.dart | runtime_verified=1, cypress_verified=1, production_ready=1 |
