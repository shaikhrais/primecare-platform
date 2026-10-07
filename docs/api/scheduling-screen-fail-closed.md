Generated scheduling screen routes previously returned successful empty collections and `action_completed` despite having no database query or mutation. The Dart scheduling service mounts these handlers in `bin/server.dart`.

The 13 existing screen GET routes and their 13 POST `/action` routes now return HTTP 501 with `status: not_implemented`, `code: scheduling_screen_workflow_unavailable`, and `Cache-Control: no-store`. They do not initialize Prisma or consume request bodies. This preserves route names while honestly reporting unsupported behavior. It does not implement scheduling APIs or change `/api/schedules`, booking lifecycle handlers, authorization grants, or the finite API completion count.

`services/scheduling_api/test/routes_test.dart` exercises the actual router for all 26 routes, verifies unavailable responses and unread action bodies, and checks unknown routes and methods remain unmatched. Until workflow contracts and authorization exist, these screen bindings remain unavailable.

Run `bash scripts/test-scheduling-screen-routes.sh` with Dart on PATH. The runner uses the real service files in a minimal Shelf test package, avoiding unrelated Flutter/Prisma dependency resolution. Verified with Dart 3.13.5: 27 tests passed.
