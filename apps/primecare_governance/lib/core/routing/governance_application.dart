import 'package:flutter_core/flutter_core.dart';

class GovernanceApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_governance';

  @override
  String get name => 'PrimeCare Governance Dashboard';

  @override
  PlatformTenant get tenant => PrimeCareTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.ceo,
          dashboardRoute: '/governance/hud',
          modules: [
            GovernanceCEOModule(),
            GovernanceOperationsModule(),
            GovernanceSecurityModule(),
            GovernanceAuditModule(),
          ],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.admin,
          dashboardRoute: '/governance/hud',
          modules: [
            GovernanceOperationsModule(),
            GovernanceSecurityModule(),
            GovernanceAuditModule(),
            GovernanceReferenceModule(),
          ],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.governanceOfficer,
          dashboardRoute: '/governance/hud',
          modules: [
            GovernanceOperationsModule(),
            GovernanceSecurityModule(),
            GovernanceAuditModule(),
            GovernanceReferenceModule(),
          ],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.psw,
          dashboardRoute: '/generated/psw-dashboard',
          modules: [
            GovernancePSWDashboardModule(),
            GovernanceOperationsModule(),
          ],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.qualityAssurance,
          dashboardRoute: '/generated/audit-dashboard',
          modules: [
            GovernanceQualityAssuranceModule(),
            GovernanceAuditModule(),
          ],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.complianceManager,
          dashboardRoute: '/generated/audit-dashboard',
          modules: [
            GovernanceQualityAssuranceModule(),
            GovernanceAuditModule(),
            GovernanceSecurityModule(),
          ],
        ),
      ];
}

class GovernanceCEOModule extends PlatformModule {
  @override
  String get moduleId => 'gov_ceo';
  @override
  String get name => 'Executive Intelligence';
  @override
  IconData get icon => LucideIcons.trendingUp;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.ceo];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Growth Pipeline',
          route: '/generated${CorporateRoutes.ceoGrowthPipeline}',
          requiredRole: PlatformRole.ceo,
          icon: LucideIcons.barChart3,
        ),
        PrimeCareScreen(
          title: 'Regional Performance',
          route: '/generated${CorporateRoutes.ceoRegionPerformance}',
          requiredRole: PlatformRole.ceo,
          icon: LucideIcons.map,
        ),
        PrimeCareScreen(
          title: 'Leadership Reports',
          route: '/generated${CorporateRoutes.ceoLeadershipReports}',
          requiredRole: PlatformRole.ceo,
          icon: LucideIcons.filePieChart,
        ),
      ];
}

class GovernancePSWDashboardModule extends PlatformModule {
  @override
  String get moduleId => 'gov_psw';
  @override
  String get name => 'PSW Care';
  @override
  IconData get icon => LucideIcons.userPlus;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.psw];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Care Dashboard',
          route: '/generated/psw-dashboard',
          requiredRole: PlatformRole.psw,
          icon: LucideIcons.home,
        ),
        PrimeCareScreen(
          title: 'Shift Tracker',
          route: '/generated/psw-shift-tracker',
          requiredRole: PlatformRole.psw,
          icon: LucideIcons.clock,
        ),
        PrimeCareScreen(
          title: 'My Clients',
          route: '/generated/psw-clients',
          requiredRole: PlatformRole.psw,
          icon: LucideIcons.users,
        ),
        PrimeCareScreen(
          title: 'Task List',
          route: '/generated/psw-tasks',
          requiredRole: PlatformRole.psw,
          icon: LucideIcons.checkSquare,
        ),
        PrimeCareScreen(
          title: 'Messages',
          route: '/generated/psw-messages',
          requiredRole: PlatformRole.psw,
          icon: LucideIcons.messageSquare,
        ),
        PrimeCareScreen(
          title: 'Visit Notes',
          route: '/generated/psw-visit-notes',
          requiredRole: PlatformRole.psw,
          icon: LucideIcons.fileText,
        ),
      ];
}

class GovernanceQualityAssuranceModule extends PlatformModule {
  @override
  String get moduleId => 'gov_qa';
  @override
  String get name => 'Quality Assurance';
  @override
  IconData get icon => LucideIcons.shieldAlert;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.qualityAssurance];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Audit Dashboard',
          route: '/generated/audit-dashboard',
          requiredRole: PlatformRole.qualityAssurance,
          icon: LucideIcons.barChart,
        ),
        PrimeCareScreen(
          title: 'Compliance Reviews',
          route: '/generated/compliance-reviews',
          requiredRole: PlatformRole.qualityAssurance,
          icon: LucideIcons.searchCode,
        ),
        PrimeCareScreen(
          title: 'Incident Reports',
          route: '/generated/incident-reports',
          requiredRole: PlatformRole.qualityAssurance,
          icon: LucideIcons.alertTriangle,
        ),
        PrimeCareScreen(
          title: 'Quality Metrics',
          route: '/generated/quality-metrics',
          requiredRole: PlatformRole.qualityAssurance,
          icon: LucideIcons.gauge,
        ),
      ];
}

class GovernanceOperationsModule extends PlatformModule {
  @override
  String get moduleId => 'gov_ops';
  @override
  String get name => 'Operations';
  @override
  IconData get icon => LucideIcons.layoutDashboard;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.admin];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Governance HUD',
          route: '/governance/hud',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.radar,
        ),
        PrimeCareScreen(
          title: 'Control Center',
          route: '/governance/control-center',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.settings,
        ),
        PrimeCareScreen(
          title: 'Proposals',
          route: '/proposals',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.inbox,
        ),
      ];
}

class GovernanceSecurityModule extends PlatformModule {
  @override
  String get moduleId => 'gov_security';
  @override
  String get name => 'Security';
  @override
  IconData get icon => LucideIcons.shieldCheck;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.admin];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Security Hub',
          route: '/governance/device-security',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.shield,
        ),
        PrimeCareScreen(
          title: 'Security Sentinel',
          route: '/governance/security',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.lock,
        ),
        PrimeCareScreen(
          title: 'Verification Center',
          route: '/verification',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.checkCircle,
        ),
      ];
}

class GovernanceAuditModule extends PlatformModule {
  @override
  String get moduleId => 'gov_audit';
  @override
  String get name => 'Audit & Quality';
  @override
  IconData get icon => LucideIcons.clipboardList;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.admin];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Audit Log',
          route: '/governance/audit',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.history,
        ),
        PrimeCareScreen(
          title: 'Monitoring',
          route: '/governance/monitoring',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.activity,
        ),
        PrimeCareScreen(
          title: 'Ticket Center',
          route: '/governance/tickets',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.ticket,
        ),
        PrimeCareScreen(
          title: 'Screen Status',
          route: '/governance/screen-status',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.listChecks,
        ),
      ];
}

class GovernanceReferenceModule extends PlatformModule {
  @override
  String get moduleId => 'gov_ref';
  @override
  String get name => 'Reference';
  @override
  IconData get icon => LucideIcons.library;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.admin];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Clinical Reference',
          route: '/governance/clinical-reference',
          requiredRole: PlatformRole.admin,
          icon: LucideIcons.bookOpen,
        ),
      ];
}
