import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';


class ScreenConfig {
  final String routePath;
  final String titleKey;
  final String subtitleKey;
  final String providerId;

  const ScreenConfig({
    required this.routePath,
    required this.titleKey,
    required this.subtitleKey,
    required this.providerId,
  });
}

final List<ScreenConfig> businessDevelopmentScreenRegistry = [
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
    titleKey: 'Regional Manager Ontario Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalManagerOntarioDashboard',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
    titleKey: 'Regional Manager Usa Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalManagerUsaDashboard',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
    titleKey: 'Franchise Sales Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerDashboard',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.generalManagerDashboard,
    titleKey: 'General Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'generalManagerDashboard',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.partnershipManagerDashboard,
    titleKey: 'Partnership Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'partnershipManagerDashboard',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
    titleKey: 'Territory Expansion Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerDashboard',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmLeads,
    titleKey: 'Regional Bdm Leads',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmLeads',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmFranchisePipeline,
    titleKey: 'Regional Bdm Franchise Pipeline',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmFranchisePipeline',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmTerritoryGrowth,
    titleKey: 'Regional Bdm Territory Growth',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmTerritoryGrowth',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmMeetings,
    titleKey: 'Regional Bdm Meetings',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmMeetings',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmDealTracker,
    titleKey: 'Regional Bdm Deal Tracker',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmDealTracker',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmPartners,
    titleKey: 'Regional Bdm Partners',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmPartners',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmCompetitorNotes,
    titleKey: 'Regional Bdm Competitor Notes',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmCompetitorNotes',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmTasks,
    titleKey: 'Regional Bdm Tasks',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmTasks',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.regionalBdmReports,
    titleKey: 'Regional Bdm Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'regionalBdmReports',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerLeads,
    titleKey: 'Franchise Sales Manager Leads',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerLeads',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerProspects,
    titleKey: 'Franchise Sales Manager Prospects',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerProspects',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerDiscoveryCalls,
    titleKey: 'Franchise Sales Manager Discovery Calls',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerDiscoveryCalls',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerProposals,
    titleKey: 'Franchise Sales Manager Proposals',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerProposals',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerSalesPipeline,
    titleKey: 'Franchise Sales Manager Sales Pipeline',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerSalesPipeline',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerContracts,
    titleKey: 'Franchise Sales Manager Contracts',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerContracts',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerFollowUps,
    titleKey: 'Franchise Sales Manager Follow Ups',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerFollowUps',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.franchiseSalesManagerReports,
    titleKey: 'Franchise Sales Manager Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'franchiseSalesManagerReports',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.partnershipManagerPartners,
    titleKey: 'Partnership Manager Partners',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'partnershipManagerPartners',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.partnershipManagerOutreach,
    titleKey: 'Partnership Manager Outreach',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'partnershipManagerOutreach',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.partnershipManagerActiveDeals,
    titleKey: 'Partnership Manager Active Deals',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'partnershipManagerActiveDeals',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.partnershipManagerProposals,
    titleKey: 'Partnership Manager Proposals',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'partnershipManagerProposals',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.partnershipManagerRenewals,
    titleKey: 'Partnership Manager Renewals',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'partnershipManagerRenewals',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.partnershipManagerReports,
    titleKey: 'Partnership Manager Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'partnershipManagerReports',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerTerritoryMap,
    titleKey: 'Territory Expansion Manager Territory Map',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerTerritoryMap',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerMarketResearch,
    titleKey: 'Territory Expansion Manager Market Research',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerMarketResearch',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerDemographics,
    titleKey: 'Territory Expansion Manager Demographics',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerDemographics',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerOpenTerritories,
    titleKey: 'Territory Expansion Manager Open Territories',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerOpenTerritories',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerExpansionPlans,
    titleKey: 'Territory Expansion Manager Expansion Plans',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerExpansionPlans',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerSiteSelection,
    titleKey: 'Territory Expansion Manager Site Selection',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerSiteSelection',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerForecast,
    titleKey: 'Territory Expansion Manager Forecast',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerForecast',
  ),
  ScreenConfig(
    routePath: BusinessDevelopmentRoutes.territoryExpansionManagerReports,
    titleKey: 'Territory Expansion Manager Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territoryExpansionManagerReports',
  ),
];

final List<RouteBase> businessDevelopmentRoutes = businessDevelopmentScreenRegistry.map((config) {
  return GoRoute(
    path: config.routePath,
    builder: (context, state) => PageTemplate.orchestrate(
      title: config.titleKey,
      subtitle: config.subtitleKey,
      provider: genericDashboardProvider(config.providerId),
    ),
  );
}).toList();
