import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';

final List<RouteBase> marketingRoutes = [
  GoRoute(
    path: CorporateRoutes.headOfMarketingDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerDashboard,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingCampaigns,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingLeads,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingFunnelAnalytics,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingBrandAssets,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingRegionalCampaigns,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingContentApproval,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.headOfMarketingPerformanceReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerCampaigns,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerLeads,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerContentCalendar,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerEvents,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerBudget,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.localMarketingManagerAssets,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachPrograms,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachEvents,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachPartnerships,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachVolunteers,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachContacts,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.communityOutreachFollowUps,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerLeads,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerPipeline,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerFieldActivity,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerConversions,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerAreaPerformance,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerCompetitors,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
  GoRoute(
    path: MarketingRoutes.territorySalesManagerReports,
    builder: (context, state) => const DemoDashboardScreen(),
  ),
];
