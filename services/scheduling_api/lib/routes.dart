// Generated scheduling screen bindings have no verified business implementation.
// Keep their exact routes available, but never claim an empty read or completed action.
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiRoutes {
  static const screenPaths = <String>[
    '/api/family-member-loved-one-schedule-screen',
    '/api/psw-schedule-screen',
    '/api/operations-manager-schedule-screen',
    '/api/operations-manager-shifts-screen',
    '/api/scheduler-coordinator-appointment-calendar-screen',
    '/api/scheduler-coordinator-assignments-screen',
    '/api/scheduler-coordinator-booking-requests-screen',
    '/api/scheduler-coordinator-conflicts-screen',
    '/api/scheduler-coordinator-open-shifts-screen',
    '/api/scheduler-coordinator-provider-availability-screen',
    '/api/scheduler-coordinator-reports-screen',
    '/api/scheduler-coordinator-shift-calendar-screen',
    '/api/training-coordinator-training-schedule-screen',
  ];

  Response _unsupported(Request request) => Response(
    501,
    body: jsonEncode({
      'error': 'Scheduling screen workflow is not implemented',
      'status': 'not_implemented',
      'code': 'scheduling_screen_workflow_unavailable',
    }),
    headers: {'content-type': 'application/json', 'cache-control': 'no-store'},
  );

  Router get router {
    final router = Router();
    for (final path in screenPaths) {
      router.get(path, _unsupported);
      router.post('$path/action', _unsupported);
    }
    return router;
  }
}
