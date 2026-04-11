import 'package:flutter_ui/flutter_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> marketingRoutes = [
  GoRoute(
    path: CorporateRoutes.headOfMarketingDashboard,
    builder: (context, state) => const HeadOfMarketingDashboardScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerDashboard,
    builder: (context, state) =>
        const LocalMarketingManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachDashboard,
    builder: (context, state) => const CommunityOutreachDashboardScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerDashboard,
    builder: (context, state) =>
        const TerritorySalesManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingCampaigns,
    builder: (context, state) => const HeadOfMarketingCampaignsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingLeads,
    builder: (context, state) => const HeadOfMarketingLeadsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingFunnelAnalytics,
    builder: (context, state) =>
        const HeadOfMarketingFunnelAnalyticsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingBrandAssets,
    builder: (context, state) => const HeadOfMarketingBrandAssetsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingRegionalCampaigns,
    builder: (context, state) =>
        const HeadOfMarketingRegionalCampaignsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingContentApproval,
    builder: (context, state) =>
        const HeadOfMarketingContentApprovalScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingPerformanceReports,
    builder: (context, state) =>
        const HeadOfMarketingPerformanceReportsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerCampaigns,
    builder: (context, state) =>
        const LocalMarketingManagerCampaignsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerLeads,
    builder: (context, state) => const LocalMarketingManagerLeadsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerContentCalendar,
    builder: (context, state) =>
        const LocalMarketingManagerContentCalendarScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerEvents,
    builder: (context, state) =>
        const LocalMarketingManagerEventsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerBudget,
    builder: (context, state) =>
        const LocalMarketingManagerBudgetScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerReports,
    builder: (context, state) =>
        const LocalMarketingManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerAssets,
    builder: (context, state) =>
        const LocalMarketingManagerAssetsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachPrograms,
    builder: (context, state) => const CommunityOutreachProgramsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachEvents,
    builder: (context, state) => const CommunityOutreachEventsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachPartnerships,
    builder: (context, state) =>
        const CommunityOutreachPartnershipsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachVolunteers,
    builder: (context, state) =>
        const CommunityOutreachVolunteersScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachContacts,
    builder: (context, state) => const CommunityOutreachContactsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachFollowUps,
    builder: (context, state) => const CommunityOutreachFollowUpsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerLeads,
    builder: (context, state) => const TerritorySalesManagerLeadsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerPipeline,
    builder: (context, state) =>
        const TerritorySalesManagerPipelineScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerFieldActivity,
    builder: (context, state) =>
        const TerritorySalesManagerFieldActivityScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerConversions,
    builder: (context, state) =>
        const TerritorySalesManagerConversionsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerAreaPerformance,
    builder: (context, state) =>
        const TerritorySalesManagerAreaPerformanceScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerCompetitors,
    builder: (context, state) =>
        const TerritorySalesManagerCompetitorsScreenStitch(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerReports,
    builder: (context, state) =>
        const TerritorySalesManagerReportsScreenStitch(),
  ),
];
