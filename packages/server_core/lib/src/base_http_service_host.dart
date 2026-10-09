import 'package:shelf/shelf.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'base_service_host.dart';

/// Builds each HTTP pipeline centrally, retaining declared middleware order.
abstract class BaseHttpServiceHost extends BaseServiceHost {
  const BaseHttpServiceHost({required super.serviceName, super.defaultPort});

  /// First middleware is outermost, matching Shelf's Pipeline semantics.
  List<Middleware> get middleware => [logRequests()];

  /// Service initialization and route authorization remain with the service.
  Future<Handler> createRoutes();

  @override
  Future<Handler> createHandler() async {
    final routes = await createRoutes();
    var pipeline = const Pipeline();
    for (final layer in middleware) {
      pipeline = pipeline.addMiddleware(layer);
    }
    return pipeline.addHandler(routes);
  }
}

/// Existing default policy for APIs that used shelf_cors_headers defaults.
/// Services with different policies extend BaseHttpServiceHost directly.
abstract class BaseCorsServiceHost extends BaseHttpServiceHost {
  const BaseCorsServiceHost({required super.serviceName, super.defaultPort});

  @override
  List<Middleware> get middleware => [logRequests(), corsHeaders()];
}
