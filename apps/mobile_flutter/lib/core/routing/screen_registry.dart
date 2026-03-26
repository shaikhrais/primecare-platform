import 'package:flutter/material.dart';

// Phase 24 Baseline Screens
import 'package:primecare_mobile/features/roles/psw/psw_home_screen.dart';
import 'package:primecare_mobile/features/roles/psw/psw_live_visit_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/coordinator_hub_screen.dart';
import 'package:primecare_mobile/features/roles/superuser/superuser_control_screen.dart';
import 'package:primecare_mobile/features/master/shared/role_sow_screen.dart';
import 'package:primecare_mobile/features/roles/client/client_wellness_pulse_screen.dart';
import 'package:primecare_mobile/features/roles/admin/admin_audit_screen.dart';

// Phase 24 Expanded Enterprise Role Matrices
import 'package:primecare_mobile/features/roles/rn/rn_patients_screen.dart';
import 'package:primecare_mobile/features/roles/manager/screens/manager_incidents_screen.dart';
import 'package:primecare_mobile/features/roles/gm/gm_executive_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/scrum_master/scrum_master_ops_screen.dart';
import 'package:primecare_mobile/features/roles/mt/mt_analytics_hub_screen.dart';

// Phase 24 Navigation Bottom Tab Extensions
import 'package:primecare_mobile/features/roles/psw/psw_timesheet_screen.dart';
import 'package:primecare_mobile/features/roles/psw/psw_earnings_screen.dart';
import 'package:primecare_mobile/features/roles/rn/rn_care_plan_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/coordinator_approvals_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/screens/coordinator_callin_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/screens/coordinator_visit_adjustment_screen.dart';
import 'package:primecare_mobile/features/roles/manager/manager_teams_screen.dart';
import 'package:primecare_mobile/features/roles/manager/manager_payroll_screen.dart';
import 'package:primecare_mobile/features/roles/admin/admin_telemetry_screen.dart';
import 'package:primecare_mobile/features/roles/client/client_dispatch_tracker_screen.dart';
import 'package:primecare_mobile/features/master/payment/presentation/screens/client_payments_screen.dart';
import 'package:primecare_mobile/features/roles/gm/gm_pnl_screen.dart';
import 'package:primecare_mobile/features/roles/mt/mt_surge_config_screen.dart';
import 'package:primecare_mobile/features/roles/superuser/superuser_territory_map_screen.dart';
import 'package:primecare_mobile/features/roles/superuser/superuser_registry_sync_screen.dart';
import 'package:primecare_mobile/features/master/shared/universal_inbox_screen.dart';

/// Enterprise Reflection Registry
/// Resolves raw Database Schema string paths to natively compiled UI Widget trees.
class ScreenRegistry {
  static Widget resolveScreen(String name, Map<String, String> parameters) {
    switch (name) {
      // Phase 24 Baseline
      case 'PSW Home':
      case 'psw_home':
        return const PswHomeScreen();
      case 'PSW Live Visit':
      case 'psw_live_visit':
        return const PswLiveVisitScreen();
      case 'Coordinator Matrix':
      case 'coordinator_hub':
        return const CoordinatorHubScreen();
      case 'Admin Matrix':
      case 'admin_home':
        return const AdminAuditScreen();
      case 'Superuser Command':
      case 'superuser_home':
        return const SuperuserControlScreen();
      case 'Role Scope of Work':
      case 'role_sow':
        return const RoleSowScreen();
      case 'Client Care Feed':
      case 'client_care_feed':
        return const ClientWellnessPulseScreen();
        
      // Phase 24 Expanded Telemetry Rules
      case 'RN Medical Desk':
      case 'rn_home':
        return const RnPatientsScreen();
      case 'Manager Dashboard':
      case 'manager_home':
        return const ManagerIncidentsScreen();
      case 'Scrum Master Ops':
      case 'scrum_master_home':
        return const ScrumMasterOpsScreen();
      case 'GM Executive':
      case 'gm_home':
        return const GmExecutiveDashboardScreen();
      case 'MT Analytics Hub':
      case 'mt_home':
        return const MtAnalyticsHubScreen();

      // Navigation Bar Extensions
      case 'psw_timesheet': return const PswTimesheetScreen();
      case 'psw_earnings': return const PswEarningsScreen();
      case 'rn_care_plan': return const RnCarePlanScreen();
      case 'coordinator_approvals': return const CoordinatorApprovalsScreen();
      case 'coordinator_callin': return const CoordinatorCallinScreen();
      case 'coordinator_visit_adjust': return const CoordinatorVisitAdjustmentScreen();
      case 'manager_teams': return const ManagerTeamsScreen();
      case 'manager_payroll': return const ManagerPayrollScreen();
      case 'manager_incidents': return const ManagerIncidentsScreen();
      case 'admin_telemetry': return const AdminTelemetryScreen();
      case 'client_pulse': return const ClientWellnessPulseScreen();
      case 'client_dispatch': return const ClientDispatchTrackerScreen();
      case 'client_payments': return const ClientPaymentsScreen();
      case 'gm_pnl': return const GmPnlScreen();
      case 'mt_surge': return const MtSurgeConfigScreen();
      case 'superuser_territory': return const SuperuserTerritoryMapScreen();
      case 'superuser_registry': return const SuperuserRegistrySyncScreen();
      case 'universal_inbox': 
        return UniversalInboxScreen(rolePrefix: parameters['role'] ?? 'universal');
        
      // Fault Tolerance Engine
      default:
        return Scaffold(
          appBar: AppBar(title: const Text('Dynamic Route Mismatch')),
          body: Center(
            child: Text(
              'Dynamic Route Engine failed to resolve Widget: "$name"\nVerify the Backend payload array matches the Flutter `ScreenRegistry`.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.orangeAccent, fontSize: 16),
            ),
          ),
        );
    }
  }
}
