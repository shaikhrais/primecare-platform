import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart' hide ScreenRegistry;
import 'screen_registry.dart';
import '../ui/dynamic_screen_view.dart';
import '../ui/app_drawer.dart';
import '../../features/auth/login_view.dart';

import '../../features/operations/care_angel_management_view.dart';
import '../../features/governance_operations/governance_operations_view.dart';
import '../../features/system_governance/verification_center_view.dart';
import '../../features/system_governance/audit_log_view.dart';
import '../../features/system_governance/governance_data_entry_view.dart';
import '../../features/system_governance/system_monitoring_view.dart';
import '../../features/system_governance/correction_ticket_center_view.dart';
import '../../features/proposal_governance/views/proposal_inbox_view.dart';
import '../../features/proposal_governance/views/new_proposal_form.dart';
import '../../features/proposal_governance/views/proposal_detail_view.dart';

/// A factory to map registry IDs to specific view implementations
final Map<String, WidgetBuilder> _viewFactory = {
  'SCREEN_1': (context) => const GovernanceOperationsView(),
  'SCREEN_12': (context) => const CareAngelManagementView(),
  'VERIFICATION_CENTER': (context) => const VerificationCenterView(),
  'AUDIT_LOG': (context) => const AuditLogView(),
  'DATA_ENTRY': (context) => const GovernanceDataEntryView(),
  'MONITORING': (context) => const SystemMonitoringView(),
  'TICKET_CENTER': (context) => const CorrectionTicketCenterView(),
};

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      ShellRoute(
        builder: (context, state, child) => MasterLayout(
          shellType: AppShellType.admin,
          drawer: const AppDrawer(),
          child: child,
        ),
        routes: [
          // Dashboard Root
          GoRoute(
            path: '/',
            builder: (context, state) => const DynamicRoleDashboardScreen(role: 'admin'),
          ),
          GoRoute(
            path: '/verification',
            builder: (context, state) => const VerificationCenterView(),
          ),
          GoRoute(
            path: '/governance/monitoring',
            builder: (context, state) => const SystemMonitoringView(),
          ),
          GoRoute(
            path: '/governance/data-entry',
            builder: (context, state) => const GovernanceDataEntryView(),
          ),
          GoRoute(
            path: '/governance/audit',
            builder: (context, state) => const AuditLogView(),
          ),
          GoRoute(
            path: '/governance/tickets',
            builder: (context, state) => const CorrectionTicketCenterView(),
          ),
          
          // Proposal Governance
          GoRoute(
            path: '/proposals',
            builder: (context, state) => const ProposalInboxView(),
          ),
          GoRoute(
            path: '/proposals/new',
            builder: (context, state) => const NewProposalForm(),
          ),
          GoRoute(
            path: '/proposals/detail/:id',
            builder: (context, state) => ProposalDetailView(proposalId: state.pathParameters['id']!),
          ),
          
          // Dynamic Registry-Driven Routes (251 Screens)
          ...ScreenRegistry.screens.values.map((screen) {
            final factoryBuilder = _viewFactory[screen.id];
            
            return GoRoute(
              path: screen.routePath,
              builder: (context, state) => factoryBuilder != null 
                ? factoryBuilder(context)
                : DynamicScreenView(metadata: screen),
            );
          }),
        ],
      ),
    ],
  );
});

