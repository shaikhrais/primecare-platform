import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_core/flutter_core.dart';

class NavigationRegistry {
  static final Map<String, List<PrimeCareNavigationItem>> _roleMenus = {
    'Admin': [
      const PrimeCareNavigationItem(
        label: 'System Dashboard',
        icon: LucideIcons.layoutDashboard,
        route: CorporateRoutes.ceoDashboard,
        section: 'Main',
      ),
      const PrimeCareNavigationItem(
        label: 'Compliance Hub',
        icon: LucideIcons.shieldCheck,
        route: CorporateRoutes.complianceManagerDashboard,
        section: 'Management',
      ),
      const PrimeCareNavigationItem(
        label: 'Global Settings',
        icon: LucideIcons.settings2,
        route: CommonRoutes.globalSettings,
        section: 'Management',
      ),
    ],
    'CEO': [
      const PrimeCareNavigationItem(
        label: 'Enterprise Overview',
        icon: LucideIcons.globe,
        route: CorporateRoutes.ceoEnterpriseOverview,
        section: 'Main',
      ),
      const PrimeCareNavigationItem(
        label: 'Strategic KPIs',
        icon: LucideIcons.barChart3,
        route: CorporateRoutes.ceoStrategicKpis,
        section: 'Main',
      ),
      const PrimeCareNavigationItem(
        label: 'Growth Pipeline',
        icon: LucideIcons.trendingUp,
        route: CorporateRoutes.ceoGrowthPipeline,
        section: 'Main',
      ),
      const PrimeCareNavigationItem(
        label: 'Region Performance',
        icon: LucideIcons.map,
        route: CorporateRoutes.ceoRegionPerformance,
        section: 'Strategic',
      ),
      const PrimeCareNavigationItem(
        label: 'Leadership Reports',
        icon: LucideIcons.fileText,
        route: CorporateRoutes.ceoLeadershipReports,
        section: 'Strategic',
      ),
    ],
    'CFO': [
      const PrimeCareNavigationItem(
        label: 'Financial Overview',
        icon: LucideIcons.wallet,
        route: CorporateRoutes.cfoFinancialOverview,
      ),
      const PrimeCareNavigationItem(
        label: 'Revenue Tracker',
        icon: LucideIcons.dollarSign,
        route: CorporateRoutes.cfoRevenue,
      ),
      const PrimeCareNavigationItem(
        label: 'Profitability',
        icon: LucideIcons.pieChart,
        route: CorporateRoutes.cfoProfitability,
      ),
      const PrimeCareNavigationItem(
        label: 'Tax & Remittance',
        icon: LucideIcons.landmark,
        route: CorporateRoutes.cfoTaxAndRemittance,
      ),
    ],
    'COO': [
      const PrimeCareNavigationItem(
        label: 'Operations Board',
        icon: LucideIcons.activity,
        route: CorporateRoutes.cooOperationsOverview,
      ),
      const PrimeCareNavigationItem(
        label: 'Branch Operations',
        icon: LucideIcons.gitMerge,
        route: CorporateRoutes.cooBranchOperations,
      ),
      const PrimeCareNavigationItem(
        label: 'Scheduling Health',
        icon: LucideIcons.calendarCheck,
        route: CorporateRoutes.cooSchedulingHealth,
      ),
      const PrimeCareNavigationItem(
        label: 'Incident Reviews',
        icon: LucideIcons.alertTriangle,
        route: CorporateRoutes.cooIssueEscalations,
      ),
    ],
    'CTO': [
      const PrimeCareNavigationItem(
        label: 'System Health',
        icon: LucideIcons.hardDrive,
        route: CorporateRoutes.ctoSystemHealth,
      ),
      const PrimeCareNavigationItem(
        label: 'Platform Usage',
        icon: LucideIcons.fingerprint,
        route: CorporateRoutes.ctoPlatformUsage,
      ),
      const PrimeCareNavigationItem(
        label: 'API Monitoring',
        icon: LucideIcons.cpu,
        route: CorporateRoutes.ctoApiMonitoring,
      ),
      const PrimeCareNavigationItem(
        label: 'Audit Logs',
        icon: LucideIcons.scrollText,
        route: CorporateRoutes.ctoAuditLogs,
      ),
    ],
    'Compliance Manager': [
      const PrimeCareNavigationItem(
        label: 'Cases',
        icon: LucideIcons.briefcase,
        route: CorporateRoutes.complianceManagerComplianceCases,
      ),
      const PrimeCareNavigationItem(
        label: 'Policy Manager',
        icon: LucideIcons.bookOpen,
        route: CorporateRoutes.complianceManagerPolicies,
      ),
      const PrimeCareNavigationItem(
        label: 'Audits',
        icon: LucideIcons.listChecks,
        route: CorporateRoutes.complianceManagerAudits,
      ),
      const PrimeCareNavigationItem(
        label: 'Risk Register',
        icon: LucideIcons.flame,
        route: CorporateRoutes.complianceManagerRiskRegister,
      ),
    ],
    'Corporate Developer': [
      const PrimeCareNavigationItem(
        label: 'System Health',
        icon: LucideIcons.hardDrive,
        route: CorporateRoutes.ctoSystemHealth,
      ),
      const PrimeCareNavigationItem(
        label: 'Platform Usage',
        icon: LucideIcons.fingerprint,
        route: CorporateRoutes.ctoPlatformUsage,
      ),
      const PrimeCareNavigationItem(
        label: 'API Monitoring',
        icon: LucideIcons.cpu,
        route: CorporateRoutes.ctoApiMonitoring,
      ),
    ],
    'Clinical Director': [
      const PrimeCareNavigationItem(
        label: 'Clinical Command',
        icon: LucideIcons.stethoscope,
        route: ClinicalRoutes.clinicalDirectorDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'Quality Metrics',
        icon: LucideIcons.checkCircle2,
        route: ClinicalRoutes.clinicalDirectorQualityMetrics,
      ),
      const PrimeCareNavigationItem(
        label: 'Staffing Health',
        icon: LucideIcons.users2,
        route: ClinicalRoutes.clinicalDirectorStaffing,
      ),
    ],
    'Intake Coordinator': [
      const PrimeCareNavigationItem(
        label: 'Intake Pipeline',
        icon: LucideIcons.userPlus,
        route: ClinicalRoutes.intakeCoordinatorDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'Referrals',
        icon: LucideIcons.fileInput,
        route: ClinicalRoutes.intakeCoordinatorReferrals,
      ),
      const PrimeCareNavigationItem(
        label: 'Pending assessments',
        icon: LucideIcons.clipboardList,
        route: ClinicalRoutes.intakeCoordinatorAssessments,
      ),
    ],
    'Franchise Owner': [
      const PrimeCareNavigationItem(
        label: 'Business Overview',
        icon: LucideIcons.building2,
        route: FranchiseRoutes.franchiseOwnerDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'Financial Performance',
        icon: LucideIcons.barChart,
        route: FranchiseRoutes.franchiseOwnerFinancialSnapshot,
      ),
      const PrimeCareNavigationItem(
        label: 'Compliance Status',
        icon: LucideIcons.shieldCheck,
        route: FranchiseRoutes.franchiseOwnerCompliance,
      ),
    ],
    'PSW': [
      const PrimeCareNavigationItem(
        label: 'Clinical Dashboard',
        icon: LucideIcons.stethoscope,
        route: CommonRoutes.clinicDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'Shift Tracker',
        icon: LucideIcons.clock,
        route: CommonRoutes.clinicMyShifts,
      ),
      const PrimeCareNavigationItem(
        label: 'Messages',
        icon: LucideIcons.messageSquare,
        route: CommonRoutes.messagingHub,
      ),
    ],
    'Client': [
      const PrimeCareNavigationItem(
        label: 'Family Home',
        icon: LucideIcons.home,
        route: ClientRoutes.clientDashboard,
      ),
      const PrimeCareNavigationItem(
        label: 'Care Plan',
        icon: LucideIcons.heartPulse,
        route: ClientRoutes.clientTreatmentHistory,
      ),
      const PrimeCareNavigationItem(
        label: 'Billing',
        icon: LucideIcons.receipt,
        route: ClientRoutes.clientPayments,
      ),
    ],
  };

  static List<PrimeCareNavigationItem> getMenuForRole(String role) {
    // 1. Try exact match first (for acronyms like CEO, CTO, PSW)
    if (_roleMenus.containsKey(role)) {
      return _roleMenus[role]!;
    }

    // 2. Try case-insensitive exact match
    final upperRole = role.toUpperCase();
    for (var key in _roleMenus.keys) {
      if (key.toUpperCase() == upperRole) {
        return _roleMenus[key]!;
      }
    }

    // 3. Fallback to Title Case normalization for standard roles
    final normalizedRole = role
        .split(' ')
        .map((e) => e.isEmpty
            ? ''
            : e[0].toUpperCase() + e.substring(1).toLowerCase())
        .join(' ');

    return _roleMenus[normalizedRole] ?? _roleMenus['Admin']!;
  }
}
