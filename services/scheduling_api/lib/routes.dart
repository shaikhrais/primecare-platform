// Generated scheduling screen bindings have no verified business implementation.
// Keep their exact routes available, but never claim an empty read or completed action.
import 'dart:convert';
import 'package:server_core/server_core.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'src/features/scheduling_screen_routes/scheduling_screen_routes.dart';

class ApiRoutes extends BaseModularApiRoutes {
  static const screenPaths = SchedulingScreenRoutes.screenPaths;

  @override
  Iterable<BaseApiRoutes> get modules => [
    SchedulingScreenRoutes(),
  ];
}
