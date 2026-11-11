# Native theme CI repairs

The first checks on e319d842 exposed two regressions: matrix setup folded optional test commands into the one-line flutter pub get command, causing a shell syntax error near then; and the new SDK progress adapter reused the existing UI PrimeLinearProgressIndicator export name, causing client compilation failures.

Separate dependency installation from the multiline test block. Keep each optional suite exactly once and restore the circular progress compile check to the compile block. Add shell syntax/step separation tests and run them before native setup.

Name the SDK adapter PrimeMaterialLinearProgressIndicator; preserve the established UI PrimeLinearProgressIndicator API used by generated screens. Record the canonical SDK adapter name in the generator metadata and exact consumer receipt. Reject collisions between new adapter names and existing shared UI declarations in regression tests.

The work-module analyzer also reported a duplicate narrow import and dynamic map indexing in protocol ports/oracle tests. Remove only the exact duplicate import and give known record-list operations Map element types, preserving values, wire payloads and authorization checks. Keep malformed task/message record validation in its existing guarded loops. No analyzer suppression or test waiver.

Evidence: workflow job130749770193 failed setup command parsing, job130749770071 failed duplicate progress export compilation, job130749770686 reported the import/dynamic-call analyzer findings. These repairs require fresh CI execution; the original failures are not green evidence.

The foundation native job130749769180 also exposed three invalid fixture assumptions: AppBar is not const, TextField.decoration is nullable in the SDK, and progress semantics must use a numeric/percent value. Correct those fixture inputs/accesses while retaining all delegation and semantics assertions.

Integration: main advanced to c9d98168 with the command separation and three foundation fixture fixes while these repairs were prepared. Preserve that exact incoming work, add workflow regression checks, and publish the remaining export collision, import cleanup and typed-map repairs on top with an expected-head lease.
