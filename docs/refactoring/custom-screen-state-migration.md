# Shared custom screen state and generator placement

Five existing state classes now live in primecare_models and inherit the common
BaseLoggedScreenState storage: AssessmentState, PatientChartingState,
IncidentReportState, TreatmentNotesState, and ClinicalDirectorDashboardState.
Their constructors, defaults, custom fields, and copy methods retain their
original behavior. The old screen libraries import and re-export the canonical
classes so existing callers continue to compile. Presentation, API calls, and
the clinical dashboard's fail-closed input validation stay in the UI.

Both existing screen generators now call write_screen_model. Each generated
state becomes a pure Dart library under primecare_models, scoped by its original
application/package path. The screen imports and re-exports that library.
Identical class names in different apps cannot overwrite one model file.
Repeated generation from the same template produces identical output.

GovernanceRoutes retains its static router getter. A private child of
BaseApiRoutes now registers its original 22 routes, using the same fresh-router
lifecycle as the other services. No route, handler, or access policy is added.

The pinned migration manifest identifies each original file. The verification
harness compares every state field against its original class after creation,
no-op copying, partial copying, complete updates, and explicit error clearing.
It also compiles output from both actual generator templates, verifies distinct
app paths, and compares the unchanged screen and route code. A runtime route
test covers fresh routers, original root/echo responses, and unmatched methods.

Seven source hashes in the contract-review evidence changed because five screen
files and two generators changed. Their dependent artifacts were regenerated;
operation identities, evidence stages, policy decisions, and zero completion
credits remain unchanged. No governance database records or business workflows
are implemented by this structural migration.
