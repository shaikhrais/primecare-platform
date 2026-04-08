import 'package:go_router/go_router.dart';
import '../app_routes.dart';
import 'package:primecare_ui/src/components/generic_feature_screen.dart';

import '../../offices/marketing/roles/head_of_marketing/marketing_director_dashboard.dart'
    as head_of_marketing_dash;
import '../../offices/marketing/roles/local_marketing_manager/local_marketing_dashboard.dart'
    as local_marketing_manager_dash;
import '../../offices/marketing/roles/community_outreach/community_dashboard.dart'
    as community_outreach_dash;
import '../../offices/marketing/roles/territory_sales_manager/sales_dashboard.dart'
    as territory_sales_manager_dash;
import '../../offices/marketing/roles/head_of_marketing/campaigns.dart'
    as head_of_marketing_campaigns;
import '../../offices/marketing/roles/head_of_marketing/leads.dart'
    as head_of_marketing_leads;
import '../../offices/marketing/roles/head_of_marketing/funnel_analytics.dart'
    as head_of_marketing_funnel_analytics;
import '../../offices/marketing/roles/head_of_marketing/brand_assets.dart'
    as head_of_marketing_brand_assets;
import '../../offices/marketing/roles/head_of_marketing/regional_campaigns.dart'
    as head_of_marketing_regional_campaigns;
import '../../offices/marketing/roles/head_of_marketing/content_approval.dart'
    as head_of_marketing_content_approval;
import '../../offices/marketing/roles/head_of_marketing/performance_reports.dart'
    as head_of_marketing_performance_reports;
import '../../offices/marketing/roles/local_marketing_manager/campaigns.dart'
    as local_marketing_manager_campaigns;
import '../../offices/marketing/roles/local_marketing_manager/leads.dart'
    as local_marketing_manager_leads;
import '../../offices/marketing/roles/local_marketing_manager/content_calendar.dart'
    as local_marketing_manager_content_calendar;
import '../../offices/marketing/roles/local_marketing_manager/events.dart'
    as local_marketing_manager_events;
import '../../offices/marketing/roles/local_marketing_manager/budget.dart'
    as local_marketing_manager_budget;
import '../../offices/marketing/roles/local_marketing_manager/reports.dart'
    as local_marketing_manager_reports;
import '../../offices/marketing/roles/local_marketing_manager/assets.dart'
    as local_marketing_manager_assets;
import '../../offices/marketing/roles/community_outreach/programs.dart'
    as community_outreach_programs;
import '../../offices/marketing/roles/community_outreach/events.dart'
    as community_outreach_events;
import '../../offices/marketing/roles/community_outreach/partnerships.dart'
    as community_outreach_partnerships;
import '../../offices/marketing/roles/community_outreach/volunteers.dart'
    as community_outreach_volunteers;
import '../../offices/marketing/roles/community_outreach/contacts.dart'
    as community_outreach_contacts;
import '../../offices/marketing/roles/community_outreach/follow_ups.dart'
    as community_outreach_follow_ups;
import '../../offices/marketing/roles/community_outreach/reports.dart'
    as community_outreach_reports;
import '../../offices/marketing/roles/territory_sales_manager/leads.dart'
    as territory_sales_manager_leads;
import '../../offices/marketing/roles/territory_sales_manager/pipeline.dart'
    as territory_sales_manager_pipeline;
import '../../offices/marketing/roles/territory_sales_manager/field_activity.dart'
    as territory_sales_manager_field_activity;
import '../../offices/marketing/roles/territory_sales_manager/conversions.dart'
    as territory_sales_manager_conversions;
import '../../offices/marketing/roles/territory_sales_manager/area_performance.dart'
    as territory_sales_manager_area_performance;
import '../../offices/marketing/roles/territory_sales_manager/competitors.dart'
    as territory_sales_manager_competitors;
import '../../offices/marketing/roles/territory_sales_manager/reports.dart'
    as territory_sales_manager_reports;

final List<RouteBase> marketingRoutes = [
  GoRoute(
    path: AppRoutes.headOfMarketingDashboard,
    builder: (context, state) =>
        const head_of_marketing_dash.HeadOfMarketingDashboard(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerDashboard,
    builder: (context, state) =>
        const local_marketing_manager_dash.LocalMarketingDashboard(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachDashboard,
    builder: (context, state) =>
        const community_outreach_dash.CommunityOutreachDashboard(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerDashboard,
    builder: (context, state) =>
        const territory_sales_manager_dash.TerritorySalesDashboard(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingCampaigns,
    builder: (context, state) =>
        const head_of_marketing_campaigns.CampaignsScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingLeads,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingFunnelAnalytics,
    builder: (context, state) =>
        const head_of_marketing_funnel_analytics.FunnelAnalyticsScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingBrandAssets,
    builder: (context, state) =>
        const head_of_marketing_brand_assets.BrandAssetsScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingRegionalCampaigns,
    builder: (context, state) =>
        const head_of_marketing_regional_campaigns.RegionalCampaignsScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingContentApproval,
    builder: (context, state) =>
        const head_of_marketing_content_approval.ContentApprovalScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingPerformanceReports,
    builder: (context, state) =>
        const head_of_marketing_performance_reports.PerformanceReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerCampaigns,
    builder: (context, state) =>
        const local_marketing_manager_campaigns.LocalCampaignsScreen(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerLeads,
    builder: (context, state) =>
        const local_marketing_manager_leads.LocalLeadsScreen(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerContentCalendar,
    builder: (context, state) =>
        const local_marketing_manager_content_calendar.LocalContentCalendarScreen(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerEvents,
    builder: (context, state) =>
        const local_marketing_manager_events.LocalEventsScreen(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerBudget,
    builder: (context, state) =>
        const local_marketing_manager_budget.LocalBudgetScreen(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerReports,
    builder: (context, state) =>
        const local_marketing_manager_reports.LocalReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerAssets,
    builder: (context, state) =>
        const local_marketing_manager_assets.LocalAssetsScreen(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachPrograms,
    builder: (context, state) =>
        const community_outreach_programs.ProgramsScreen(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachEvents,
    builder: (context, state) => const community_outreach_events.EventsScreen(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachPartnerships,
    builder: (context, state) =>
        const community_outreach_partnerships.PartnershipsScreen(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachVolunteers,
    builder: (context, state) =>
        const community_outreach_volunteers.VolunteersScreen(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachContacts,
    builder: (context, state) =>
        const community_outreach_contacts.ContactsScreen(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachFollowUps,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerLeads,
    builder: (context, state) =>
        const territory_sales_manager_leads.TerritoryLeadsScreen(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerPipeline,
    builder: (context, state) =>
        const territory_sales_manager_pipeline.TerritoryPipelineScreen(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerFieldActivity,
    builder: (context, state) =>
        const territory_sales_manager_field_activity.TerritoryFieldActivityScreen(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerConversions,
    builder: (context, state) =>
        const territory_sales_manager_conversions.TerritoryConversionsScreen(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerAreaPerformance,
    builder: (context, state) =>
        const territory_sales_manager_area_performance.TerritoryAreaPerformanceScreen(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerCompetitors,
    builder: (context, state) =>
        const territory_sales_manager_competitors.TerritoryCompetitorsScreen(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerReports,
    builder: (context, state) =>
        const territory_sales_manager_reports.TerritoryReportsScreen(),
  ),
];
