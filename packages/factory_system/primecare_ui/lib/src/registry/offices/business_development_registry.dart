// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

class BusinessDevelopmentRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(BusinessDevelopmentRoutes.territoryExpansionManagerDashboard, PrimeCareForm.territoryExpansionManagerDashboard);
    registerRoute(BusinessDevelopmentRoutes.regionalManagerOntarioDashboard, PrimeCareForm.regionalManagerOntarioDashboard);
    registerRoute(BusinessDevelopmentRoutes.regionalManagerUsaDashboard, PrimeCareForm.regionalManagerUsaDashboard);
    registerRoute(BusinessDevelopmentRoutes.franchiseSalesManagerDashboard, PrimeCareForm.franchiseSalesManagerDashboard);
    registerRoute(BusinessDevelopmentRoutes.partnershipManagerDashboard, PrimeCareForm.partnershipManagerDashboard);
    registerRoute(BusinessDevelopmentRoutes.generalManagerDashboard, PrimeCareForm.generalManagerDashboard);
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
        'regional_manager_ontario': {
          'title': 'Ontario Regional Pulse',
          'subtitle': 'Metropolitan penetration and regional efficiency.',
          'route': BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
          'kpis': [
            {
              'title': 'Regional Revenue',
              'value': r'$1.2M',
              'deltaSuffix': '+8% Growth',
              'icon': 'barChart',
              'iconColor': 'blue',
            },
          ],
        },
        'regional_manager_usa': {
          'title': 'USA Expansion Command',
          'subtitle': 'Cross-border territory growth and state-level scaling.',
          'route': BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
          'kpis': [
            {
              'title': 'New Markets',
              'value': '4',
              'deltaSuffix': 'Active Setup',
              'icon': 'barChart',
              'iconColor': 'orange',
            },
          ],
        },
        'franchise_sales_manager': {
          'title': 'Sales Conversion Center',
          'subtitle': 'Lead tracking and franchise disclosure management.',
          'route': BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
          'kpis': [
            {
              'title': 'Lead to CD',
              'value': '14.2%',
              'deltaSuffix': 'Target: 15%',
              'icon': 'barChart',
              'iconColor': 'pink',
            },
          ],
        },
        'partnership_manager': {
          'title': 'Institutional Partner Hub',
          'subtitle': 'Referral networks and insurance provider integration.',
          'route': BusinessDevelopmentRoutes.partnershipManagerDashboard,
          'kpis': [
            {
              'title': 'Referral Yield',
              'value': '420',
              'deltaSuffix': 'Monthly Avg',
              'icon': 'users',
              'iconColor': 'blue',
            },
          ],
        },
        'general_manager': {
          'title': 'Facility Command Center',
          'subtitle': 'Operational Excellence • Community Well-being',
          'route': BusinessDevelopmentRoutes.generalManagerDashboard,
          'kpis': [
            {
              'title': 'Occupancy Rate',
              'value': '94%',
              'deltaSuffix': '+1.2% Trend',
              'icon': 'users',
              'iconColor': 'blue',
            },
          ],
        },
        'territory_expansion_manager': {
          'title': 'Expansion & Strategy',
          'subtitle': 'New Market Entry • Site Selection',
          'route': BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
          'kpis': [
            {
              'title': 'Sites Vetted',
              'value': '15',
              'deltaSuffix': 'Active Research',
              'icon': 'map',
              'iconColor': 'indigo',
            },
          ],
        },
      };
}
