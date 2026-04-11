import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> marketingRoutes = [
  GoRoute(
    path: CorporateRoutes.headOfMarketingDashboard,
    builder: (context, state) => const HeadOfMarketingDashboard(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerDashboard,
    builder: (context, state) =>
        const LocalMarketingDashboard(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachDashboard,
    builder: (context, state) => const CommunityOutreachDashboard(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerDashboard,
    builder: (context, state) =>
        const TerritorySalesDashboard(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingCampaigns,
    builder: (context, state) => const HeadOfMarketingCampaignsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingLeads,
    builder: (context, state) => const HeadOfMarketingLeadsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingFunnelAnalytics,
    builder: (context, state) =>
        const HeadOfMarketingFunnelAnalyticsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingBrandAssets,
    builder: (context, state) => const HeadOfMarketingBrandAssetsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingRegionalCampaigns,
    builder: (context, state) =>
        const HeadOfMarketingRegionalCampaignsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingContentApproval,
    builder: (context, state) =>
        const HeadOfMarketingContentApprovalScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingPerformanceReports,
    builder: (context, state) =>
        const HeadOfMarketingPerformanceReportsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerCampaigns,
    builder: (context, state) =>
        const LocalMarketingManagerCampaignsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerLeads,
    builder: (context, state) => const LocalMarketingManagerLeadsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerContentCalendar,
    builder: (context, state) =>
        const LocalMarketingManagerContentCalendarScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerEvents,
    builder: (context, state) =>
        const LocalMarketingManagerEventsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerBudget,
    builder: (context, state) =>
        const LocalMarketingManagerBudgetScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerReports,
    builder: (context, state) =>
        const LocalMarketingManagerReportsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerAssets,
    builder: (context, state) =>
        const LocalMarketingManagerAssetsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachPrograms,
    builder: (context, state) => const CommunityOutreachProgramsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachEvents,
    builder: (context, state) => const CommunityOutreachEventsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachPartnerships,
    builder: (context, state) =>
        const CommunityOutreachPartnershipsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachVolunteers,
    builder: (context, state) =>
        const CommunityOutreachVolunteersScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachContacts,
    builder: (context, state) => const CommunityOutreachContactsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachFollowUps,
    builder: (context, state) => const CommunityOutreachFollowUpsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerLeads,
    builder: (context, state) => const TerritorySalesManagerLeadsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerPipeline,
    builder: (context, state) =>
        const TerritorySalesManagerPipelineScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerFieldActivity,
    builder: (context, state) =>
        const TerritorySalesManagerFieldActivityScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerConversions,
    builder: (context, state) =>
        const TerritorySalesManagerConversionsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerAreaPerformance,
    builder: (context, state) =>
        const TerritorySalesManagerAreaPerformanceScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerCompetitors,
    builder: (context, state) =>
        const TerritorySalesManagerCompetitorsScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerReports,
    builder: (context, state) =>
        const TerritorySalesManagerReportsScreen(),
  ),
];
