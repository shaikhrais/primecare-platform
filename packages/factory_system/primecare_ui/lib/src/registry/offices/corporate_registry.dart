// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'base_office_registry.dart';

class CorporateRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      CorporateRoutes.ceoDashboard,
      PrimeCareForm.ceoDashboard,
      provider: ceoDashboardAdapterProvider,
      componentLabels: [
        'corporate.ceo.labels.aura_hud',
        'corporate.ceo.labels.global_kpi',
        'corporate.ceo.labels.region_comparison',
        'corporate.ceo.labels.strategic_initiatives',
      ],
      structuralPlan: 'corporate.ceo.structural_plan',
    );
    registerRoute(
      CorporateRoutes.cooDashboard,
      PrimeCareForm.cooDashboard,
      provider: cooDashboardAdapterProvider,
      componentLabels: [
        'corporate.coo.labels.aura_hud',
        'corporate.coo.labels.operational_kpi',
        'corporate.coo.labels.branch_efficiency',
        'corporate.coo.labels.service_quality',
      ],
      structuralPlan: 'corporate.coo.structural_plan',
    );
    registerRoute(
      CorporateRoutes.cfoDashboard,
      PrimeCareForm.cfoDashboard,
      provider: cfoDashboardAdapterProvider,
      componentLabels: [
        'corporate.cfo.labels.aura_hud',
        'corporate.cfo.labels.liquidity_index',
        'corporate.cfo.labels.burn_rate',
        'corporate.cfo.labels.capital_allocation',
      ],
      structuralPlan: 'corporate.cfo.structural_plan',
    );
    // CTO Dashboard is handled via specialized CtoDashboardIntent in GovernanceRegistry
    registerRoute(
      CorporateRoutes.complianceManagerDashboard,
      PrimeCareForm.complianceManagerDashboard,
      provider: complianceManagerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Compliance Drift)',
        'Registry Integrity Score',
        'Anomaly Heatmap',
        'Execution Gate Logs',
      ],
      structuralPlan:
          'Compliance Command: Aura HUD with compliance drift telemetry. Features an anomaly heatmap for identifying procedural drift.',
    );
    registerRoute(
      CorporateRoutes.trainingDirectorDashboard,
      PrimeCareForm.trainingDirectorDashboard,
      provider: trainingDirectorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Certification Compliance)',
        'Certification Heatmap',
        'Active Course Enrollment',
        'Competency Drift Alert',
      ],
      structuralPlan:
          'LMS Governance Portal: Aura HUD with certification compliance telemetry. Middle tier handles active enrollment telemetry.',
    );
    registerRoute(
      CorporateRoutes.financeDirectorDashboard,
      PrimeCareForm.financeDirectorDashboard,
      provider: financeDirectorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Cash Flow)',
        'Financial Summary Grid',
        'Cash Flow Forecast',
        'Budget Distribution',
      ],
      structuralPlan:
          'Finance Operations: Aura HUD with cash flow telemetry. Dashboard provides a summary of receivables/payables and budget distribution.',
    );
    registerRoute(
      CorporateRoutes.headOfBusDevDashboard,
      PrimeCareForm.headOfBusDevDashboard,
      provider: headOfBusDevDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Pipeline Velocity)',
        'Pipeline Velocity Chart',
        'Expansion Roadmap Heatmap',
        'Partner Synergy Matrix',
      ],
      structuralPlan:
          'Ecosystem Expansion Hub: Aura HUD with pipeline velocity telemetry. Features an expansion roadmap heatmap and a partner synergy matrix.',
    );
    registerRoute(
      CorporateRoutes.headOfMarketingDashboard,
      PrimeCareForm.headOfMarketingDashboard,
      provider: headOfMarketingDashboardAdapterProvider,
      componentLabels: [
        'corporate.head_of_marketing.labels.aura_hud',
        'corporate.head_of_marketing.labels.campaign_heatmap',
        'corporate.head_of_marketing.labels.funnel_grid',
        'corporate.head_of_marketing.labels.brand_awareness',
      ],
      structuralPlan: 'corporate.head_of_marketing.structural_plan',
    );
    registerRoute(
      CorporateRoutes.hrManagerDashboard,
      PrimeCareForm.hrManagerDashboard,
      provider: hrHiringDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD',
        'Operational Metrics',
        'HR Action Hub',
        'Staffing Velocity',
        'Compliance Audit',
      ],
      structuralPlan:
          'HR Management Hub: Governance alignment and audit ready. Tracks hiring velocity, turnover, and compliance.',
    );
    registerRoute(
      CorporateRoutes.hrHiringDashboard,
      PrimeCareForm.hrHiringDashboard,
      provider: hrHiringDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD',
        'Hiring Analytics',
        'Pipeline Saturation',
        'Human Capital Intelligence',
        'Administrative Queue',
      ],
      structuralPlan:
          'Recruitment HUB: Manages candidate pipeline, conversion rates, and role-specific saturation.',
    );

    // Missing Corporate Dashboards
    registerRoute(
      CorporateRoutes.hrDirectorDashboard,
      PrimeCareForm.hrDirectorDashboard,
      provider: hrDirectorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Talent Retention)',
        'Succession Planning',
        'Workforce Diversity',
        'Global Compensation',
      ],
      structuralPlan:
          'Talent Governance: Strategic HR oversight for the entire enterprise.',
    );
    registerRoute(
      CorporateRoutes.cxDirectorDashboard,
      PrimeCareForm.cxDirectorDashboard,
      provider: cxDirectorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Experience Velocity)',
        'Sentiment Scorecard',
        'Retention Analysis',
        'Customer Journey Drift',
      ],
      structuralPlan:
          'Experience Governance: Tracking customer experience velocity and brand loyalty.',
    );
    registerRoute(
      CorporateRoutes.itAdminDashboard,
      PrimeCareForm.itAdminDashboard,
      provider: ctoDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (System Uptime)',
        'Resource Allocation',
        'Maintenance Queue',
        'System Logs',
      ],
      structuralPlan:
          'IT Administration: Day-to-day management of system infrastructure and resources.',
    );

    final List<Map<String, dynamic>> subScreens = [
      {
        'path': CorporateRoutes.ceoEnterpriseOverview,
        'title': 'corporate.ceo.enterprise_overview.title',
        'pid': 'ceoEnterpriseOverview',
        'labels': [
          'Aura HUD (Enterprise Health)',
          'Global Branch Heatmap',
          'Cross-Region KPI Grid',
        ],
        'plan':
            'Enterprise Macro-View: Aura HUD with global health telemetry. Features a geographic heatmap and a cross-region KPI grid.',
      },
      {
        'path': CorporateRoutes.ceoRevenueSummary,
        'title': 'corporate.ceo.revenue_summary.title',
        'pid': 'ceoRevenueSummary',
        'labels': [
          'Aura HUD (Revenue Growth)',
          'Revenue Waterfall',
          'Segment Growth Chart',
        ],
        'plan':
            'Financial Growth Engine: Aura HUD with revenue-velocity telemetry. Optimized for analyzing revenue streams through waterfall charts.',
      },
      {
        'path': CorporateRoutes.cooOperationsOverview,
        'title': 'corporate.coo.operations_overview.title',
        'pid': 'cooOperationsOverview',
        'labels': [
          'corporate.coo.operations_overview.labels.aura_hud',
          'corporate.coo.operations_overview.labels.incident_summary',
          'corporate.coo.operations_overview.labels.resource_efficiency',
        ],
        'plan': 'corporate.coo.operations_overview.structural_plan',
      },
      {
        'path': CorporateRoutes.cfoFinancialOverview,
        'title': 'corporate.cfo.financial_overview.title',
        'pid': 'cfoFinancialOverview',
        'labels': [
          'Aura HUD (Capital Liquidity)',
          'Capital Stack Grid',
          'Tax Liability Forecast',
        ],
        'plan':
            'Fiscal Governance Portal: Aura HUD with cash-reserve telemetry. Focused on capital stack visualization and tax liability modeling.',
      },
      {
        'path': CorporateRoutes.ctoSystemHealth,
        'title': 'corporate.cto.system_health.title',
        'pid': 'ctoSystemHealth',
        'labels': [
          'Aura HUD (System Uptime)',
          'Server Uptime Graph',
          'API Latency Monitor',
          'Error Density Heatmap',
        ],
        'plan':
            'Infrastructure Command: Aura HUD with real-time cluster health telemetry. Features latency monitoring and error density heatmaps.',
      },
    ];

    for (final screen in subScreens) {
      registerRoute(
        screen['path'] as String,
        PrimeCareForm.genericDashboard,
        titleKey: screen['title'] as String,
        componentLabels: screen['labels'] as List<String>,
        structuralPlan: screen['plan'] as String,
      );
    }

    registerRoute(
      CorporateRoutes.shareholderIntelligenceDashboard,
      PrimeCareForm.genericDashboard,
      provider: shareholderIntelligenceAdapterProvider,
      titleKey: 'corporate.shareholder.dashboard.title',
      componentLabels: [
        'Global Header',
        'Stage 1: Initial',
        'Stage 2: In Processing',
        'Stage 3: Implemented',
        'Stage 4: Tested & Done',
        'Telemetry Table',
      ],
      structuralPlan:
          'Shareholder Operations: Tracks platform-wide zero-error compliance, feature pipelines, and real-time intent telemetry for high-level governance visibility.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'ceo_dashboard': {
      'path': CorporateRoutes.ceoDashboard,
      'title': 'corporate.ceo.dashboard.title',
      'form': PrimeCareForm.ceoDashboard.name,
    },
    'coo_dashboard': {
      'path': CorporateRoutes.cooDashboard,
      'title': 'corporate.coo.dashboard.title',
      'form': PrimeCareForm.cooDashboard.name,
    },
    'cfo_dashboard': {
      'path': CorporateRoutes.cfoDashboard,
      'title': 'corporate.cfo.dashboard.title',
      'form': PrimeCareForm.cfoDashboard.name,
    },
    'compliance_manager': {
      'path': CorporateRoutes.complianceManagerDashboard,
      'title': 'corporate.compliance_manager.dashboard.title',
      'form': PrimeCareForm.complianceManagerDashboard.name,
    },
    'training_director': {
      'path': CorporateRoutes.trainingDirectorDashboard,
      'title': 'corporate.training_director.dashboard.title',
      'form': PrimeCareForm.trainingDirectorDashboard.name,
    },
    'finance_director': {
      'path': CorporateRoutes.financeDirectorDashboard,
      'title': 'corporate.finance_director.dashboard.title',
      'form': PrimeCareForm.financeDirectorDashboard.name,
    },
    'head_of_bus_dev': {
      'path': CorporateRoutes.headOfBusDevDashboard,
      'title': 'corporate.head_of_business_development.dashboard.title',
      'form': PrimeCareForm.headOfBusDevDashboard.name,
    },
    'head_of_marketing': {
      'path': CorporateRoutes.headOfMarketingDashboard,
      'title': 'corporate.head_of_marketing.dashboard.title',
      'form': PrimeCareForm.headOfMarketingDashboard.name,
    },
    'hr_manager': {
      'path': CorporateRoutes.hrManagerDashboard,
      'title': 'corporate.hr_manager.dashboard.title',
      'form': PrimeCareForm.hrManagerDashboard.name,
    },
    'hr_director': {
      'path': CorporateRoutes.hrDirectorDashboard,
      'title': 'corporate.hr_director.dashboard.title',
      'form': PrimeCareForm.hrDirectorDashboard.name,
    },
    'cx_director': {
      'path': CorporateRoutes.cxDirectorDashboard,
      'title': 'corporate.cx_director.dashboard.title',
      'form': PrimeCareForm.cxDirectorDashboard.name,
    },
    'it_admin': {
      'path': CorporateRoutes.itAdminDashboard,
      'title': 'corporate.it_admin.dashboard.title',
      'form': PrimeCareForm.itAdminDashboard.name,
    },
    'shareholder': {
      'path': CorporateRoutes.shareholderIntelligenceDashboard,
      'title': 'corporate.shareholder.dashboard.title',
      'form': PrimeCareForm.genericDashboard.name,
    },
  };
}
