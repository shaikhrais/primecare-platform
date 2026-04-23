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

final List<ScreenConfig> marketingScreenRegistry = [
  ScreenConfig(
    routePath: CorporateRoutes.headOfMarketingDashboard,
    titleKey: 'Head Of Marketing Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfMarketingDashboard',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerDashboard,
    titleKey: 'Local Marketing Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'localMarketingManagerDashboard',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.communityOutreachDashboard,
    titleKey: 'Community Outreach Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'communityOutreachDashboard',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.territorySalesManagerDashboard,
    titleKey: 'Territory Sales Manager Dashboard',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territorySalesManagerDashboard',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.headOfMarketingCampaigns,
    titleKey: 'Head Of Marketing Campaigns',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfMarketingCampaigns',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.headOfMarketingLeads,
    titleKey: 'Head Of Marketing Leads',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfMarketingLeads',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.headOfMarketingFunnelAnalytics,
    titleKey: 'Head Of Marketing Funnel Analytics',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfMarketingFunnelAnalytics',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.headOfMarketingBrandAssets,
    titleKey: 'Head Of Marketing Brand Assets',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfMarketingBrandAssets',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.headOfMarketingRegionalCampaigns,
    titleKey: 'Head Of Marketing Regional Campaigns',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfMarketingRegionalCampaigns',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.headOfMarketingContentApproval,
    titleKey: 'Head Of Marketing Content Approval',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfMarketingContentApproval',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.headOfMarketingPerformanceReports,
    titleKey: 'Head Of Marketing Performance Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'headOfMarketingPerformanceReports',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerCampaigns,
    titleKey: 'Local Marketing Manager Campaigns',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'localMarketingManagerCampaigns',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerLeads,
    titleKey: 'Local Marketing Manager Leads',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'localMarketingManagerLeads',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerContentCalendar,
    titleKey: 'Local Marketing Manager Content Calendar',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'localMarketingManagerContentCalendar',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerEvents,
    titleKey: 'Local Marketing Manager Events',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'localMarketingManagerEvents',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerBudget,
    titleKey: 'Local Marketing Manager Budget',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'localMarketingManagerBudget',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerReports,
    titleKey: 'Local Marketing Manager Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'localMarketingManagerReports',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.localMarketingManagerAssets,
    titleKey: 'Local Marketing Manager Assets',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'localMarketingManagerAssets',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.communityOutreachPrograms,
    titleKey: 'Community Outreach Programs',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'communityOutreachPrograms',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.communityOutreachEvents,
    titleKey: 'Community Outreach Events',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'communityOutreachEvents',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.communityOutreachPartnerships,
    titleKey: 'Community Outreach Partnerships',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'communityOutreachPartnerships',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.communityOutreachVolunteers,
    titleKey: 'Community Outreach Volunteers',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'communityOutreachVolunteers',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.communityOutreachContacts,
    titleKey: 'Community Outreach Contacts',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'communityOutreachContacts',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.communityOutreachFollowUps,
    titleKey: 'Community Outreach Follow Ups',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'communityOutreachFollowUps',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.territorySalesManagerLeads,
    titleKey: 'Territory Sales Manager Leads',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territorySalesManagerLeads',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.territorySalesManagerPipeline,
    titleKey: 'Territory Sales Manager Pipeline',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territorySalesManagerPipeline',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.territorySalesManagerFieldActivity,
    titleKey: 'Territory Sales Manager Field Activity',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territorySalesManagerFieldActivity',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.territorySalesManagerConversions,
    titleKey: 'Territory Sales Manager Conversions',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territorySalesManagerConversions',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.territorySalesManagerAreaPerformance,
    titleKey: 'Territory Sales Manager Area Performance',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territorySalesManagerAreaPerformance',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.territorySalesManagerCompetitors,
    titleKey: 'Territory Sales Manager Competitors',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territorySalesManagerCompetitors',
  ),
  ScreenConfig(
    routePath: MarketingRoutes.territorySalesManagerReports,
    titleKey: 'Territory Sales Manager Reports',
    subtitleKey: 'Real-time overview fetched natively via API.',
    providerId: 'territorySalesManagerReports',
  ),
];

final List<RouteBase> marketingRoutes = marketingScreenRegistry.map((config) {
  return GoRoute(
    path: config.routePath,
    builder: (context, state) => PageTemplate.orchestrate(
      title: config.titleKey,
      subtitle: config.subtitleKey,
      provider: genericDashboardProvider(config.providerId),
    ),
  );
}).toList();
