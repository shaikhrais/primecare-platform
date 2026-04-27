// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'base_office_registry.dart';

class MarketingRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      MarketingRoutes.localMarketingManagerDashboard,
      PrimeCareForm.localMarketingManagerDashboard,
      componentLabels: [
        'Aura HUD (Local Lead Velocity)',
        'Local KPI Grid',
        'Community Engagement Log',
        'Campaign Performance Table',
      ],
      structuralPlan:
          'Localized Growth Console: Aura HUD with local lead volume telemetry. Focuses on community engagement logs and granular campaign performance tracking.',
    );
    registerRoute(
      MarketingRoutes.communityOutreachDashboard,
      PrimeCareForm.communityOutreachDashboard,
      componentLabels: [
        'Aura HUD (Event Traction)',
        'Outreach Stat Grid',
        'Partnership Growth Chart',
        'Event Management Calendar',
      ],
      structuralPlan:
          'Outreach Coordination Hub: Aura HUD with community sentiment telemetry. Centered around a regional partnership growth chart and an event management calendar.',
    );
    registerRoute(
      MarketingRoutes.territorySalesManagerDashboard,
      PrimeCareForm.territorySalesManagerDashboard,
      componentLabels: [
        'Aura HUD (Sales Velocity)',
        'Sales KPI Grid',
        'Pipeline Velocity Chart',
        'Territory Growth Map',
      ],
      structuralPlan:
          'Sales Velocity Command: Aura HUD with pipeline throughput telemetry. Primary visualization focuses on sales velocity charts and a geographic territory growth map.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'head_of_marketing': {
      'title': 'corporate.head_of_marketing.dashboard.title',
      'subtitle': 'corporate.head_of_marketing.dashboard.subtitle',
      'route': CorporateRoutes.headOfMarketingDashboard,
      'componentLabels': [
        'Aura HUD (Lead Velocity)',
        'Global Campaign Heatmap',
        'Funnel Conversion Grid',
        'Brand Awareness Index',
      ],
      'structuralPlan':
          'Growth Governance Console: Aura HUD with lead-velocity telemetry. Features global campaign heatmaps, funnel conversion grids, and brand awareness indexing.',
      'kpis': [
        {
          'title': 'Lead Conversion',
          'value': '18.4%',
          'deltaSuffix': 'Active Funnel',
          'icon': 'barChart2',
          'iconColor': 'pink',
        },
      ],
      'highFidelityViewId': 'headOfMarketingDashboardViewModel',
    },
    'local_marketing_manager': {
      'title': 'marketing.local_marketing_manager.dashboard.title',
      'subtitle': 'marketing.local_marketing_manager.dashboard.subtitle',
      'route': MarketingRoutes.localMarketingManagerDashboard,
      'componentLabels': [
        'Aura HUD (Local Lead Velocity)',
        'Local KPI Grid',
        'Community Engagement Log',
        'Campaign Performance Table',
      ],
      'structuralPlan':
          'Localized Growth Console: Aura HUD with local lead volume telemetry. Focuses on community engagement logs and granular campaign performance tracking.',
      'kpis': [
        {
          'title': 'Campaign ROI',
          'value': '3.2x',
          'deltaSuffix': 'Active Promo',
          'icon': 'trendingUp',
          'iconColor': 'pink',
        },
      ],
    },
    'community_outreach': {
      'title': 'marketing.community_outreach.dashboard.title',
      'subtitle': 'marketing.community_outreach.dashboard.subtitle',
      'route': MarketingRoutes.communityOutreachDashboard,
      'componentLabels': [
        'Aura HUD (Event Traction)',
        'Outreach Stat Grid',
        'Partnership Growth Chart',
        'Event Management Calendar',
      ],
      'structuralPlan':
          'Outreach Coordination Hub: Aura HUD with community sentiment telemetry. Centered around a regional partnership growth chart and an event management calendar.',
      'kpis': [
        {
          'title': 'Active Programs',
          'value': '8',
          'deltaSuffix': '+2 this month',
          'icon': 'users',
          'iconColor': 'blue',
        },
      ],
    },
    'territory_sales_manager': {
      'title': 'marketing.territory_sales_manager.dashboard.title',
      'subtitle': 'marketing.territory_sales_manager.dashboard.subtitle',
      'route': MarketingRoutes.territorySalesManagerDashboard,
      'componentLabels': [
        'Aura HUD (Sales Velocity)',
        'Sales KPI Grid',
        'Pipeline Velocity Chart',
        'Territory Growth Map',
      ],
      'structuralPlan':
          'Sales Velocity Command: Aura HUD with pipeline throughput telemetry. Primary visualization focuses on sales velocity charts and a geographic territory growth map.',
      'kpis': [
        {
          'title': 'Sales Target',
          'value': '84%',
          'deltaSuffix': 'Q2 Progress',
          'icon': 'target',
          'iconColor': 'orange',
        },
      ],
    },
  };
}
