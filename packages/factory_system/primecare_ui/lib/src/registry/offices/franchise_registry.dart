// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

class FranchiseRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(FranchiseRoutes.franchiseOwnerDashboard, PrimeCareForm.franchiseOwnerDashboard);
    registerRoute(FranchiseRoutes.operationsManagerDashboard, PrimeCareForm.operationsManagerDashboard);
    registerRoute(FranchiseRoutes.schedulerDashboard, PrimeCareForm.schedulerDashboard);
    registerRoute(FranchiseRoutes.billingAdminDashboard, PrimeCareForm.billingAdminDashboard);
    registerRoute(FranchiseRoutes.hrHiringDashboard, PrimeCareForm.hrHiringDashboard);
    registerRoute(FranchiseRoutes.regionalManagerDashboard, PrimeCareForm.regionalManagerDashboard);
    registerRoute(FranchiseRoutes.marketingManagerDashboard, PrimeCareForm.marketingManagerDashboard);
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
        'franchise_owner': {
          'title': 'Franchise Command Center',
          'subtitle': 'Business Performance • Staff Oversight',
          'route': FranchiseRoutes.franchiseOwnerDashboard,
          'componentLabels': ['Aura HUD', 'Business KPI Grid', 'Staff Oversight Table', 'Revenue Growth Chart'],
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
        'operations_manager': {
          'title': 'Operational Pulse',
          'subtitle': 'Resource allocation and logistical efficiency tracking.',
          'route': FranchiseRoutes.operationsManagerDashboard,
          'componentLabels': ['Aura HUD', 'Logistics KPI Grid', 'Resource Allocation Map', 'Efficiency Metrics'],
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
          'title': 'Scheduling Hub',
          'subtitle': 'Shift Management • Appointment Coordination',
          'route': FranchiseRoutes.schedulerDashboard,
          'componentLabels': ['Aura HUD', 'Scheduling Stat Grid', 'Shift Coordination Calendar', 'Urgent Coverage List'],
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
          'title': 'Revenue Cycle Management',
          'subtitle': 'Invoicing • Claims • Collections',
          'route': FranchiseRoutes.billingAdminDashboard,
          'componentLabels': ['Aura HUD', 'Billing Stat Grid', 'Pending Claims Ledger', 'Collection Status Chart'],
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
        'hr_hiring': {
          'title': 'Staffing & Talent Pipeline',
          'subtitle': 'Manage recruitment, onboarding, and retention analytics.',
          'route': FranchiseRoutes.hrHiringDashboard,
          'componentLabels': ['Aura HUD', 'Recruitment KPI Grid', 'Candidate Pipeline View', 'Onboarding Checklist'],
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
        'regional_manager': {
          'title': 'Regional Performance Hub',
          'subtitle': 'Multi-site Oversight • Operational Synergy',
          'route': FranchiseRoutes.regionalManagerDashboard,
          'componentLabels': ['Aura HUD', 'Regional KPI Grid', 'Multi-site Performance Table', 'Synergy Audit Log'],
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
          'title': 'Branch Growth Hub',
          'subtitle': 'Lead Generation • Local Brand Awareness',
          'route': FranchiseRoutes.marketingManagerDashboard,
          'componentLabels': ['Aura HUD', 'Marketing KPI Grid', 'Lead Conversion Funnel', 'Brand Awareness Metrics'],
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
