import 'package:go_router/go_router.dart';
import 'package:primecare_core/routes/app_routes.dart';
import 'package:primecare_ui/src/components/generic_feature_screen.dart';

import '../../offices/business_development/roles/regional_manager_ontario/region_dashboard.dart'
    as regional_manager_ontario_dash;
import '../../offices/business_development/roles/regional_manager_usa/region_dashboard.dart'
    as regional_manager_usa_dash;
import '../../offices/business_development/roles/franchise_sales_manager/pipeline_dashboard.dart'
    as franchise_sales_manager_dash;
import '../../offices/business_development/roles/general_manager/ops_dashboard.dart'
    as general_manager_dash;
import '../../offices/business_development/roles/partnership_manager/partner_dashboard.dart'
    as partnership_manager_dash;
import '../../offices/business_development/roles/territory_expansion_manager/expansion_analytics_dashboard.dart'
    as territory_expansion_manager_dash;
import '../../offices/business_development/roles/regional_bdm/leads.dart'
    as regional_bdm_leads;
import '../../offices/business_development/roles/regional_bdm/franchise_pipeline.dart'
    as regional_bdm_franchise_pipeline;
import '../../offices/business_development/roles/regional_bdm/territory_growth.dart'
    as regional_bdm_territory_growth;
import '../../offices/business_development/roles/regional_bdm/meetings.dart'
    as regional_bdm_meetings;
import '../../offices/business_development/roles/regional_bdm/deal_tracker.dart'
    as regional_bdm_deal_tracker;
import '../../offices/business_development/roles/regional_bdm/partners.dart'
    as regional_bdm_partners;
import '../../offices/business_development/roles/regional_bdm/competitor_notes.dart'
    as regional_bdm_competitor_notes;
import '../../offices/business_development/roles/regional_bdm/tasks.dart'
    as regional_bdm_tasks;
import '../../offices/business_development/roles/regional_bdm/reports.dart'
    as regional_bdm_reports;
import '../../offices/business_development/roles/franchise_sales_manager/leads.dart'
    as franchise_sales_manager_leads;
import '../../offices/business_development/roles/franchise_sales_manager/prospects.dart'
    as franchise_sales_manager_prospects;
import '../../offices/business_development/roles/franchise_sales_manager/discovery_calls.dart'
    as franchise_sales_manager_discovery_calls;
import '../../offices/business_development/roles/franchise_sales_manager/proposals.dart'
    as franchise_sales_manager_proposals;
import '../../offices/business_development/roles/franchise_sales_manager/sales_pipeline.dart'
    as franchise_sales_manager_sales_pipeline;
import '../../offices/business_development/roles/franchise_sales_manager/contracts.dart'
    as franchise_sales_manager_contracts;
import '../../offices/business_development/roles/franchise_sales_manager/follow_ups.dart'
    as franchise_sales_manager_follow_ups;
import '../../offices/business_development/roles/franchise_sales_manager/reports.dart'
    as franchise_sales_manager_reports;
import '../../offices/business_development/roles/partnership_manager/partners.dart'
    as partnership_manager_partners;
import '../../offices/business_development/roles/partnership_manager/outreach.dart'
    as partnership_manager_outreach;
import '../../offices/business_development/roles/partnership_manager/active_deals.dart'
    as partnership_manager_active_deals;
import '../../offices/business_development/roles/partnership_manager/proposals.dart'
    as partnership_manager_proposals;
import '../../offices/business_development/roles/partnership_manager/renewals.dart'
    as partnership_manager_renewals;
import '../../offices/business_development/roles/partnership_manager/reports.dart'
    as partnership_manager_reports;
import '../../offices/business_development/roles/territory_expansion_manager/territory_map.dart'
    as territory_expansion_manager_territory_map;
import '../../offices/business_development/roles/territory_expansion_manager/market_research.dart'
    as territory_expansion_manager_market_research;
import '../../offices/business_development/roles/territory_expansion_manager/demographics.dart'
    as territory_expansion_manager_demographics;
import '../../offices/business_development/roles/territory_expansion_manager/open_territories.dart'
    as territory_expansion_manager_open_territories;
import '../../offices/business_development/roles/territory_expansion_manager/expansion_plans.dart'
    as territory_expansion_manager_expansion_plans;
import '../../offices/business_development/roles/territory_expansion_manager/site_selection.dart'
    as territory_expansion_manager_site_selection;
import '../../offices/business_development/roles/territory_expansion_manager/forecast.dart'
    as territory_expansion_manager_forecast;
import '../../offices/business_development/roles/territory_expansion_manager/reports.dart'
    as territory_expansion_manager_reports;

final List<RouteBase> businessDevelopmentRoutes = [
  GoRoute(
    path: AppRoutes.regionalManagerOntarioDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalManagerUsaDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.generalManagerDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmLeads,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmFranchisePipeline,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmTerritoryGrowth,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmMeetings,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmDealTracker,
    builder: (context, state) =>
        const regional_bdm_deal_tracker.DealTrackerScreen(),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmPartners,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmCompetitorNotes,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmTasks,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.regionalBdmReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerLeads,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerProspects,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerDiscoveryCalls,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerProposals,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerSalesPipeline,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerContracts,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerFollowUps,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.franchiseSalesManagerReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerPartners,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerOutreach,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerActiveDeals,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerProposals,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerRenewals,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.partnershipManagerReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerTerritoryMap,
    builder: (context, state) =>
        const territory_expansion_manager_territory_map.TerritoryMapScreen(),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerMarketResearch,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerDemographics,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerOpenTerritories,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerExpansionPlans,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerSiteSelection,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerForecast,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territoryExpansionManagerReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
];
