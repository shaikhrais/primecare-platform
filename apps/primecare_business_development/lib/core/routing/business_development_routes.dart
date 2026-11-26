// Governance - Category: middleware | Purpose: Routing definition mapping client endpoints, paths, layouts, and access guards.
import 'package:primecare_ui/primecare_ui.dart' hide
    RegionalManagerUsaDashboardScreen,
    FranchiseSalesManagerDashboardScreen,
    PartnershipManagerDashboardScreen,
    TerritoryExpansionManagerDashboardScreen,
    GeneralManagerDashboardScreen,
    RegionalBdmDashboardScreen;
import 'package:flutter_core/flutter_core.dart';
import '../../features/business_development/presentation/widgets/widgets.dart';

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
      builder: (context) => const RegionalManagerOntarioDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional Manager USA Dashboard',
      route: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
      builder: (context) => const RegionalManagerUsaDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Dashboard',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
      builder: (context) => const FranchiseSalesManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Dashboard',
      route: BusinessDevelopmentRoutes.partnershipManagerDashboard,
      builder: (context) => const PartnershipManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Dashboard',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
      builder: (context) => const TerritoryExpansionManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'General Manager Dashboard',
      route: BusinessDevelopmentRoutes.generalManagerDashboard,
      builder: (context) => const GeneralManagerDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Dashboard',
      route: BusinessDevelopmentRoutes.regionalBdmDashboard,
      builder: (context) => const RegionalBdmDashboardScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Leads',
      route: BusinessDevelopmentRoutes.regionalBdmLeads,
      builder: (context) => const RegionalBdmLeadsScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Franchise Pipeline',
      route: BusinessDevelopmentRoutes.regionalBdmFranchisePipeline,
      builder: (context) => const RegionalBdmFranchisePipelineScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Territory Growth',
      route: BusinessDevelopmentRoutes.regionalBdmTerritoryGrowth,
      builder: (context) => const RegionalBdmTerritoryGrowthScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Meetings',
      route: BusinessDevelopmentRoutes.regionalBdmMeetings,
      builder: (context) => const RegionalBdmMeetingsScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Deal Tracker',
      route: BusinessDevelopmentRoutes.regionalBdmDealTracker,
      builder: (context) => const RegionalBdmDealTrackerScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Partners',
      route: BusinessDevelopmentRoutes.regionalBdmPartners,
      builder: (context) => const RegionalBdmPartnersScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Competitor Notes',
      route: BusinessDevelopmentRoutes.regionalBdmCompetitorNotes,
      builder: (context) => const RegionalBdmCompetitorNotesScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Tasks',
      route: BusinessDevelopmentRoutes.regionalBdmTasks,
      builder: (context) => const RegionalBdmTasksScreen(),
    ),
    PrimeCareScreen(
      title: 'Regional BDM Reports',
      route: BusinessDevelopmentRoutes.regionalBdmReports,
      builder: (context) => const RegionalBdmReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Leads',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerLeads,
      builder: (context) => const FranchiseSalesManagerLeadsScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Prospects',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerProspects,
      builder: (context) => const FranchiseSalesManagerProspectsScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Discovery Calls',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerDiscoveryCalls,
      builder: (context) => const FranchiseSalesManagerDiscoveryCallsScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Proposals',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerProposals,
      builder: (context) => const FranchiseSalesManagerProposalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Sales Pipeline',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerSalesPipeline,
      builder: (context) => const FranchiseSalesManagerSalesPipelineScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Contracts',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerContracts,
      builder: (context) => const FranchiseSalesManagerContractsScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Follow Ups',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerFollowUps,
      builder: (context) => const FranchiseSalesManagerFollowUpsScreen(),
    ),
    PrimeCareScreen(
      title: 'Franchise Sales Manager Reports',
      route: BusinessDevelopmentRoutes.franchiseSalesManagerReports,
      builder: (context) => const FranchiseSalesManagerReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Partners',
      route: BusinessDevelopmentRoutes.partnershipManagerPartners,
      builder: (context) => const PartnershipManagerPartnersScreen(),
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Outreach',
      route: BusinessDevelopmentRoutes.partnershipManagerOutreach,
      builder: (context) => const PartnershipManagerOutreachScreen(),
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Active Deals',
      route: BusinessDevelopmentRoutes.partnershipManagerActiveDeals,
      builder: (context) => const PartnershipManagerActiveDealsScreen(),
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Proposals',
      route: BusinessDevelopmentRoutes.partnershipManagerProposals,
      builder: (context) => const PartnershipManagerProposalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Renewals',
      route: BusinessDevelopmentRoutes.partnershipManagerRenewals,
      builder: (context) => const PartnershipManagerRenewalsScreen(),
    ),
    PrimeCareScreen(
      title: 'Partnership Manager Reports',
      route: BusinessDevelopmentRoutes.partnershipManagerReports,
      builder: (context) => const PartnershipManagerReportsScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Territory Map',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerTerritoryMap,
      builder: (context) => const TerritoryExpansionManagerTerritoryMapScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Market Research',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerMarketResearch,
      builder: (context) => const TerritoryExpansionManagerMarketResearchScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Demographics',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerDemographics,
      builder: (context) => const TerritoryExpansionManagerDemographicsScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Open Territories',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerOpenTerritories,
      builder: (context) => const TerritoryExpansionManagerOpenTerritoriesScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Expansion Plans',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerExpansionPlans,
      builder: (context) => const TerritoryExpansionManagerExpansionPlansScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Site Selection',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerSiteSelection,
      builder: (context) => const TerritoryExpansionManagerSiteSelectionScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Forecast',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerForecast,
      builder: (context) => const TerritoryExpansionManagerForecastScreen(),
    ),
    PrimeCareScreen(
      title: 'Territory Expansion Manager Reports',
      route: BusinessDevelopmentRoutes.territoryExpansionManagerReports,
      builder: (context) => const TerritoryExpansionManagerReportsScreen(),
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
