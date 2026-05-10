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
      requiredRole: PlatformRole.regionalManagerOntario,
    ),
    PrimeCareScreen(
      title: 'Regional Manager USA Dashboard',
      route: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
      requiredRole: PlatformRole.regionalManagerUsa,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Dashboard',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Dashboard',
      route: BusinessDevelopmentRoutes.partnershipManagerDashboard,
      requiredRole: PlatformRole.partnershipManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Dashboard',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'General Manager Dashboard',
      route: BusinessDevelopmentRoutes.generalManagerDashboard,
      requiredRole: PlatformRole.generalManager,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Dashboard',
      route: BusinessDevelopmentRoutes.regionalBdmDashboard,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Leads',
      route: BusinessDevelopmentRoutes.regionalBdmLeads,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Franchise Pipeline',
      route: BusinessDevelopmentRoutes.regionalBdmFranchisePipeline,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Territory Growth',
      route: BusinessDevelopmentRoutes.regionalBdmTerritoryGrowth,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Meetings',
      route: BusinessDevelopmentRoutes.regionalBdmMeetings,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Deal Tracker',
      route: BusinessDevelopmentRoutes.regionalBdmDealTracker,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Partners',
      route: BusinessDevelopmentRoutes.regionalBdmPartners,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Competitor Notes',
      route: BusinessDevelopmentRoutes.regionalBdmCompetitorNotes,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Tasks',
      route: BusinessDevelopmentRoutes.regionalBdmTasks,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Regional BDM Reports',
      route: BusinessDevelopmentRoutes.regionalBdmReports,
      requiredRole: PlatformRole.regionalBdm,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Leads',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerLeads,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Prospects',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerProspects,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Discovery Calls',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerDiscoveryCalls,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Proposals',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerProposals,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Sales Pipeline',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerSalesPipeline,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Contracts',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerContracts,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Follow Ups',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerFollowUps,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Reports',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerReports,
      requiredRole: PlatformRole.franchiseSalesManager,
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Partners',
      route: BusinessDevelopmentRoutes.partnershipManagerPartners,
      requiredRole: PlatformRole.partnershipManager,
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Outreach',
      route: BusinessDevelopmentRoutes.partnershipManagerOutreach,
      requiredRole: PlatformRole.partnershipManager,
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Active Deals',
      route: BusinessDevelopmentRoutes.partnershipManagerActiveDeals,
      requiredRole: PlatformRole.partnershipManager,
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Proposals',
      route: BusinessDevelopmentRoutes.partnershipManagerProposals,
      requiredRole: PlatformRole.partnershipManager,
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Renewals',
      route: BusinessDevelopmentRoutes.partnershipManagerRenewals,
      requiredRole: PlatformRole.partnershipManager,
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Reports',
      route: BusinessDevelopmentRoutes.partnershipManagerReports,
      requiredRole: PlatformRole.partnershipManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Territory Map',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerTerritoryMap,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Market Research',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerMarketResearch,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Demographics',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerDemographics,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Open Territories',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerOpenTerritories,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Expansion Plans',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerExpansionPlans,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Site Selection',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerSiteSelection,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Forecast',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerForecast,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Reports',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerReports,
      requiredRole: PlatformRole.territoryExpansionManager,
    ),
    PrimeCareScreen(
      title: 'System Verification',
      route: '/offices/system-verification',
      requiredRole: PlatformRole.systemVerification,
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
  List<PlatformModule> get modules => [BusinessDevelopmentOperationsModule()];
}
