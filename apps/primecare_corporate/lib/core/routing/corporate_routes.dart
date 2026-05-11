import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class PrimeCareTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_hq';

  @override
  String get name => 'PrimeCare';

  @override
  ThemeData get branding => ThemeData.light();
}

class CEOModule extends PlatformModule {
  @override
  String get moduleId => 'ceo_leadership';
  @override
  String get name => 'CEO Dashboard';
  @override
  IconData get icon => Icons.admin_panel_settings;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.ceo];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'CEO Overview',
          route: CorporateRoutes.ceoDashboard,
          requiredRole: PlatformRole.ceo,
          icon: LucideIcons.layoutDashboard,
        ),
        PrimeCareScreen(
          title: tr('corporate.ceo_enterprise_overview'),
          route: CorporateRoutes.ceoEnterpriseOverview,
          requiredRole: PlatformRole.ceo,
          icon: LucideIcons.building,
        ),
        PrimeCareScreen(
          title: tr('corporate.ceo_franchise_overview'),
          route: CorporateRoutes.ceoFranchiseOverview,
          requiredRole: PlatformRole.ceo,
          icon: LucideIcons.briefcase,
        ),
        PrimeCareScreen(
          title: tr('corporate.ceo_strategic_kpis'),
          route: CorporateRoutes.ceoStrategicKpis,
          requiredRole: PlatformRole.ceo,
          icon: LucideIcons.trendingUp,
        ),
        PrimeCareScreen(
          title: tr('corporate.ceo_revenue_summary'),
          route: CorporateRoutes.ceoRevenueSummary,
          requiredRole: PlatformRole.ceo,
          icon: LucideIcons.dollarSign,
        ),
      ];
}

class COOModule extends PlatformModule {
  @override
  String get moduleId => 'coo_ops';
  @override
  String get name => 'Operations';
  @override
  IconData get icon => Icons.settings_applications_outlined;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.coo];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'COO Dashboard',
          route: CorporateRoutes.cooDashboard,
          requiredRole: PlatformRole.coo,
          icon: LucideIcons.settings,
        ),
      ];
}

class CFOModule extends PlatformModule {
  @override
  String get moduleId => 'cfo_finance';
  @override
  String get name => 'Finance';
  @override
  IconData get icon => Icons.account_balance_outlined;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.cfo];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'CFO Dashboard',
          route: CorporateRoutes.cfoDashboard,
          requiredRole: PlatformRole.cfo,
          icon: LucideIcons.wallet,
        ),
      ];
}

class CTOModule extends PlatformModule {
  @override
  String get moduleId => 'cto_tech';
  @override
  String get name => 'Technology';
  @override
  IconData get icon => Icons.memory_outlined;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.cto];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'CTO Dashboard',
          route: CorporateRoutes.ctoDashboard,
          requiredRole: PlatformRole.cto,
          icon: LucideIcons.cpu,
        ),
        PrimeCareScreen(
          title: 'Verification Hub',
          route: CorporateRoutes.ctoVerificationHub,
          requiredRole: PlatformRole.cto,
          icon: LucideIcons.clipboardCheck,
        ),
      ];
}

class LegalModule extends PlatformModule {
  @override
  String get moduleId => 'legal_compliance';
  @override
  String get name => 'Legal & Compliance';
  @override
  IconData get icon => Icons.gavel_outlined;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.legal];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'Legal Dashboard',
          route: CorporateRoutes.legalDashboard,
          requiredRole: PlatformRole.legal,
          icon: LucideIcons.gavel,
        ),
      ];
}

class CISOModule extends PlatformModule {
  @override
  String get moduleId => 'ciso_security';
  @override
  String get name => 'Security';
  @override
  IconData get icon => Icons.security_outlined;
  @override
  List<PlatformRole> get allowedRoles => [PlatformRole.ciso];
  @override
  List<PrimeCareScreen> get screens => [
        PrimeCareScreen(
          title: 'CISO Dashboard',
          route: CorporateRoutes.cisoDashboard,
          requiredRole: PlatformRole.ciso,
          icon: LucideIcons.shieldCheck,
        ),
      ];
}

class CorporateApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_corporate';
  @override
  String get name => 'PrimeCare Corporate Portal';
  @override
  String get homeRoute => CorporateRoutes.ceoDashboard;
  @override
  PlatformTenant get tenant => PrimeCareTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.ceo,
          dashboardRoute: CorporateRoutes.ceoDashboard,
          modules: [CEOModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.coo,
          dashboardRoute: CorporateRoutes.cooDashboard,
          modules: [COOModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.cfo,
          dashboardRoute: CorporateRoutes.cfoDashboard,
          modules: [CFOModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.cto,
          dashboardRoute: CorporateRoutes.ctoDashboard,
          modules: [CTOModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.legal,
          dashboardRoute: CorporateRoutes.legalDashboard,
          modules: [LegalModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.ciso,
          dashboardRoute: CorporateRoutes.cisoDashboard,
          modules: [CISOModule()],
        ),
      ];
}
