// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

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
        'Efficiency Metrics',
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
          'Regional Governance Portal: Aura HUD with growth telemetry. Dashboard focuses on comparative analysis and synergy audit logs.',
    );
    registerRoute(
      FranchiseRoutes.marketingManagerDashboard,
      PrimeCareForm.marketingManagerDashboard,
      provider: localMarketingManagerDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Lead Conversion)',
        'Marketing KPI Grid',
        'Lead Conversion Funnel',
        'Brand Awareness Metrics',
      ],
      structuralPlan:
          'Growth & Branding Hub: Aura HUD with conversion telemetry. Features a visual conversion funnel and brand awareness heatmaps.',
    );

    // Sub-screens with explicit architectural intent
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
          'Fiscal Transparency Portal: Aura HUD with cash-on-hand telemetry. Layout utilizes a waterfall chart for P&L analysis and a cash flow forecast.',
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
        'Invoice Data Table',
        'Batch Processing Actions',
        'Tax Summary Card',
      ],
      structuralPlan:
          'Financial Data Engine: Aura HUD with accuracy telemetry. Features a high-density data table for invoice auditing and batch processing.',
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
          'Fiscal Transparency Portal: Aura HUD with cash-on-hand telemetry. Layout utilizes a waterfall chart for P&L analysis and a cash flow forecast.',
    },
    'operations_manager': {
      'title': 'franchise.operations_manager.dashboard.title',
      'subtitle': 'franchise.operations_manager.dashboard.subtitle',
      'route': FranchiseRoutes.operationsManagerDashboard,
      'componentLabels': [
        'Aura HUD (Utilization Score)',
        'Logistics KPI Grid',
        'Resource Allocation Map',
        'Efficiency Metrics',
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
        'Invoice Data Table',
        'Batch Processing Actions',
        'Tax Summary Card',
      ],
      'structuralPlan':
          'Financial Data Engine: Aura HUD with accuracy telemetry. Features a high-density data table for invoice auditing and batch processing.',
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
          'Regional Governance Portal: Aura HUD with growth telemetry. Dashboard focuses on comparative analysis and synergy audit logs.',
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
        'Brand Awareness Metrics',
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
