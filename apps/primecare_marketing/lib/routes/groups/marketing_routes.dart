import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_core/routes/app_routes.dart';
import 'package:primecare_ui/src/components/generic_feature_screen.dart';


































final List<RouteBase> marketingRoutes = [
  GoRoute(
    path: AppRoutes.headOfMarketingDashboard,
    builder: (context, state) => const HeadOfMarketingDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerDashboard,
    builder: (context, state) => const LocalMarketingManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachDashboard,
    builder: (context, state) => const CommunityOutreachDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerDashboard,
    builder: (context, state) => const TerritorySalesManagerDashboardScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingCampaigns,
    builder: (context, state) => const HeadOfMarketingCampaignsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingLeads,
    builder: (context, state) => const HeadOfMarketingLeadsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingFunnelAnalytics,
    builder: (context, state) => const HeadOfMarketingFunnelAnalyticsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingBrandAssets,
    builder: (context, state) => const HeadOfMarketingBrandAssetsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingRegionalCampaigns,
    builder: (context, state) => const HeadOfMarketingRegionalCampaignsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingContentApproval,
    builder: (context, state) => const HeadOfMarketingContentApprovalScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.headOfMarketingPerformanceReports,
    builder: (context, state) => const HeadOfMarketingPerformanceReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerCampaigns,
    builder: (context, state) => const LocalMarketingManagerCampaignsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerLeads,
    builder: (context, state) => const LocalMarketingManagerLeadsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerContentCalendar,
    builder: (context, state) => const LocalMarketingManagerContentCalendarScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerEvents,
    builder: (context, state) => const LocalMarketingManagerEventsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerBudget,
    builder: (context, state) => const LocalMarketingManagerBudgetScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerReports,
    builder: (context, state) => const LocalMarketingManagerReportsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.localMarketingManagerAssets,
    builder: (context, state) => const LocalMarketingManagerAssetsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachPrograms,
    builder: (context, state) => const CommunityOutreachProgramsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachEvents,
    builder: (context, state) => const CommunityOutreachEventsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachPartnerships,
    builder: (context, state) => const CommunityOutreachPartnershipsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachVolunteers,
    builder: (context, state) => const CommunityOutreachVolunteersScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachContacts,
    builder: (context, state) => const CommunityOutreachContactsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.communityOutreachFollowUps,
    builder: (context, state) => const CommunityOutreachFollowUpsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerLeads,
    builder: (context, state) => const TerritorySalesManagerLeadsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerPipeline,
    builder: (context, state) => const TerritorySalesManagerPipelineScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerFieldActivity,
    builder: (context, state) => const TerritorySalesManagerFieldActivityScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerConversions,
    builder: (context, state) => const TerritorySalesManagerConversionsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerAreaPerformance,
    builder: (context, state) => const TerritorySalesManagerAreaPerformanceScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerCompetitors,
    builder: (context, state) => const TerritorySalesManagerCompetitorsScreenStitch(),
  ),
  GoRoute(
    path: AppRoutes.territorySalesManagerReports,
    builder: (context, state) => const TerritorySalesManagerReportsScreenStitch(),
  ),
];
