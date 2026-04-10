import 'package:flutter_ui/flutter_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';







































final List<RouteBase> businessDevelopmentRoutes = [
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
    builder: (context, state) => const RegionalManagerOntarioDashboardScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
    builder: (context, state) => const RegionalManagerUsaDashboardScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
    builder: (context, state) => const FranchiseSalesManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.generalManagerDashboard,
    builder: (context, state) => const GeneralManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerDashboard,
    builder: (context, state) => const PartnershipManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
    builder: (context, state) => const TerritoryExpansionManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmLeads,
    builder: (context, state) => const RegionalBdmLeadsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmFranchisePipeline,
    builder: (context, state) => const RegionalBdmFranchisePipelineScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmTerritoryGrowth,
    builder: (context, state) => const RegionalBdmTerritoryGrowthScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmMeetings,
    builder: (context, state) => const RegionalBdmMeetingsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmDealTracker,
    builder: (context, state) => const RegionalBdmDealTrackerScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmPartners,
    builder: (context, state) => const RegionalBdmPartnersScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmCompetitorNotes,
    builder: (context, state) => const RegionalBdmCompetitorNotesScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmTasks,
    builder: (context, state) => const RegionalBdmTasksScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.regionalBdmReports,
    builder: (context, state) => const RegionalBdmReportsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerLeads,
    builder: (context, state) => const FranchiseSalesManagerLeadsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerProspects,
    builder: (context, state) => const FranchiseSalesManagerProspectsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerDiscoveryCalls,
    builder: (context, state) => const FranchiseSalesManagerDiscoveryCallsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerProposals,
    builder: (context, state) => const FranchiseSalesManagerProposalsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerSalesPipeline,
    builder: (context, state) => const FranchiseSalesManagerSalesPipelineScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerContracts,
    builder: (context, state) => const FranchiseSalesManagerContractsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerFollowUps,
    builder: (context, state) => const FranchiseSalesManagerFollowUpsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.franchiseSalesManagerReports,
    builder: (context, state) => const FranchiseSalesManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerPartners,
    builder: (context, state) => const PartnershipManagerPartnersScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerOutreach,
    builder: (context, state) => const PartnershipManagerOutreachScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerActiveDeals,
    builder: (context, state) => const PartnershipManagerActiveDealsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerProposals,
    builder: (context, state) => const PartnershipManagerProposalsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerRenewals,
    builder: (context, state) => const PartnershipManagerRenewalsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.partnershipManagerReports,
    builder: (context, state) => const PartnershipManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerTerritoryMap,
    builder: (context, state) => const TerritoryExpansionManagerTerritoryMapScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerMarketResearch,
    builder: (context, state) => const TerritoryExpansionManagerMarketResearchScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerDemographics,
    builder: (context, state) => const TerritoryExpansionManagerDemographicsScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerOpenTerritories,
    builder: (context, state) => const TerritoryExpansionManagerOpenTerritoriesScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerExpansionPlans,
    builder: (context, state) => const TerritoryExpansionManagerExpansionPlansScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerSiteSelection,
    builder: (context, state) => const TerritoryExpansionManagerSiteSelectionScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerForecast,
    builder: (context, state) => const TerritoryExpansionManagerForecastScreenStitch(),
  ),
  GoRoute(
    path: BusinessDevelopmentRoutes.territoryExpansionManagerReports,
    builder: (context, state) => const TerritoryExpansionManagerReportsScreenStitch(),
  ),
];

