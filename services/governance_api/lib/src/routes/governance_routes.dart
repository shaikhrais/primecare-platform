// Governance - Category: middleware | Purpose: Sanity / Test routes Apps Roles Modules Features
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/governance_controller.dart';

class GovernanceRoutes {
  static Router get router {
    final router = Router();

    // Sanity / Test routes
    router.get('/', (Request request) => Response.ok('Hello, World!\n'));
    router.get('/echo/<message>', (Request request, String message) => Response.ok('$message\n'));

    // Apps
    router.get('/api/apps', GovernanceController.getApps);
    router.post('/api/apps', GovernanceController.createApp);

    // Roles
    router.get('/api/roles', GovernanceController.getRoles);
    router.post('/api/roles', GovernanceController.createRole);

    // Modules
    router.get('/api/modules', GovernanceController.getModules);
    router.post('/api/modules', GovernanceController.createModule);

    // Features
    router.get('/api/features', GovernanceController.getFeatures);
    router.post('/api/features', GovernanceController.createFeature);

    // Screens
    router.get('/api/screens', GovernanceController.getScreens);
    router.post('/api/screens', GovernanceController.createScreen);

    // Routes
    router.get('/api/routes', GovernanceController.getRoutes);
    router.post('/api/routes', GovernanceController.createRoute);

    // APIs
    router.get('/api/apis', GovernanceController.getApis);
    router.post('/api/apis', GovernanceController.createApi);

    // Permissions
    router.get('/api/permissions', GovernanceController.getPermissions);
    router.post('/api/permissions', GovernanceController.createPermission);

    // Languages
    router.get('/api/languages', GovernanceController.getLanguages);
    router.post('/api/languages', GovernanceController.createLanguage);

    // Statuses
    router.get('/api/statuses', GovernanceController.getStatuses);
    router.post('/api/statuses', GovernanceController.createStatus);

    return router;
  }
}
