import 'package:primecare_ui/primecare_ui.dart';
import '../office_screen_registry.dart';

class BusinessDevelopmentRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
      PrimeCareForm.territoryExpansionManagerDashboard,
      provider: territoryExpansionManagerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Expansion Roadmap)',
        'Geographic Vetting Map',
        'Site Viability Scorecard',
        'Research Log',
      ],
      structuralPlan:
          'Expansion Research Console: Aura HUD with market viability telemetry. Features interactive geographic vetting maps and viability scorecards.',
    );
    registerRoute(
      BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
      PrimeCareForm.regionalManagerOntarioDashboard,
      provider: regionalManagerOntarioDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Ontario Revenue Growth)',
        'Regional Revenue Grid',
        'Ontario Market Heatmap',
        'Site Audit Tracker',
      ],
      structuralPlan:
          'Regional Growth Hub (Ontario): Aura HUD with provincial revenue telemetry. Features a market density heatmap and a site-by-site audit tracker.',
    );
    registerRoute(
      BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
      PrimeCareForm.regionalManagerUsaDashboard,
      provider: regionalManagerUsaDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (US Expansion Velocity)',
        'Multi-state Revenue Grid',
        'USA Expansion Map',
        'Compliance Drift Log',
      ],
      structuralPlan:
          'Regional Growth Hub (USA): Aura HUD with state-level revenue telemetry. Focuses on the expansion pipeline across active states.',
    );
    registerRoute(
      BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
      PrimeCareForm.franchiseSalesManagerDashboard,
      provider: franchiseSalesManagerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Franchise Sales Funnel)',
        'Sales Funnel Visualization',
        'Candidate Lifecycle Map',
        'CD Pipeline Monitor',
      ],
      structuralPlan:
          'Sales Command Center: Aura HUD with lead-to-close telemetry. Primary focus on funnel visualization and candidate lifecycle tracking.',
    );
    registerRoute(
      BusinessDevelopmentRoutes.partnershipManagerDashboard,
      PrimeCareForm.partnershipManagerDashboard,
      provider: partnershipManagerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Partner Synergy Matrix)',
        'Partner Referral Grid',
        'Affiliate Performance Table',
        'Synergy DashboardMetrics',
      ],
      structuralPlan:
          'Ecosystem Hub: Aura HUD with referral volume telemetry. Provides detailed view of partner performance and synergy impact metrics.',
    );
    registerRoute(
      BusinessDevelopmentRoutes.generalManagerDashboard,
      PrimeCareForm.generalManagerDashboard,
      provider: generalManagerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Occupancy Trend)',
        'Occupancy Heatmap',
        'Facility Revenue Grid',
        'Resource Utilization',
      ],
      structuralPlan:
          'Site Operations Command: Aura HUD with occupancy telemetry. Main dashboard features facility-level revenue performance and resource utilization heatmaps.',
    );
    registerRoute(
      BusinessDevelopmentRoutes.regionalBdmDashboard,
      PrimeCareForm.regionalBdmDashboard,
      provider: regionalBdmDashboardAdapterProvider,
      titleKey: LocaleKeys.business_development_regional_bdm_dashboard_title,
      componentLabels: [
        'Aura HUD',
        'Territory Performance Heatmap',
        'BDM Activity Log',
        'Conversion Statistics',
      ],
      structuralPlan:
          'Regional BDM Command: Aura HUD with territory performance telemetry. Features a heatmap for local market penetration and a conversion-focused activity log.',
    );
    // Regional Views (Dynamic Expansion)
    final List<String> regions = ['ontario', 'usa', 'quebec', 'bc', 'alberta', 'maritimes'];
    final List<String> domains = ['finance', 'clinical', 'operations', 'hr', 'marketing', 'compliance'];

    for (final region in regions) {
      for (final domain in domains) {
        registerRoute(
          '/business-development/$region-$domain-regional-view',
          PrimeCareForm.genericDashboard,
          titleKey: 'registries_businessDevelopment_${region}_${domain}_regional_view',
          componentLabels: [
            'Aura HUD',
            'Regional Heatmap',
            'Site Compliance Grid',
            'Territory KPI HUD'
          ],
        );
      }
    }
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson {
    final Map<String, Map<String, dynamic>> base = {
      'regional_manager_ontario': {
        'title': 'business_development.regional_manager_ontario.dashboard.title',
        'subtitle':
            'business_development.regional_manager_ontario.dashboard.subtitle',
        'route': BusinessDevelopmentRoutes.regionalManagerOntarioDashboard,
        'componentLabels': [
          'Aura HUD (Ontario Revenue Growth)',
          'Regional Revenue Grid',
          'Ontario Market Heatmap',
          'Site Audit Tracker',
        ],
        'structuralPlan':
            'Regional Growth Hub (Ontario): Aura HUD with provincial revenue telemetry. Features a market density heatmap and a site-by-site audit tracker.',
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
        'title': 'business_development.regional_manager_usa.dashboard.title',
        'subtitle':
            'business_development.regional_manager_usa.dashboard.subtitle',
        'route': BusinessDevelopmentRoutes.regionalManagerUsaDashboard,
        'componentLabels': [
          'Aura HUD (US Expansion Velocity)',
          'Multi-state Revenue Grid',
          'USA Expansion Map',
          'Compliance Drift Log',
        ],
        'structuralPlan':
            'Regional Growth Hub (USA): Aura HUD with state-level revenue telemetry. Focuses on the expansion pipeline across active states.',
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
        'title': 'business_development.franchise_sales_manager.dashboard.title',
        'subtitle':
            'business_development.franchise_sales_manager.dashboard.subtitle',
        'route': BusinessDevelopmentRoutes.franchiseSalesManagerDashboard,
        'componentLabels': [
          'Aura HUD (Franchise Sales Funnel)',
          'Sales Funnel Visualization',
          'Candidate Lifecycle Map',
          'CD Pipeline Monitor',
        ],
        'structuralPlan':
            'Sales Command Center: Aura HUD with lead-to-close telemetry. Primary focus on funnel visualization and candidate lifecycle tracking.',
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
        'title': 'business_development.partnership_manager.dashboard.title',
        'subtitle':
            'business_development.partnership_manager.dashboard.subtitle',
        'route': BusinessDevelopmentRoutes.partnershipManagerDashboard,
        'componentLabels': [
          'Aura HUD (Partner Synergy Matrix)',
          'Partner Referral Grid',
          'Affiliate Performance Table',
          'Synergy DashboardMetrics',
        ],
        'structuralPlan':
            'Ecosystem Hub: Aura HUD with referral volume telemetry. Provides detailed view of partner performance and synergy impact metrics.',
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
        'title': 'business_development.general_manager.dashboard.title',
        'subtitle': 'business_development.general_manager.dashboard.subtitle',
        'route': BusinessDevelopmentRoutes.generalManagerDashboard,
        'componentLabels': [
          'Aura HUD (Occupancy Trend)',
          'Occupancy Heatmap',
          'Facility Revenue Grid',
          'Resource Utilization',
        ],
        'structuralPlan':
            'Site Operations Command: Aura HUD with occupancy telemetry. Main dashboard features facility-level revenue performance and resource utilization heatmaps.',
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
        'title':
            'business_development.territory_expansion_manager.dashboard.title',
        'subtitle':
            'business_development.territory_expansion_manager.dashboard.subtitle',
        'route': BusinessDevelopmentRoutes.territoryExpansionManagerDashboard,
        'componentLabels': [
          'Aura HUD (Expansion Roadmap)',
          'Geographic Vetting Map',
          'Site Viability Scorecard',
          'Research Log',
        ],
        'structuralPlan':
            'Expansion Research Console: Aura HUD with market viability telemetry. Features interactive geographic vetting maps and viability scorecards.',
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
      'regional_bdm': {
        'title': 'business_development.regional_bdm.dashboard.title',
        'subtitle': 'business_development.regional_bdm.dashboard.subtitle',
        'route': BusinessDevelopmentRoutes.regionalBdmDashboard,
        'componentLabels': [
          'Aura HUD',
          'Territory Performance Heatmap',
          'BDM Activity Log',
          'Conversion Statistics',
        ],
        'structuralPlan':
            'Regional BDM Command: Aura HUD with territory performance telemetry. Features a heatmap for local market penetration and a conversion-focused activity log.',
        'kpis': [
          {
            'title': 'Conversion Rate',
            'value': '24%',
            'deltaSuffix': '+2.5% Trend',
            'icon': 'barChart',
            'iconColor': 'green',
          },
        ],
      },
    };

    // Inject Regional Views
    final List<String> regions = [
      'ontario',
      'usa',
      'quebec',
      'bc',
      'alberta',
      'maritimes'
    ];
    final List<String> domains = [
      'finance',
      'clinical',
      'operations',
      'hr',
      'marketing',
      'compliance'
    ];

    for (final region in regions) {
      for (final domain in domains) {
        final key =
            'registries_businessDevelopment_${region}_${domain}_regional_view';
        base[key] = {
          'title': 'LocaleKeys.$key',
          'path': '/business-development/$region-$domain-regional-view',
          'componentLabels': [
            'Aura HUD',
            'Regional Heatmap',
            'Site Compliance Grid',
            'Territory KPI HUD'
          ],
        };
      }
    }

    return base;
  }
}
