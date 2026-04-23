// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

class CorporateRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(CorporateRoutes.ceoDashboard, PrimeCareForm.ceoDashboard);
    registerRoute(CorporateRoutes.cooDashboard, PrimeCareForm.cooDashboard);
    registerRoute(CorporateRoutes.cfoDashboard, PrimeCareForm.cfoDashboard);
    // CTO Dashboard is handled via specialized CtoDashboardIntent in GovernanceRegistry
    registerRoute(CorporateRoutes.complianceManagerDashboard, PrimeCareForm.complianceManagerDashboard);
    registerRoute(CorporateRoutes.trainingDirectorDashboard, PrimeCareForm.trainingDirectorDashboard);
    registerRoute(CorporateRoutes.financeDirectorDashboard, PrimeCareForm.financeDirectorDashboard);
    registerRoute(CorporateRoutes.headOfBusDevDashboard, PrimeCareForm.headOfBusDevDashboard);
    registerRoute(CorporateRoutes.headOfMarketingDashboard, PrimeCareForm.headOfMarketingDashboard);

    // Specialized Corporate Sub-screens
    final subScreens = [
      {'path': CorporateRoutes.ceoEnterpriseOverview, 'title': 'Enterprise Overview', 'pid': 'ceoEnterpriseOverview'},
      {'path': CorporateRoutes.ceoFranchiseOverview, 'title': 'Franchise Overview', 'pid': 'ceoFranchiseOverview'},
      {'path': CorporateRoutes.ceoRegionPerformance, 'title': 'Region Performance', 'pid': 'ceoRegionPerformance'},
      {'path': CorporateRoutes.ceoRevenueSummary, 'title': 'Revenue Summary', 'pid': 'ceoRevenueSummary'},
      {'path': CorporateRoutes.cooOperationsOverview, 'title': 'Operations Overview', 'pid': 'cooOperationsOverview'},
      {'path': CorporateRoutes.cooBranchOperations, 'title': 'Branch Operations', 'pid': 'cooBranchOperations'},
      {'path': CorporateRoutes.cfoFinancialOverview, 'title': 'Financial Overview', 'pid': 'cfoFinancialOverview'},
      {'path': CorporateRoutes.cfoRevenue, 'title': 'Revenue Analytics', 'pid': 'cfoRevenue'},
      {'path': CorporateRoutes.ctoSystemHealth, 'title': 'System Health', 'pid': 'ctoSystemHealth'},
      {'path': CorporateRoutes.ctoPlatformUsage, 'title': 'Platform Usage', 'pid': 'ctoPlatformUsage'},
    ];

    for (final s in subScreens) {
      registerCustomDashboard(s['path']!, s['title']!, s['pid']!);
    }
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
        'ceo': {
          'title': 'Global Platform Overview',
          'subtitle': 'Real-time metrics across all PrimeCare franchise locations and clinical nodes.',
          'route': CorporateRoutes.ceoDashboard,
          'componentLabels': ['Aura HUD', 'Enterprise KPI Grid', 'Revenue Forecast Chart', 'Global Activity Log'],
          'rendering': {
            'status': 'healthy',
            'isCritical': true,
            'fallbackId': '/error-500',
          },
          'kpis': [
            {
              'title': 'Active Patients',
              'value': '14,239',
              'deltaSuffix': '+12% this month',
              'icon': 'users',
              'iconColor': 'blue',
            },
          ],
        },
        'training_director': {
          'title': 'Training Compliance Gateway',
          'subtitle': 'Manage certifications, renewals, and staff competencies.',
          'route': CorporateRoutes.trainingDirectorDashboard,
          'componentLabels': ['Aura HUD', 'Compliance Stat Grid', 'Certification Expiry Table', 'Staff Competency Map'],
          'kpis': [
            {
              'title': 'Cert. Compliance',
              'value': '94%',
              'deltaSuffix': '+2% increase',
              'icon': 'graduationCap',
              'iconColor': 'teal',
            },
          ],
        },
        'coo': {
          'title': 'Operations Strategy',
          'subtitle': 'System-wide operational efficiency and service quality.',
          'route': CorporateRoutes.cooDashboard,
          'componentLabels': ['Aura HUD', 'Operational KPI Grid', 'Branch Efficiency Table', 'Service Quality Log'],
          'kpis': [
            {
              'title': 'Ops Efficiency',
              'value': '94.2%',
              'deltaSuffix': 'Service uptime',
              'icon': 'barChart',
              'iconColor': 'blue',
            },
          ],
        },
        'cfo': {
          'title': 'Global Treasury',
          'subtitle': 'Financial ledger oversight and fiscal compliance.',
          'route': CorporateRoutes.cfoDashboard,
          'componentLabels': ['Aura HUD', 'Financial KPI Grid', 'Cash Flow Projection', 'Expense Audit Table'],
          'kpis': [
            {
              'title': 'Net Liquidity',
              'value': r'$1.8M',
              'deltaSuffix': 'Cash on hand',
              'icon': 'barChart',
              'iconColor': 'amber',
            },
          ],
        },
        'compliance_manager': {
          'title': 'Compliance & Policy Hub',
          'subtitle': 'Regulatory Oversight • Audit Management',
          'route': CorporateRoutes.complianceManagerDashboard,
          'componentLabels': ['Aura HUD', 'Compliance Stat Grid', 'Audit Calendar', 'Policy Revision Status'],
          'kpis': [
            {
              'title': 'Pending Audits',
              'value': '3',
              'deltaSuffix': 'Next 7 days',
              'icon': 'shieldCheck',
              'iconColor': 'blue',
            },
          ],
        },
        'finance_director': {
          'title': 'Finance & Treasury Operations',
          'subtitle': 'Institutional Ledger Control • Finance Director',
          'route': CorporateRoutes.financeDirectorDashboard,
          'componentLabels': ['Aura HUD', 'Finance KPI Grid', 'Accounts Receivable Ledger', 'Tax Remittance Status'],
          'kpis': [
            {
              'title': 'Accounts Receivable',
              'value': r'$1.2M',
              'deltaSuffix': 'Pending Payors',
              'icon': 'dollarSign',
              'iconColor': 'green',
            },
          ],
        },
      };
}
