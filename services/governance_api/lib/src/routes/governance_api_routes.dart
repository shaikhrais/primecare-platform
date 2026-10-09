// Governance - Category: middleware | Purpose: Sanity / Test routes Apps Roles Modules
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/governance_http_controller.dart';
import 'package:server_core/server_core.dart';

class GovernanceApiRoutes extends BaseApiRoutes {
  final GovernanceHttpController Function() _controller;
  GovernanceApiRoutes(this._controller);
  @override
  void registerRoutes(Router router) {

    // Sanity / Test routes
    router.get('/', (Request request) => Response.ok('Hello, World!\n'));
    router.get('/echo/<message>', (Request request, String message) => Response.ok('$message\n'));

    // Apps
    router.get('/api/apps', (Request request) => _controller().getApps(request));
    router.post('/api/apps', (Request request) => _controller().createApp(request));

    // Roles
    router.get('/api/roles', (Request request) => _controller().getRoles(request));
    router.post('/api/roles', (Request request) => _controller().createRole(request));

    // Modules
    router.get('/api/modules', (Request request) => _controller().getModules(request));
    router.post('/api/modules', (Request request) => _controller().createModule(request));

    // Features
    router.get('/api/features', (Request request) => _controller().getFeatures(request));
    router.post('/api/features', (Request request) => _controller().createFeature(request));

    // Screens
    router.get('/api/screens', (Request request) => _controller().getScreens(request));
    router.post('/api/screens', (Request request) => _controller().createScreen(request));

    // Routes
    router.get('/api/routes', (Request request) => _controller().getRoutes(request));
    router.post('/api/routes', (Request request) => _controller().createRoute(request));

    // APIs
    router.get('/api/apis', (Request request) => _controller().getApis(request));
    router.post('/api/apis', (Request request) => _controller().createApi(request));

    // Permissions
    router.get('/api/permissions', (Request request) => _controller().getPermissions(request));
    router.post('/api/permissions', (Request request) => _controller().createPermission(request));

    // Languages
    router.get('/api/languages', (Request request) => _controller().getLanguages(request));
    router.post('/api/languages', (Request request) => _controller().createLanguage(request));

    // Statuses
    router.get('/api/statuses', (Request request) => _controller().getStatuses(request));
    router.post('/api/statuses', (Request request) => _controller().createStatus(request));

  }
}
