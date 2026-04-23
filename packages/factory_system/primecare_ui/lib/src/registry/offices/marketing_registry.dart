// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

class MarketingRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(MarketingRoutes.localMarketingManagerDashboard, PrimeCareForm.localMarketingManagerDashboard);
    registerRoute(MarketingRoutes.communityOutreachDashboard, PrimeCareForm.communityOutreachDashboard);
    registerRoute(MarketingRoutes.territorySalesManagerDashboard, PrimeCareForm.territorySalesManagerDashboard);
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
        'head_of_marketing': {
          'title': 'Market Share Analytics',
          'subtitle': 'Campaign performance and regional penetration metrics.',
          'route': CorporateRoutes.headOfMarketingDashboard,
          'componentLabels': ['Aura HUD', 'Campaign ROI Grid', 'Market Penetration Chart', 'Lead Conversion Funnel'],
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
          'title': 'Local Marketing Command',
          'subtitle': 'Campaign Performance • Community Engagement',
          'route': MarketingRoutes.localMarketingManagerDashboard,
          'componentLabels': ['Aura HUD', 'Local KPI Grid', 'Community Engagement Log', 'Campaign Performance Table'],
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
          'title': 'Community Engagement Hub',
          'subtitle': 'Event Management • Partnership Growth',
          'route': MarketingRoutes.communityOutreachDashboard,
          'componentLabels': ['Aura HUD', 'Outreach Stat Grid', 'Partnership Growth Chart', 'Event Management Calendar'],
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
          'title': 'Sales Pipeline Gateway',
          'subtitle': 'Lead Conversion • Territory Growth',
          'route': MarketingRoutes.territorySalesManagerDashboard,
          'componentLabels': ['Aura HUD', 'Sales KPI Grid', 'Pipeline Velocity Chart', 'Territory Growth Map'],
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
