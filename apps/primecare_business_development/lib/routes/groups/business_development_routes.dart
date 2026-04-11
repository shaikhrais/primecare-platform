import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> businessDevelopmentRoutes = [
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
    builder: (context, state) =>
        const RegionalManagerOntarioDashboard(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
    builder: (context, state) =>
        const RegionalManagerUsaDashboard(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
    builder: (context, state) =>
        const FranchiseSalesManagerDashboard(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.generalManagerDashboard,
    builder: (context, state) => const GeneralManagerDashboard(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerDashboard,
    builder: (context, state) =>
        const PartnershipManagerDashboard(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
    builder: (context, state) =>
        const TerritoryExpansionManagerDashboard(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmLeads,
    builder: (context, state) => const RegionalBdmLeadsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmFranchisePipeline,
    builder: (context, state) =>
        const RegionalBdmFranchisePipelineScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmTerritoryGrowth,
    builder: (context, state) => const RegionalBdmTerritoryGrowthScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmMeetings,
    builder: (context, state) => const RegionalBdmMeetingsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmDealTracker,
    builder: (context, state) => const RegionalBdmDealTrackerScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmPartners,
    builder: (context, state) => const RegionalBdmPartnersScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmCompetitorNotes,
    builder: (context, state) => const RegionalBdmCompetitorNotesScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmTasks,
    builder: (context, state) => const RegionalBdmTasksScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmReports,
    builder: (context, state) => const RegionalBdmReportsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerLeads,
    builder: (context, state) => const FranchiseSalesManagerLeadsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerProspects,
    builder: (context, state) =>
        const FranchiseSalesManagerProspectsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerDiscoveryCalls,
    builder: (context, state) =>
        const FranchiseSalesManagerDiscoveryCallsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerProposals,
    builder: (context, state) =>
        const FranchiseSalesManagerProposalsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerSalesPipeline,
    builder: (context, state) =>
        const FranchiseSalesManagerSalesPipelineScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerContracts,
    builder: (context, state) =>
        const FranchiseSalesManagerContractsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerFollowUps,
    builder: (context, state) =>
        const FranchiseSalesManagerFollowUpsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerReports,
    builder: (context, state) =>
        const FranchiseSalesManagerReportsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerPartners,
    builder: (context, state) => const PartnershipManagerPartnersScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerOutreach,
    builder: (context, state) => const PartnershipManagerOutreachScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerActiveDeals,
    builder: (context, state) =>
        const PartnershipManagerActiveDealsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerProposals,
    builder: (context, state) =>
        const PartnershipManagerProposalsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerRenewals,
    builder: (context, state) => const PartnershipManagerRenewalsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerReports,
    builder: (context, state) => const PartnershipManagerReportsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerTerritoryMap,
    builder: (context, state) =>
        const TerritoryExpansionManagerTerritoryMapScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerMarketResearch,
    builder: (context, state) =>
        const TerritoryExpansionManagerMarketResearchScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerDemographics,
    builder: (context, state) =>
        const TerritoryExpansionManagerDemographicsScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerOpenTerritories,
    builder: (context, state) =>
        const TerritoryExpansionManagerOpenTerritoriesScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerExpansionPlans,
    builder: (context, state) =>
        const TerritoryExpansionManagerExpansionPlansScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerSiteSelection,
    builder: (context, state) =>
        const TerritoryExpansionManagerSiteSelectionScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerForecast,
    builder: (context, state) =>
        const TerritoryExpansionManagerForecastScreen(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerReports,
    builder: (context, state) =>
        const TerritoryExpansionManagerReportsScreen(),
  ),
];
