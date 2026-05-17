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
          dashboardRoute: ClinicalRoutes.pswDashboard,
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
          icon: LucideIcons.barChart3,
        ),
        PrimeCareScreen(
          title: 'Regional Performance',
          route: '/generated${CorporateRoutes.ceoRegionPerformance}',
          icon: LucideIcons.map,
        ),
        PrimeCareScreen(
          title: 'Leadership Reports',
          route: '/generated${CorporateRoutes.ceoLeadershipReports}',
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
          route: ClinicalRoutes.pswDashboard,
          icon: LucideIcons.home,
        ),
        PrimeCareScreen(
          title: 'Shift Tracker',
          route: ClinicalRoutes.pswSchedule,
          icon: LucideIcons.clock,
        ),
        PrimeCareScreen(
          title: 'My Clients',
          route: ClinicalRoutes.pswPatientProfile,
          icon: LucideIcons.users,
        ),
        PrimeCareScreen(
          title: 'Task List',
          route: ClinicalRoutes.pswVisitChecklist,
          icon: LucideIcons.checkSquare,
        ),
        PrimeCareScreen(
          title: 'Messages',
          route: ClinicalRoutes.pswMessages,
          icon: LucideIcons.messageSquare,
        ),
        PrimeCareScreen(
          title: 'Visit Notes',
          route: ClinicalRoutes.pswVisitNotes,
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
          icon: LucideIcons.barChart,
        ),
        PrimeCareScreen(
          title: 'Compliance Reviews',
          route: '/generated/compliance-reviews',
          icon: LucideIcons.searchCode,
        ),
        PrimeCareScreen(
          title: 'Incident Reports',
          route: '/generated/incident-reports',
          icon: LucideIcons.alertTriangle,
        ),
        PrimeCareScreen(
          title: 'Quality Metrics',
          route: '/generated/quality-metrics',
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
          icon: LucideIcons.radar,
        ),
        PrimeCareScreen(
          title: 'Control Center',
          route: '/governance/control-center',
          icon: LucideIcons.settings,
        ),
        PrimeCareScreen(
          title: 'Proposals',
          route: '/proposals',
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
          icon: LucideIcons.shield,
        ),
        PrimeCareScreen(
          title: 'Security Sentinel',
          route: '/governance/security',
          icon: LucideIcons.lock,
        ),
        PrimeCareScreen(
          title: 'Verification Center',
          route: '/verification',
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
          icon: LucideIcons.history,
        ),
        PrimeCareScreen(
          title: 'Monitoring',
          route: '/governance/monitoring',
          icon: LucideIcons.activity,
        ),
        PrimeCareScreen(
          title: 'Ticket Center',
          route: '/governance/tickets',
          icon: LucideIcons.ticket,
        ),
        PrimeCareScreen(
          title: 'Screen Status',
          route: '/governance/screen-status',
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
          icon: LucideIcons.bookOpen,
        ),
      ];
}
