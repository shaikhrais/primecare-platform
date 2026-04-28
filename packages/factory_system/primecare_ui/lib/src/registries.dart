import 'package:primecare_ui/primecare_ui.dart';

abstract class OfficeScreenRegistry {
  /// Defines hardcoded role-based routing
  void bootstrap();

  /// Defines dynamic dashboard configuration
  Map<String, Map<String, dynamic>> get registryJson;

  /// Helper to register screen using generic blueprint and form
  void registerRoute(
    String route,
    PrimeCareForm form, {
    dynamic provider,
    List<String>? componentLabels,
    String? structuralPlan,
    String? titleKey,
  }) {
    final roleName =
        route
            .split('/')
            .where(
              (s) =>
                  s.isNotEmpty &&
                  s != 'offices' &&
                  s != 'roles' &&
                  s != 'dashboard' &&
                  s != 'infrastructure',
            )
            .firstOrNull ??
        'guest';

    ScreenRegistry.registerScreen(
      PrimeCareScreen(
        name: roleName,
        title: titleKey ?? form.label,
        route: route,
        requiredRole: PlatformRole.fromRoute(route),
        provider: provider ?? genericDashboardAdapterProvider(form),
        blueprints: const <UIComponentBlueprint>[
          AuraDashboardHudBlueprint(),
          StatGridBlueprint(dataPayload: <dynamic>[]),
        ],
        componentLabels: componentLabels ?? ['Aura HUD', 'KPI Stat Grid'],
        structuralPlan: structuralPlan,
      ),
    );
  }

  /// Helper to register customized high-fidelity dashboards
  void registerCustomDashboard(
    String route,
    String title,
    String pid, {
    List<String>? componentLabels,
    List<UIComponentBlueprint>? blueprints,
    String? structuralPlan,
  }) {
    ScreenRegistry.registerScreen(
      PrimeCareScreen(
        name: pid,
        title: title,
        route: route,
        provider: genericDashboardAdapterProvider(
          PrimeCareForm.fromString(pid) ?? PrimeCareForm.genericDashboard,
        ),
        blueprints:
            blueprints ??
            const <UIComponentBlueprint>[
              AuraDashboardHudBlueprint(),
              StatGridBlueprint(dataPayload: <dynamic>[]),
            ],
        componentLabels: componentLabels ?? ['Aura HUD', 'Custom Stat Grid'],
        structuralPlan: structuralPlan,
      ),
    );
  }
}

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
    registerRoute(
      CorporateRoutes.complianceManagerDashboard,
      PrimeCareForm.complianceManagerDashboard,
      provider: complianceManagerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Compliance Drift)',
        'DashboardRegistry Integrity Score',
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
          'Finance Operations: Aura HUD with cash flow telemetry. DashboardsComplianceManagerDashboard provides a summary of receivables/payables and budget distribution.',
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
        'Operational DashboardMetrics',
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

class FranchiseRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      FranchiseRoutes.franchiseOwnerDashboard,
      PrimeCareForm.franchiseOwnerDashboard,
      componentLabels: [
        'Aura HUD (Weekly Revenue)',
        'Business KPI Grid',
        'Staff Oversight Table',
        'Revenue Growth Chart',
      ],
      structuralPlan:
          'Local Business Command: Aura HUD with revenue telemetry. Top section features a business KPI grid. Middle section focuses on staff oversight.',
    );
    registerRoute(
      FranchiseRoutes.operationsManagerDashboard,
      PrimeCareForm.operationsManagerDashboard,
      componentLabels: [
        'Aura HUD (Utilization Score)',
        'Logistics KPI Grid',
        'Resource Allocation Map',
        'Efficiency DashboardMetrics',
      ],
      structuralPlan:
          'Logistics Command Center: Aura HUD with utilization telemetry. Main layout features a resource allocation map and efficiency metrics.',
    );
    registerRoute(
      FranchiseRoutes.schedulerDashboard,
      PrimeCareForm.schedulerDashboard,
      componentLabels: [
        'Aura HUD (Shift Coverage)',
        'Scheduling Stat Grid',
        'Shift Coordination Calendar',
        'Urgent Coverage List',
      ],
      structuralPlan:
          'Coordination Hub: Aura HUD with shift coverage telemetry. Centered around a coordination calendar with an urgent remediation sidebar.',
    );
    registerRoute(
      FranchiseRoutes.billingAdminDashboard,
      PrimeCareForm.billingAdminDashboard,
      componentLabels: [
        'Aura HUD (AR Velocity)',
        'Billing Stat Grid',
        'Pending Claims Ledger',
        'Collection Status Chart',
      ],
      structuralPlan:
          'Revenue Recovery Console: Aura HUD with AR telemetry. Primary focus on the pending claims ledger and collection status visualization.',
    );
    registerRoute(
      FranchiseRoutes.hrHiringDashboard,
      PrimeCareForm.hrHiringDashboard,
      componentLabels: [
        'Aura HUD (Pipeline Velocity)',
        'Recruitment KPI Grid',
        'Candidate Pipeline View',
        'Onboarding Checklist',
      ],
      structuralPlan:
          'Talent Pipeline Command: Aura HUD with recruitment throughput telemetry. Features a candidate pipeline and onboarding compliance checklists.',
    );
    registerRoute(
      FranchiseRoutes.regionalManagerDashboard,
      PrimeCareForm.regionalManagerDashboard,
      provider: regionalBdmDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Regional Growth)',
        'Regional KPI Grid',
        'Multi-site Performance Table',
        'Synergy Audit Log',
      ],
      structuralPlan:
          'Regional Governance Portal: Aura HUD with growth telemetry. DashboardsComplianceManagerDashboard focuses on comparative analysis and synergy audit logs.',
    );
    registerRoute(
      FranchiseRoutes.marketingManagerDashboard,
      PrimeCareForm.marketingManagerDashboard,
      provider: localMarketingManagerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Lead Conversion)',
        'Marketing KPI Grid',
        'Lead Conversion Funnel',
        'Brand Awareness DashboardMetrics',
      ],
      structuralPlan:
          'Growth & Branding Hub: Aura HUD with conversion telemetry. Features a visual conversion funnel and brand awareness heatmaps.',
    );

    registerRoute(
      FranchiseRoutes.franchiseOwnerFinancialSnapshot,
      PrimeCareForm.financialSnapshot,
      componentLabels: [
        'Aura HUD (Cash Flow)',
        'Balance Sheet Grid',
        'P&L Waterfall Chart',
        'Cash Flow Forecast',
      ],
      structuralPlan:
          'Fiscal Transparency Portal: Aura HUD with cash-on-hand telemetry. AuthLayout utilizes a waterfall chart for P&L analysis and a cash flow forecast.',
    );
    registerRoute(
      FranchiseRoutes.hrHiringOnboarding,
      PrimeCareForm.onboardingWizard,
      componentLabels: [
        'Aura HUD (Verification Rate)',
        'Multi-step Progress Bar',
        'Document Upload Zone',
        'Credential Verification',
      ],
      structuralPlan:
          'Guided Integration Flow: Aura HUD with verification telemetry. Utilizes a progress bar guiding users through document collection.',
    );
    registerRoute(
      FranchiseRoutes.adminInvoices,
      PrimeCareForm.invoiceManagement,
      componentLabels: [
        'Aura HUD (Billing Accuracy)',
        'Invoice SystemVerificationData Table',
        'Batch Processing Actions',
        'Tax Summary Card',
      ],
      structuralPlan:
          'Financial SystemVerificationData Engine: Aura HUD with accuracy telemetry. Features a high-density data table for invoice auditing and batch processing.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'franchise_owner': {
      'title': 'franchise.franchise_owner.dashboard.title',
      'subtitle': 'franchise.franchise_owner.dashboard.subtitle',
      'route': FranchiseRoutes.franchiseOwnerDashboard,
      'componentLabels': [
        'Aura HUD (Weekly Revenue)',
        'Business KPI Grid',
        'Staff Oversight Table',
        'Revenue Growth Chart',
      ],
      'structuralPlan':
          'Local Business Command: Aura HUD with revenue telemetry. Top section features a business KPI grid. Middle section focuses on staff oversight.',
      'kpis': [
        {
          'title': 'Revenue',
          'value': r'$42k',
          'deltaSuffix': '+5% this week',
          'icon': 'dollarSign',
          'iconColor': 'green',
        },
      ],
    },
    'financial_snapshot': {
      'title': 'franchise.franchise_owner.financial_snapshot.title',
      'subtitle': 'franchise.franchise_owner.financial_snapshot.subtitle',
      'route': FranchiseRoutes.franchiseOwnerFinancialSnapshot,
      'componentLabels': [
        'Aura HUD (Cash Flow)',
        'Balance Sheet Grid',
        'P&L Waterfall Chart',
        'Cash Flow Forecast',
      ],
      'structuralPlan':
          'Fiscal Transparency Portal: Aura HUD with cash-on-hand telemetry. AuthLayout utilizes a waterfall chart for P&L analysis and a cash flow forecast.',
    },
    'operations_manager': {
      'title': 'franchise.operations_manager.dashboard.title',
      'subtitle': 'franchise.operations_manager.dashboard.subtitle',
      'route': FranchiseRoutes.operationsManagerDashboard,
      'componentLabels': [
        'Aura HUD (Utilization Score)',
        'Logistics KPI Grid',
        'Resource Allocation Map',
        'Efficiency DashboardMetrics',
      ],
      'structuralPlan':
          'Logistics Command Center: Aura HUD with utilization telemetry. Main layout features a resource allocation map and efficiency metrics.',
      'kpis': [
        {
          'title': 'Efficiency Score',
          'value': '88',
          'deltaSuffix': 'Target: 90',
          'icon': 'zap',
          'iconColor': 'amber',
        },
      ],
      'highFidelityViewId': 'operationsManagerDashboardViewModel',
    },
    'scheduler': {
      'title': 'franchise.scheduler.dashboard.title',
      'subtitle': 'franchise.scheduler.dashboard.subtitle',
      'route': FranchiseRoutes.schedulerDashboard,
      'componentLabels': [
        'Aura HUD (Shift Coverage)',
        'Scheduling Stat Grid',
        'Shift Coordination Calendar',
        'Urgent Coverage List',
      ],
      'structuralPlan':
          'Coordination Hub: Aura HUD with shift coverage telemetry. Centered around a coordination calendar with an urgent remediation sidebar.',
      'kpis': [
        {
          'title': 'Open Shifts',
          'value': '14',
          'deltaSuffix': 'Critical Priority',
          'icon': 'clock',
          'iconColor': 'red',
        },
      ],
    },
    'billing_admin': {
      'title': 'franchise.billing_admin.dashboard.title',
      'subtitle': 'franchise.billing_admin.dashboard.subtitle',
      'route': FranchiseRoutes.billingAdminDashboard,
      'componentLabels': [
        'Aura HUD (AR Velocity)',
        'Billing Stat Grid',
        'Pending Claims Ledger',
        'Collection Status Chart',
      ],
      'structuralPlan':
          'Revenue Recovery Console: Aura HUD with AR telemetry. Primary focus on the pending claims ledger and collection status visualization.',
      'kpis': [
        {
          'title': 'Pending Claims',
          'value': '124',
          'deltaSuffix': r'$12,400',
          'icon': 'clipboardList',
          'iconColor': 'orange',
        },
      ],
    },
    'invoice_management': {
      'title': 'franchise.billing_admin.invoices.title',
      'subtitle': 'franchise.billing_admin.invoices.subtitle',
      'route': FranchiseRoutes.adminInvoices,
      'componentLabels': [
        'Aura HUD (Billing Accuracy)',
        'Invoice SystemVerificationData Table',
        'Batch Processing Actions',
        'Tax Summary Card',
      ],
      'structuralPlan':
          'Financial SystemVerificationData Engine: Aura HUD with accuracy telemetry. Features a high-density data table for invoice auditing and batch processing.',
    },
    'hr_hiring': {
      'title': 'franchise.hr_hiring.dashboard.title',
      'subtitle': 'franchise.hr_hiring.dashboard.subtitle',
      'route': FranchiseRoutes.hrHiringDashboard,
      'componentLabels': [
        'Aura HUD (Pipeline Velocity)',
        'Recruitment KPI Grid',
        'Candidate Pipeline View',
        'Onboarding Checklist',
      ],
      'structuralPlan':
          'Talent Pipeline Command: Aura HUD with recruitment throughput telemetry. Features a candidate pipeline and onboarding compliance checklists.',
      'kpis': [
        {
          'title': 'Active Requisitions',
          'value': '8',
          'deltaSuffix': 'Next 14 days',
          'icon': 'briefcase',
          'iconColor': 'blue',
        },
      ],
      'highFidelityViewId': 'hrManagerDashboardViewModel',
    },
    'onboarding_wizard': {
      'title': 'franchise.hr_hiring.onboarding.title',
      'subtitle': 'franchise.hr_hiring.onboarding.subtitle',
      'route': FranchiseRoutes.hrHiringOnboarding,
      'componentLabels': [
        'Aura HUD (Verification Rate)',
        'Multi-step Progress Bar',
        'Document Upload Zone',
        'Credential Verification',
      ],
      'structuralPlan':
          'Guided Integration Flow: Aura HUD with verification telemetry. Utilizes a progress bar guiding users through document collection.',
    },
    'regional_manager': {
      'title': 'franchise.regional_manager.dashboard.title',
      'subtitle': 'franchise.regional_manager.dashboard.subtitle',
      'route': FranchiseRoutes.regionalManagerDashboard,
      'componentLabels': [
        'Aura HUD (Regional Growth)',
        'Regional KPI Grid',
        'Multi-site Performance Table',
        'Synergy Audit Log',
      ],
      'structuralPlan':
          'Regional Governance Portal: Aura HUD with growth telemetry. DashboardsComplianceManagerDashboard focuses on comparative analysis and synergy audit logs.',
      'kpis': [
        {
          'title': 'Regional Revenue',
          'value': r'$420k',
          'deltaSuffix': '+12% YoY',
          'icon': 'barChart',
          'iconColor': 'blue',
        },
      ],
    },
    'marketing_manager': {
      'title': 'franchise.marketing_manager.dashboard.title',
      'subtitle': 'franchise.marketing_manager.dashboard.subtitle',
      'route': FranchiseRoutes.marketingManagerDashboard,
      'componentLabels': [
        'Aura HUD (Lead Conversion)',
        'Marketing KPI Grid',
        'Lead Conversion Funnel',
        'Brand Awareness DashboardMetrics',
      ],
      'structuralPlan':
          'Growth & Branding Hub: Aura HUD with conversion telemetry. Features a visual conversion funnel and brand awareness heatmaps.',
      'kpis': [
        {
          'title': 'Lead Volume',
          'value': '145',
          'deltaSuffix': 'This month',
          'icon': 'zap',
          'iconColor': 'pink',
        },
      ],
    },
  };
}

class ClinicalRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      ClinicalRoutes.clinicalDirectorDashboard,
      PrimeCareForm.clinicalDirectorDashboard,
      provider: clinicalDirectorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Clinical Safety Score)',
        'Staffing Heatmap',
        'Protocol Compliance Log',
        'Incident Trend Chart',
      ],
      structuralPlan:
          'Clinical Oversight Hub: Aura HUD with high-priority safety metrics. Main grid contains staffing heatmaps and a detailed protocol compliance log with incident trending.',
    );
    registerRoute(
      ClinicalRoutes.intakeCoordinatorDashboard,
      PrimeCareForm.intakeCoordinatorDashboard,
      provider: intakeCoordinatorDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Total Active Intakes)',
        'Intake Funnel Chart',
        'Urgent Referral List',
        'Capacity Availability Grid',
      ],
      structuralPlan:
          'Throughput Command: Aura HUD with volume telemetry. Features a funnel visualization for intake progression and urgency-sorted referral lists.',
    );
    registerRoute(
      ClinicalRoutes.nurseDashboard,
      PrimeCareForm.nurseDashboard,
      provider: rnDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Critical Alerts)',
        'MAR (Medication Record)',
        'Nurse Assessment Grid',
      ],
      structuralPlan:
          'Nursing Command Center: Aura HUD with patient-safety telemetry. Features a comprehensive MAR and nursing assessment workflows.',
    );
    registerRoute(
      ClinicalRoutes.rnDashboard,
      PrimeCareForm.nurseDashboard,
      provider: rnDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Vitals Criticality)',
        'MAR (Medication Record)',
        'Wound Care Assessment',
        'Clinical Triage Grid',
      ],
      structuralPlan:
          'Advanced Care Console: Aura HUD with critical alert telemetry. Dominant MAR interface paired with structured wound care assessments and triage logic.',
    );
    registerRoute(
      ClinicalRoutes.therapistDashboard,
      PrimeCareForm.therapistDashboard,
      provider: rmtDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Treatment Velocity)',
        'Patient Anatomy Map',
        'SOAP Note Builder',
        'Treatment Plan View',
      ],
      structuralPlan:
          'Therapeutic Assessment Console: Aura HUD with treatment history. Interactive anatomy mapping integrated with SOAP note construction and plan tracking.',
    );
    registerRoute(
      ClinicalRoutes.pswDashboard,
      PrimeCareForm.pswDashboard,
      provider: pswDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Visit Completion %)',
        'Patient Summary Cards',
        'Task Checklist',
        'Incident Quick-Report',
      ],
      structuralPlan:
          'Field Care Portal: Aura HUD with visit throughput telemetry. AuthLayout centers on high-visibility patient summary cards and a real-time task checklist for incident monitoring.',
    );
    registerRoute(
      ClinicalRoutes.socialWorkerDashboard,
      PrimeCareForm.socialWorkerDashboard,
      provider: socialWorkerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Crisis Response Time)',
        'Psychosocial Observation Log',
        'Resource Mapping Tool',
        'Intervention Tracker',
      ],
      structuralPlan:
          'Social Care Command: Aura HUD with response-time telemetry. Centers on psychosocial logging and a real-time intervention tracking grid.',
    );

    registerRoute(
      ClinicalRoutes.infectionControlDashboard,
      PrimeCareForm.infectionControlDashboard,
      provider: infectionControlDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Infection Velocity)',
        'Transmission Trend',
        'Outbreak Monitoring Grid',
        'Immunization Tracker',
      ],
      structuralPlan:
          'Public Health Hub: Aura HUD with infection telemetry. Features outbreak tracking and immunization status.',
    );

    registerRoute(
      ClinicalRoutes.customerSupportDashboard,
      PrimeCareForm.customerSupportDashboard,
      provider: customerSupportDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (MTTR)',
        'Live Ticket Queue',
        'SLA Performance Grid',
        'Customer Sentiment Hub',
      ],
      structuralPlan:
          'Service Excellence Console: Aura HUD with ticket volume telemetry. DashboardsComplianceManagerDashboard features a live ticket queue and SLA performance monitoring.',
    );
    registerRoute(
      ClinicalRoutes.supportIntakeCoordinatorDashboard,
      PrimeCareForm.intakeCoordinatorDashboard,
      provider: intakeDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Intake Velocity)',
        'Referral Pipeline',
        'Payer Verification',
        'Coordination Log',
      ],
      structuralPlan:
          'Patient Admission Pipeline: Aura HUD with referral throughput telemetry. Features a multi-stage referral pipeline and payer verification status monitoring.',
    );
    registerRoute(
      ClinicalRoutes.qualityAssuranceDashboard,
      PrimeCareForm.qualityAssuranceDashboard,
      provider: qualityAssuranceDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Compliance Drift)',
        'Medication Safety Log',
        'Incident Trend Analysis',
        'Compliance Audit Grid',
      ],
      structuralPlan:
          'Quality Oversight Command: Aura HUD with compliance drift telemetry. Main grid displays incident trends and compliance audit results.',
    );

    registerRoute(
      ClinicalRoutes.intakeCoordinatorReferrals,
      PrimeCareForm.referralManagement,
      componentLabels: [
        'Aura HUD (Conversion Rate %)',
        'Referral Source Grid',
        'Lead Prioritization List',
        'Inquiry Log',
      ],
      structuralPlan:
          'Inbound Pipeline: Aura HUD with conversion telemetry. Prioritizes high-value lead processing and source-attribution analytics.',
    );
    registerRoute(
      ClinicalRoutes.intakeCoordinatorAssessments,
      PrimeCareForm.intakeAssessment,
      componentLabels: [
        'Aura HUD (Intake Time)',
        'Smart Intake Form',
        'Document Verification Status',
        'Risk Triage Indicator',
      ],
      structuralPlan:
          'Patient Onboarding Portal: Aura HUD with velocity tracking. Main section features the smart intake form builder with document verification gates.',
    );
    registerRoute(
      ClinicalRoutes.clinicalDirectorQualityMetrics,
      PrimeCareForm.qualityMetrics,
      componentLabels: [
        'Aura HUD',
        'Outcome Variance Chart',
        'Sentinel Event Log',
        'Best-Practice Audit',
      ],
      structuralPlan:
          'Clinical Governance Engine: Aura HUD with sentinel event telemetry. AuthLayout prioritizes outcome variance visualization and rigorous best-practice audit checklists.',
    );

    registerRoute(
      OfficeRoutes.schedulerDashboard,
      PrimeCareForm.schedulerDashboard,
      provider: schedulerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Shift Coverage)',
        'Scheduling Stat Grid',
        'Shift Coordination Calendar',
        'Urgent Coverage List',
      ],
      structuralPlan:
          'Coordination Hub: Aura HUD with shift coverage telemetry. Centered around a coordination calendar with an urgent remediation sidebar.',
    );
    registerRoute(
      OfficeRoutes.billingAdminDashboard,
      PrimeCareForm.billingAdminDashboard,
      provider: billingAdminDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (AR Velocity)',
        'Billing Stat Grid',
        'Pending Claims Ledger',
        'Collection Status Chart',
      ],
      structuralPlan:
          'Revenue Recovery Console: Aura HUD with AR telemetry. Primary focus on the pending claims ledger and collection status visualization.',
    );
    registerRoute(
      OfficeRoutes.hrHiringDashboard,
      PrimeCareForm.hrHiringDashboard,
      provider: hrHiringDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Pipeline Velocity)',
        'Recruitment KPI Grid',
        'Candidate Pipeline View',
        'Onboarding Checklist',
      ],
      structuralPlan:
          'Talent Pipeline Command: Aura HUD with recruitment throughput telemetry. Features a candidate pipeline and onboarding compliance checklists.',
    );
    registerRoute(
      OfficeRoutes.receptionistDashboard,
      PrimeCareForm.receptionistDashboard,
      provider: receptionistDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Visitor Flow)',
        'Receptionist KPI Grid',
        'Check-in Queue',
        'Directory Search',
      ],
      structuralPlan:
          'Front-Office Command: Aura HUD with visitor flow telemetry. Prioritizes real-time check-in management and institutional directory access.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'clinical_director': {
      'title': 'clinical.clinical_director.dashboard.title',
      'subtitle': 'clinical.clinical_director.dashboard.subtitle',
      'route': ClinicalRoutes.clinicalDirectorDashboard,
      'componentLabels': [
        'Aura HUD (Clinical Safety Score)',
        'Staffing Heatmap',
        'Protocol Compliance Log',
        'Incident Trend Chart',
      ],
      'structuralPlan':
          'Clinical Oversight Hub: Aura HUD with high-priority safety metrics. Main grid contains staffing heatmaps and a detailed protocol compliance log with incident trending.',
      'kpis': [
        {
          'title': 'Incident Rate',
          'value': '0.1%',
          'deltaSuffix': 'Goal: < 0.5%',
          'icon': 'activity',
          'iconColor': 'green',
        },
      ],
    },
    'quality_metrics': {
      'title': 'clinical.clinical_director.quality_metrics.title',
      'subtitle': 'clinical.clinical_director.quality_metrics.subtitle',
      'route': ClinicalRoutes.clinicalDirectorQualityMetrics,
      'componentLabels': [
        'Aura HUD',
        'Outcome Variance Chart',
        'Sentinel Event Log',
        'Best-Practice Audit',
      ],
      'structuralPlan':
          'Clinical Governance Engine: Aura HUD with sentinel event telemetry. AuthLayout prioritizes outcome variance visualization and rigorous best-practice audit checklists.',
    },
    'intake_coordinator': {
      'title': 'clinical.intake_coordinator.dashboard.title',
      'subtitle': 'clinical.intake_coordinator.dashboard.subtitle',
      'route': ClinicalRoutes.intakeCoordinatorDashboard,
      'componentLabels': [
        'Aura HUD (Total Active Intakes)',
        'Intake Funnel Chart',
        'Urgent Referral List',
        'Capacity Availability Grid',
      ],
      'structuralPlan':
          'Throughput Command: Aura HUD with volume telemetry. Features a funnel visualization for intake progression and urgency-sorted referral lists.',
    },
    'referral_management': {
      'title': 'clinical.intake_coordinator.referrals.title',
      'subtitle': 'clinical.intake_coordinator.referrals.subtitle',
      'route': ClinicalRoutes.intakeCoordinatorReferrals,
      'componentLabels': [
        'Aura HUD (Conversion Rate %)',
        'Referral Source Grid',
        'Lead Prioritization List',
        'Inquiry Log',
      ],
      'structuralPlan':
          'Inbound Pipeline: Aura HUD with conversion telemetry. Prioritizes high-value lead processing and source-attribution analytics.',
    },
    'intake_assessment': {
      'title': 'clinical.intake_coordinator.assessments.title',
      'subtitle': 'clinical.intake_coordinator.assessments.subtitle',
      'route': ClinicalRoutes.intakeCoordinatorAssessments,
      'componentLabels': [
        'Aura HUD (Intake Time)',
        'Smart Intake Form',
        'Document Verification Status',
        'Risk Triage Indicator',
      ],
      'structuralPlan':
          'Patient Onboarding Portal: Aura HUD with velocity tracking. Main section features the smart intake form builder with document verification gates.',
    },
    'psw': {
      'title': 'clinical.psw.dashboard.title',
      'subtitle': 'clinical.psw.dashboard.subtitle',
      'route': ClinicalRoutes.pswDashboard,
      'componentLabels': [
        'Aura HUD (Visit Completion %)',
        'Patient Summary Cards',
        'Task Checklist',
        'Incident Quick-Report',
      ],
      'structuralPlan':
          'Field Care Portal: Aura HUD with visit throughput telemetry. AuthLayout centers on high-visibility patient summary cards and a real-time task checklist for incident monitoring.',
    },
    'rn': {
      'title': 'clinical.rn.dashboard.title',
      'subtitle': 'clinical.rn.dashboard.subtitle',
      'route': ClinicalRoutes.rnDashboard,
      'componentLabels': [
        'Aura HUD (Vitals Criticality)',
        'MAR (Medication Record)',
        'Wound Care Assessment',
        'Clinical Triage Grid',
      ],
      'structuralPlan':
          'Advanced Care Console: Aura HUD with critical alert telemetry. Dominant MAR interface paired with structured wound care assessments and triage logic.',
    },
    'rmt': {
      'title': 'clinical.rmt.dashboard.title',
      'subtitle': 'clinical.rmt.dashboard.subtitle',
      'route': ClinicalRoutes.therapistDashboard,
      'componentLabels': [
        'Aura HUD (Treatment Velocity)',
        'Patient Anatomy Map',
        'SOAP Note Builder',
        'Treatment Plan View',
      ],
      'structuralPlan':
          'Therapeutic Assessment Console: Aura HUD with treatment history. Interactive anatomy mapping integrated with SOAP note construction and plan tracking.',
    },
    'social_worker': {
      'title': 'clinical.social_worker.dashboard.title',
      'subtitle': 'clinical.social_worker.dashboard.subtitle',
      'route': ClinicalRoutes.socialWorkerDashboard,
      'componentLabels': [
        'Aura HUD (Crisis Response Time)',
        'Psychosocial Observation Log',
        'Resource Mapping Tool',
        'Intervention Tracker',
      ],
      'structuralPlan':
          'Social Care Command: Aura HUD with response-time telemetry. Centers on psychosocial logging and a real-time intervention tracking grid.',
    },
    'infection_control': {
      'title': 'clinical.infection_control.dashboard.title',
      'subtitle': 'clinical.infection_control.dashboard.subtitle',
      'route': ClinicalRoutes.infectionControlDashboard,
      'componentLabels': [
        'Aura HUD (Infection Velocity)',
        'Transmission Trend',
        'Outbreak Monitoring Grid',
        'Immunization Tracker',
      ],
      'structuralPlan':
          'Public Health Hub: Aura HUD with infection telemetry. Features outbreak tracking and immunization status.',
    },
    'quality_assurance': {
      'title': 'support.quality_assurance.dashboard.title',
      'subtitle': 'support.quality_assurance.dashboard.subtitle',
      'route': ClinicalRoutes.qualityAssuranceDashboard,
      'componentLabels': [
        'Aura HUD (Compliance Drift)',
        'Medication Safety Log',
        'Incident Trend Analysis',
        'Compliance Audit Grid',
      ],
      'structuralPlan':
          'Quality Oversight Command: Aura HUD with compliance drift telemetry. Main grid displays incident trends and compliance audit results.',
      'kpis': [
        {
          'title': 'Medication Errors',
          'value': '0.02%',
          'deltaSuffix': 'Below Target',
          'icon': 'shieldAlert',
          'iconColor': 'blue',
        },
      ],
    },
    'customer_support': {
      'title': 'support.customer_support.dashboard.title',
      'subtitle': 'support.customer_support.dashboard.subtitle',
      'route': ClinicalRoutes.customerSupportDashboard,
      'componentLabels': [
        'Aura HUD (MTTR)',
        'Live Ticket Queue',
        'SLA Performance Grid',
        'Customer Sentiment Hub',
      ],
      'structuralPlan':
          'Service Excellence Console: Aura HUD with ticket volume telemetry. DashboardsComplianceManagerDashboard features a live ticket queue and SLA performance monitoring.',
      'kpis': [
        {
          'title': 'Open Tickets',
          'value': '24',
          'deltaSuffix': 'Avg wait: 4m',
          'icon': 'ticket',
          'iconColor': 'blue',
        },
      ],
    },
    'support_intake': {
      'title': 'support.intake_coordinator.dashboard.title',
      'subtitle': 'support.intake_coordinator.dashboard.subtitle',
      'route': ClinicalRoutes.supportIntakeCoordinatorDashboard,
      'componentLabels': [
        'Aura HUD (Intake Velocity)',
        'Referral Pipeline',
        'Payer Verification',
        'Coordination Log',
      ],
      'structuralPlan':
          'Patient Admission Pipeline: Aura HUD with referral throughput telemetry. Features a multi-stage referral pipeline and payer verification status monitoring.',
      'kpis': [
        {
          'title': 'New ScaffoldedReferrals',
          'value': '12',
          'deltaSuffix': 'Today',
          'icon': 'userPlus',
          'iconColor': 'teal',
        },
      ],
    },
  };
}

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
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
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
      'subtitle': 'business_development.partnership_manager.dashboard.subtitle',
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
  };
}

class ClientPortalRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      ClientRoutes.clientDashboard,
      PrimeCareForm.clientDashboard,
      componentLabels: [
        'Aura HUD',
        'Health Snapshot',
        'Appointment Calendar',
        'Care Team Messaging',
      ],
      structuralPlan:
          'Patient Empowerment Portal: Aura HUD with medication reminders. High-visibility health snapshot cards followed by appointment management and care team communication channels.',
    );
    registerRoute(
      ClientRoutes.familyMemberDashboard,
      PrimeCareForm.familyMemberDashboard,
      componentLabels: [
        'Aura HUD (Care Coordination)',
        'Patient Status Card',
        'Care Log Timeline',
        'Wellness Trend Chart',
      ],
      structuralPlan:
          'Family Vigilance Portal: Aura HUD with real-time patient status telemetry. Centered around a care log timeline and wellness trend visualization.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'client': {
      'title': 'client_portal.client.dashboard.title',
      'subtitle': 'client_portal.client.dashboard.subtitle',
      'route': ClientRoutes.clientDashboard,
      'componentLabels': [
        'Aura HUD',
        'Health Snapshot',
        'Appointment Calendar',
        'Care Team Messaging',
      ],
      'structuralPlan':
          'Patient Empowerment Portal: Aura HUD with medication reminders. High-visibility health snapshot cards followed by appointment management and care team communication channels.',
      'kpis': [
        {
          'title': 'Next Appointment',
          'value': 'Oct 24',
          'deltaSuffix': '10:00 AM',
          'icon': 'calendar',
          'iconColor': 'blue',
        },
      ],
    },
    'family_member': {
      'title': 'client_portal.family_member.dashboard.title',
      'subtitle': 'client_portal.family_member.dashboard.subtitle',
      'route': ClientRoutes.familyMemberDashboard,
      'componentLabels': [
        'Aura HUD (Care Coordination)',
        'Patient Status Card',
        'Care Log Timeline',
        'Wellness Trend Chart',
      ],
      'structuralPlan':
          'Family Vigilance Portal: Aura HUD with real-time patient status telemetry. Centered around a care log timeline and wellness trend visualization.',
      'kpis': [
        {
          'title': 'Recent Update',
          'value': '2h ago',
          'deltaSuffix': 'Stable Status',
          'icon': 'heart',
          'iconColor': 'red',
        },
      ],
    },
  };
}

class AdminInfrastructureRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      AdminRoutes.systemDashboard,
      PrimeCareForm.ctoDashboard,
      provider: ctoDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (System Uptime)',
        'Server Uptime Graph',
        'API Latency Monitor',
        'Error Density Heatmap',
      ],
      structuralPlan:
          'Infrastructure Command: Aura HUD with real-time cluster health telemetry.',
    );

    registerRoute(
      InfrastructureRoutes.healthDashboard,
      PrimeCareForm.systemHealthDashboard,
      provider: ctoDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (System Uptime)',
        'Service Status',
        'Resource Consumption',
        'Log Stream',
      ],
      structuralPlan:
          'Health Monitor: Unified telemetry for system and service health.',
    );

    registerRoute(
      InfrastructureRoutes.securityDashboard,
      PrimeCareForm.itSecurityDashboard,
      provider: itSecurityDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Threat Detection)',
        'Active Vulnerabilities',
        'Security Audit Logs',
        'Encryption Status',
      ],
      structuralPlan:
          'Security Operations Center: Monitoring active threats and security compliance.',
    );

    registerRoute(
      AdminRoutes.scrumMasterDashboard,
      PrimeCareForm.scrumMasterDashboard,
      provider: scrumMasterDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Sprint Velocity)',
        'Burn-down Chart',
        'Team Capacity',
        'Blocker Management',
      ],
      structuralPlan:
          'Agile Governance: Tracking sprint progress and team efficiency.',
    );

    registerRoute(
      InfrastructureRoutes.systemVerification,
      PrimeCareForm.systemVerificationDashboard,
      provider: systemVerificationDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Validation Integrity)',
        'Test Suite Results',
        'Deployment Health',
        'Checksum Logs',
      ],
      structuralPlan:
          'System Verification: Ensuring platform integrity through continuous validation.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'system_health': {
      'path': AdminRoutes.systemDashboard,
      'title': 'admin.system_health.title',
      'form': PrimeCareForm.ctoDashboard.name,
    },
    'it_security': {
      'path': InfrastructureRoutes.securityDashboard,
      'title': 'admin.it_security.title',
      'form': PrimeCareForm.itSecurityDashboard.name,
    },
    'scrum_master': {
      'path': AdminRoutes.scrumMasterDashboard,
      'title': 'infrastructure.scrum_master.title',
      'form': PrimeCareForm.scrumMasterDashboard.name,
    },
    'system_verification': {
      'path': InfrastructureRoutes.systemVerification,
      'title': 'infrastructure.system_verification.title',
      'form': PrimeCareForm.systemVerificationDashboard.name,
    },
  };
}

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
