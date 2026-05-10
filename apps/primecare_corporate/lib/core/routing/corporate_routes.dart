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

class CorporateLeadershipModule extends PlatformModule {
  @override
  String get moduleId => 'corporate_leadership';

  @override
  String get name => 'Leadership';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.ceo,
    PlatformRole.coo,
    PlatformRole.cfo,
    PlatformRole.cto,
    PlatformRole.shareholder,
    PlatformRole.corporate,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'CEO Dashboard',
      route: CorporateRoutes.ceoDashboard,
      requiredRole: PlatformRole.ceo,
    ),
    PrimeCareScreen(
      title: 'COO Dashboard',
      route: CorporateRoutes.cooDashboard,
      requiredRole: PlatformRole.coo,
    ),
    PrimeCareScreen(
      title: 'CFO Dashboard',
      route: CorporateRoutes.cfoDashboard,
      requiredRole: PlatformRole.cfo,
    ),
    PrimeCareScreen(
      title: 'CTO Dashboard',
      route: CorporateRoutes.ctoDashboard,
      requiredRole: PlatformRole.cto,
    ),
    PrimeCareScreen(
      title: 'CTO Verification Hub',
      route: CorporateRoutes.ctoVerificationHub,
      requiredRole: PlatformRole.cto,
    ),
  ];
}

class CorporateApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_corporate';

  @override
  String get name => 'PrimeCare Corporate Portal';

  @override
  PlatformTenant get tenant => PrimeCareTenant();

  @override
  List<PlatformModule> get modules => [CorporateLeadershipModule()];
}
