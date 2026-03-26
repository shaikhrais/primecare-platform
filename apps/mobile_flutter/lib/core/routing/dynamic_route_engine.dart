import 'package:go_router/go_router.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/core/routing/screen_registry.dart';

class DynamicRouteEngine {
  /// Fetches the `PlatformScreen` telemetry array from the Database
  /// and natively translates it into `GoRoute` objects.
  static Future<List<GoRoute>> fetchDatabaseRoutes() async {
    try {
      final response = await ApiClient().get('/v1/public/screens');
      
      // Handle the dynamic PrimeCare raw JSON decoding
      if (response != null && response.containsKey('data')) {
        final List<dynamic> screensList = response['data'];
        List<GoRoute> generatedRoutes = [];

        for (var screen in screensList) {
          if (screen['status'] != 'active') continue;
          
          final routePath = screen['route'];
          final screenName = screen['name'];

          generatedRoutes.add(
            GoRoute(
              path: routePath,
              builder: (context, state) => ScreenRegistry.resolveScreen(screenName, state.pathParameters),
            )
          );
        }
        // Forcibly inject new Admin Modules decoupled from external Prisma sync constraints
        generatedRoutes.add(
          GoRoute(path: '/admin/forms', builder: (context, state) => ScreenRegistry.resolveScreen('admin_forms', {})),
        );
        
        print('[DynamicRouteEngine] Successfully compiled ${generatedRoutes.length} database routes natively.');
        return generatedRoutes;
      }
    } catch (e) {
      print('[DynamicRouteEngine] Fallback to Offline Mock Matrix: $e');
    }
    
    // Core structural offline fallback covering ALL 9 PrimeCare roles natively
    return [
      GoRoute(path: '/psw/home', builder: (context, state) => ScreenRegistry.resolveScreen('PSW Home', {})),
      GoRoute(path: '/psw/timesheets', builder: (context, state) => ScreenRegistry.resolveScreen('psw_timesheet', {})),
      GoRoute(path: '/psw/earnings', builder: (context, state) => ScreenRegistry.resolveScreen('psw_earnings', {})),
      
      GoRoute(path: '/rn/home', builder: (context, state) => ScreenRegistry.resolveScreen('RN Medical Desk', {})),
      GoRoute(path: '/rn/care-plan', builder: (context, state) => ScreenRegistry.resolveScreen('rn_care_plan', {})),
      
      GoRoute(path: '/coordinator/home', builder: (context, state) => ScreenRegistry.resolveScreen('Coordinator Matrix', {})),
      GoRoute(path: '/coordinator/approvals', builder: (context, state) => ScreenRegistry.resolveScreen('coordinator_approvals', {})),
      GoRoute(path: '/coordinator/callin', builder: (context, state) => ScreenRegistry.resolveScreen('coordinator_callin', {})),
      GoRoute(path: '/coordinator/visit-adjust', builder: (context, state) => ScreenRegistry.resolveScreen('coordinator_visit_adjust', {})),
      
      GoRoute(path: '/manager/home', builder: (context, state) => ScreenRegistry.resolveScreen('Manager Dashboard', {})),
      GoRoute(path: '/manager/teams', builder: (context, state) => ScreenRegistry.resolveScreen('manager_teams', {})),
      GoRoute(path: '/manager/payroll', builder: (context, state) => ScreenRegistry.resolveScreen('manager_payroll', {})),
      GoRoute(path: '/manager/incidents', builder: (context, state) => ScreenRegistry.resolveScreen('manager_incidents', {})),
      
      GoRoute(path: '/admin/home', builder: (context, state) => ScreenRegistry.resolveScreen('Admin Matrix', {})),
      GoRoute(path: '/admin/audit', builder: (context, state) => ScreenRegistry.resolveScreen('Admin Matrix', {})), // Route explicitly matches audit screen
      GoRoute(path: '/admin/telemetry', builder: (context, state) => ScreenRegistry.resolveScreen('admin_telemetry', {})),
      GoRoute(path: '/admin/forms', builder: (context, state) => ScreenRegistry.resolveScreen('admin_forms', {})),
      
      GoRoute(path: '/client/home', builder: (context, state) => ScreenRegistry.resolveScreen('Client Care Feed', {})),
      GoRoute(path: '/client/pulse', builder: (context, state) => ScreenRegistry.resolveScreen('client_pulse', {})),
      GoRoute(path: '/client/dispatch', builder: (context, state) => ScreenRegistry.resolveScreen('client_dispatch', {})),
      GoRoute(path: '/client/payments', builder: (context, state) => ScreenRegistry.resolveScreen('client_payments', {})),
      
      GoRoute(path: '/superuser/home', builder: (context, state) => ScreenRegistry.resolveScreen('Superuser Command', {})),
      GoRoute(path: '/superuser/territory', builder: (context, state) => ScreenRegistry.resolveScreen('superuser_territory', {})),
      GoRoute(path: '/superuser/registry', builder: (context, state) => ScreenRegistry.resolveScreen('superuser_registry', {})),
      
      GoRoute(path: '/scrum_master/home', builder: (context, state) => ScreenRegistry.resolveScreen('Scrum Master Ops', {})),
      GoRoute(path: '/gm/home', builder: (context, state) => ScreenRegistry.resolveScreen('GM Executive', {})),
      GoRoute(path: '/gm_home', builder: (context, state) => ScreenRegistry.resolveScreen('GM Executive', {})), // Sidebar mapped to /gm_home
      GoRoute(path: '/gm/pnl', builder: (context, state) => ScreenRegistry.resolveScreen('gm_pnl', {})),
      
      GoRoute(path: '/mt/home', builder: (context, state) => ScreenRegistry.resolveScreen('MT Analytics Hub', {})),
      GoRoute(path: '/mt/surge-config', builder: (context, state) => ScreenRegistry.resolveScreen('mt_surge', {})),
      
      // Global Inbox Interceptors
      GoRoute(path: '/universal/:role/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('universal_inbox', {})),
      
      // Global SOW / Task List Matrix
      GoRoute(path: '/universal/sow', builder: (context, state) => ScreenRegistry.resolveScreen('role_sow', {})),
    ];
  }
}
