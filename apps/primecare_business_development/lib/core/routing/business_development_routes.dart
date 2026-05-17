import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

class BusinessDevelopmentTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_business_development';

  @override
  String get name => 'PrimeCare Business Development';

  @override
  ThemeData get branding => ThemeData.light();
}

class BusinessDevelopmentOperationsModule extends PlatformModule {
  @override
  String get moduleId => 'business_development_operations';

  @override
  String get name => 'Business Development';

  @override
  IconData get icon => Icons.trending_up;

  @override
  List<PlatformRole> get allowedRoles => [
    PlatformRole.regionalManagerOntario,
    PlatformRole.regionalManagerUsa,
    PlatformRole.franchiseSalesManager,
    PlatformRole.partnershipManager,
    PlatformRole.territoryExpansionManager,
    PlatformRole.generalManager,
    PlatformRole.regionalBdm,
    PlatformRole.systemVerification,
  ];

  @override
  List<PrimeCareScreen> get screens => [
    PrimeCareScreen(
      title: 'Regional Manager Ontario Dashboard',
      route: BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
),
    PrimeCareScreen(
      title: 'Regional Manager USA Dashboard',
      route: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Dashboard',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
),
    PrimeCareScreen(
      title: 'Partnership Manager Dashboard',
      route: BusinessDevelopmentRoutes.partnershipManagerDashboard,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Dashboard',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
),
    PrimeCareScreen(
      title: 'General Manager Dashboard',
      route: BusinessDevelopmentRoutes.generalManagerDashboard,
),
    PrimeCareScreen(
      title: 'Regional BDM Dashboard',
      route: BusinessDevelopmentRoutes.regionalBdmDashboard,
),
    PrimeCareScreen(
      title: 'Regional BDM Leads',
      route: BusinessDevelopmentRoutes.regionalBdmLeads,
),
    PrimeCareScreen(
      title: 'Regional BDM Franchise Pipeline',
      route: BusinessDevelopmentRoutes.regionalBdmFranchisePipeline,
),
    PrimeCareScreen(
      title: 'Regional BDM Territory Growth',
      route: BusinessDevelopmentRoutes.regionalBdmTerritoryGrowth,
),
    PrimeCareScreen(
      title: 'Regional BDM Meetings',
      route: BusinessDevelopmentRoutes.regionalBdmMeetings,
),
    PrimeCareScreen(
      title: 'Regional BDM Deal Tracker',
      route: BusinessDevelopmentRoutes.regionalBdmDealTracker,
),
    PrimeCareScreen(
      title: 'Regional BDM Partners',
      route: BusinessDevelopmentRoutes.regionalBdmPartners,
),
    PrimeCareScreen(
      title: 'Regional BDM Competitor Notes',
      route: BusinessDevelopmentRoutes.regionalBdmCompetitorNotes,
),
    PrimeCareScreen(
      title: 'Regional BDM Tasks',
      route: BusinessDevelopmentRoutes.regionalBdmTasks,
),
    PrimeCareScreen(
      title: 'Regional BDM Reports',
      route: BusinessDevelopmentRoutes.regionalBdmReports,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Leads',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerLeads,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Prospects',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerProspects,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Discovery Calls',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerDiscoveryCalls,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Proposals',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerProposals,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Sales Pipeline',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerSalesPipeline,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Contracts',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerContracts,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Follow Ups',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerFollowUps,
),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Reports',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerReports,
),
    PrimeCareScreen(
      title: 'Partnership Manager Partners',
      route: BusinessDevelopmentRoutes.partnershipManagerPartners,
),
    PrimeCareScreen(
      title: 'Partnership Manager Outreach',
      route: BusinessDevelopmentRoutes.partnershipManagerOutreach,
),
    PrimeCareScreen(
      title: 'Partnership Manager Active Deals',
      route: BusinessDevelopmentRoutes.partnershipManagerActiveDeals,
),
    PrimeCareScreen(
      title: 'Partnership Manager Proposals',
      route: BusinessDevelopmentRoutes.partnershipManagerProposals,
),
    PrimeCareScreen(
      title: 'Partnership Manager Renewals',
      route: BusinessDevelopmentRoutes.partnershipManagerRenewals,
),
    PrimeCareScreen(
      title: 'Partnership Manager Reports',
      route: BusinessDevelopmentRoutes.partnershipManagerReports,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Territory Map',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerTerritoryMap,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Market Research',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerMarketResearch,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Demographics',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerDemographics,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Open Territories',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerOpenTerritories,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Expansion Plans',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerExpansionPlans,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Site Selection',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerSiteSelection,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Forecast',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerForecast,
),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Reports',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerReports,
),
    PrimeCareScreen(
      title: 'System Verification',
      route: '/offices/system-verification',
),
  ];
}

class BusinessDevelopmentApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_business_development';

  @override
  String get name => 'PrimeCare Business Development Portal';

  @override
  PlatformTenant get tenant => BusinessDevelopmentTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
        PlatformRoleDefinition(
          role: PlatformRole.regionalManagerOntario,
          dashboardRoute: BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
          modules: [BusinessDevelopmentOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.regionalManagerUsa,
          dashboardRoute: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
          modules: [BusinessDevelopmentOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.franchiseSalesManager,
          dashboardRoute: BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
          modules: [BusinessDevelopmentOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.partnershipManager,
          dashboardRoute: BusinessDevelopmentRoutes.partnershipManagerDashboard,
          modules: [BusinessDevelopmentOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.territoryExpansionManager,
          dashboardRoute: BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
          modules: [BusinessDevelopmentOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.generalManager,
          dashboardRoute: BusinessDevelopmentRoutes.generalManagerDashboard,
          modules: [BusinessDevelopmentOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.regionalBdm,
          dashboardRoute: BusinessDevelopmentRoutes.regionalBdmDashboard,
          modules: [BusinessDevelopmentOperationsModule()],
        ),
        PlatformRoleDefinition(
          role: PlatformRole.systemVerification,
          dashboardRoute: '/offices/system-verification',
          modules: [BusinessDevelopmentOperationsModule()],
        ),
      ];
}
