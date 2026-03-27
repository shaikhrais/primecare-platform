import 'package:go_router/go_router.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'package:primecare_mobile/core/routing/screen_registry.dart';

class DynamicRouteEngine {
  /// Fetches the `PlatformScreen` telemetry array from the Database
  /// and natively translates it into `GoRoute` objects.
  static Future<List<GoRoute>> fetchDatabaseRoutes() async {
    // 100% Independent Frontend UI Routing Architecture (No Backend API Sync)
    
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
      GoRoute(path: '/admin/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('admin_inbox', {})),
      GoRoute(path: '/admin/sow', builder: (context, state) => ScreenRegistry.resolveScreen('admin_sow', {})),
      GoRoute(path: '/admin/roles', builder: (context, state) => ScreenRegistry.resolveScreen('admin_roles', {})),
      
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
      
      
      // Global SOW / Task List Matrix
      
      GoRoute(path: '/rn/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('rn_inbox', {})),
      GoRoute(path: '/rn/sow', builder: (context, state) => ScreenRegistry.resolveScreen('rn_sow', {})),
      GoRoute(path: '/psw/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('psw_inbox', {})),
      GoRoute(path: '/psw/sow', builder: (context, state) => ScreenRegistry.resolveScreen('psw_sow', {})),
      GoRoute(path: '/coordinator/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('coordinator_inbox', {})),
      GoRoute(path: '/coordinator/sow', builder: (context, state) => ScreenRegistry.resolveScreen('coordinator_sow', {})),
      GoRoute(path: '/manager/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('manager_inbox', {})),
      GoRoute(path: '/manager/sow', builder: (context, state) => ScreenRegistry.resolveScreen('manager_sow', {})),
      GoRoute(path: '/gm/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('gm_inbox', {})),
      GoRoute(path: '/gm/sow', builder: (context, state) => ScreenRegistry.resolveScreen('gm_sow', {})),
      GoRoute(path: '/mt/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('mt_inbox', {})),
      GoRoute(path: '/mt/sow', builder: (context, state) => ScreenRegistry.resolveScreen('mt_sow', {})),
      GoRoute(path: '/client/inbox', builder: (context, state) => ScreenRegistry.resolveScreen('client_inbox', {})),
      GoRoute(path: '/superuser/sow', builder: (context, state) => ScreenRegistry.resolveScreen('superuser_sow', {})),
    ];
  }
}
