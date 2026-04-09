import 'package:flutter_ui/flutter_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/routes/app_routes.dart';
import 'package:flutter_ui/src/components/generic_feature_screen.dart';







































final List<RouteBase> businessDevelopmentRoutes = [
  GoRoute(
    path: AppRoutes.regionalManagerOntarioDashboard,
    builder: (context, state) => const RegionalManagerOntarioDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalManagerUsaDashboard,
    builder: (context, state) => const RegionalManagerUsaDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerDashboard,
    builder: (context, state) => const FranchiseSalesManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.generalManagerDashboard,
    builder: (context, state) => const GeneralManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerDashboard,
    builder: (context, state) => const PartnershipManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerDashboard,
    builder: (context, state) => const TerritoryExpansionManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmLeads,
    builder: (context, state) => const RegionalBdmLeadsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmFranchisePipeline,
    builder: (context, state) => const RegionalBdmFranchisePipelineScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmTerritoryGrowth,
    builder: (context, state) => const RegionalBdmTerritoryGrowthScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmMeetings,
    builder: (context, state) => const RegionalBdmMeetingsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmDealTracker,
    builder: (context, state) => const RegionalBdmDealTrackerScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmPartners,
    builder: (context, state) => const RegionalBdmPartnersScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmCompetitorNotes,
    builder: (context, state) => const RegionalBdmCompetitorNotesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmTasks,
    builder: (context, state) => const RegionalBdmTasksScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmReports,
    builder: (context, state) => const RegionalBdmReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerLeads,
    builder: (context, state) => const FranchiseSalesManagerLeadsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerProspects,
    builder: (context, state) => const FranchiseSalesManagerProspectsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerDiscoveryCalls,
    builder: (context, state) => const FranchiseSalesManagerDiscoveryCallsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerProposals,
    builder: (context, state) => const FranchiseSalesManagerProposalsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerSalesPipeline,
    builder: (context, state) => const FranchiseSalesManagerSalesPipelineScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerContracts,
    builder: (context, state) => const FranchiseSalesManagerContractsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerFollowUps,
    builder: (context, state) => const FranchiseSalesManagerFollowUpsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerReports,
    builder: (context, state) => const FranchiseSalesManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerPartners,
    builder: (context, state) => const PartnershipManagerPartnersScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerOutreach,
    builder: (context, state) => const PartnershipManagerOutreachScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerActiveDeals,
    builder: (context, state) => const PartnershipManagerActiveDealsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerProposals,
    builder: (context, state) => const PartnershipManagerProposalsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerRenewals,
    builder: (context, state) => const PartnershipManagerRenewalsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerReports,
    builder: (context, state) => const PartnershipManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerTerritoryMap,
    builder: (context, state) => const TerritoryExpansionManagerTerritoryMapScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerMarketResearch,
    builder: (context, state) => const TerritoryExpansionManagerMarketResearchScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerDemographics,
    builder: (context, state) => const TerritoryExpansionManagerDemographicsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerOpenTerritories,
    builder: (context, state) => const TerritoryExpansionManagerOpenTerritoriesScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerExpansionPlans,
    builder: (context, state) => const TerritoryExpansionManagerExpansionPlansScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerSiteSelection,
    builder: (context, state) => const TerritoryExpansionManagerSiteSelectionScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerForecast,
    builder: (context, state) => const TerritoryExpansionManagerForecastScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerReports,
    builder: (context, state) => const TerritoryExpansionManagerReportsScreenStitch(),
  ),
];
