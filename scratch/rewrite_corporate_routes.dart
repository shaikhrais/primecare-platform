import 'dart:io';

const routes = [
  '/offices/corporate/roles/ceo/dashboard',
  '/offices/corporate/roles/owner/dashboard',
  '/offices/corporate/roles/coo/dashboard',
  '/offices/corporate/roles/cfo/dashboard',
  '/offices/corporate/roles/cto/dashboard',
  '/offices/corporate/roles/compliance_manager/dashboard',
  '/offices/corporate/roles/head_of_bus_dev/dashboard',
  '/offices/corporate/roles/head_of_marketing/dashboard',
  '/offices/corporate/roles/training_director/dashboard',
  '/offices/corporate/roles/shareholder/dashboard',
  '/offices/corporate/roles/ceo/enterprise-overview',
  '/offices/corporate/roles/ceo/franchise-overview',
  '/offices/corporate/roles/ceo/region-performance',
  '/offices/corporate/roles/ceo/revenue-summary',
  '/offices/corporate/roles/ceo/strategic-kpis',
  '/offices/corporate/roles/ceo/growth-pipeline',
  '/offices/corporate/roles/ceo/leadership-reports',
  '/offices/corporate/roles/ceo/alerts-and-risks',
  '/offices/corporate/roles/ceo/organization-map',
  '/offices/corporate/roles/ceo/approvals',
  '/offices/corporate/roles/ceo/reports',
  '/offices/corporate/roles/coo/operations-overview',
  '/offices/corporate/roles/coo/branch-operations',
  '/offices/corporate/roles/coo/staffing-efficiency',
  '/offices/corporate/roles/coo/scheduling-health',
  '/offices/corporate/roles/coo/service-delivery',
  '/offices/corporate/roles/coo/issue-escalations',
  '/offices/corporate/roles/coo/compliance-view',
  '/offices/corporate/roles/coo/workflow-performance',
  '/offices/corporate/roles/coo/branch-comparison',
  '/offices/corporate/roles/coo/reports',
  '/offices/corporate/roles/cfo/financial-overview',
  '/offices/corporate/roles/cfo/revenue',
  '/offices/corporate/roles/cfo/expenses',
  '/offices/corporate/roles/cfo/franchise-financials',
  '/offices/corporate/roles/cfo/payroll',
  '/offices/corporate/roles/cfo/accounts-receivable',
  '/offices/corporate/roles/cfo/accounts-payable',
  '/offices/corporate/roles/cfo/invoices',
  '/offices/corporate/roles/cfo/profitability',
  '/offices/corporate/roles/cfo/tax-and-remittance',
  '/offices/corporate/roles/cfo/reports',
  '/offices/corporate/roles/cto/system-health',
  '/offices/corporate/roles/cto/platform-usage',
  '/offices/corporate/roles/cto/feature-adoption',
  '/offices/corporate/roles/cto/api-monitoring',
  '/offices/corporate/roles/cto/integrations',
  '/offices/corporate/roles/cto/audit-logs',
  '/offices/corporate/roles/cto/access-control',
  '/offices/corporate/roles/cto/release-management',
  '/offices/corporate/roles/cto/issue-tracking',
  '/offices/corporate/roles/cto/infrastructure',
  '/offices/corporate/roles/cto/reports',
  '/offices/corporate/roles/cto/verification-hub',
  '/offices/corporate/roles/compliance_manager/compliance-cases',
  '/offices/corporate/roles/compliance_manager/policies',
  '/offices/corporate/roles/compliance_manager/audits',
  '/offices/corporate/roles/compliance_manager/incident-review',
  '/offices/corporate/roles/compliance_manager/credential-tracking',
  '/offices/corporate/roles/compliance_manager/document-expiry',
  '/offices/corporate/roles/compliance_manager/risk-register',
  '/offices/corporate/roles/compliance_manager/corrective-actions',
  '/offices/corporate/roles/compliance_manager/training-compliance',
  '/offices/corporate/roles/compliance_manager/reports',
  '/offices/corporate/roles/training_director/training-programs',
  '/offices/corporate/roles/training_director/staff-training-matrix',
  '/offices/corporate/roles/training_director/compliance-training',
  '/offices/corporate/roles/training_director/course-library',
  '/offices/corporate/roles/training_director/assessments',
  '/offices/corporate/roles/training_director/certifications',
  '/offices/corporate/roles/training_director/trainer-assignments',
  '/offices/corporate/roles/training_director/reports',
  '/offices/corporate/roles/training_director/analytics',
  '/offices/corporate/roles/finance_director/dashboard',
  '/offices/corporate/roles/finance_director/cashflow',
  '/offices/corporate/roles/volunteer_coordinator/dashboard',
  '/offices/corporate/roles/training_director/course-architect',
  '/offices/corporate/roles/training_director/hub',
  '/offices/corporate/roles/training_director/certificates',
  '/offices/corporate/roles/cto/system-verification',
  '/offices/corporate/roles/hr_manager/dashboard',
  '/offices/corporate/roles/hr_hiring/dashboard',
  '/offices/corporate/roles/hr_director/dashboard',
  '/offices/corporate/roles/cx_director/dashboard',
  '/offices/corporate/roles/it_admin/dashboard',
  '/offices/corporate/roles/legal/dashboard',
  '/offices/corporate/roles/ciso/dashboard'
];

String toPascalCase(String text) {
  return text.split(RegExp(r'[-_]')).map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }).join('');
}

String toCamelCase(String text) {
  final parts = text.split(RegExp(r'[-_]'));
  if (parts.isEmpty) return '';
  final first = parts[0].toLowerCase();
  final rest = parts.skip(1).map((w) {
    if (w.isEmpty) return w;
    return w[0].toUpperCase() + w.substring(1);
  }).join('');
  return first + rest;
}

void main() {
  final Map<String, List<String>> roleToRoutes = {};
  for (var r in routes) {
    if (r.trim().isEmpty) continue;
    final parts = r.split('/');
    if (parts.length < 5) continue;
    final role = parts[4];
    roleToRoutes.putIfAbsent(role, () => []).add(r);
  }

  String fileCode = '''import 'package:primecare_ui/primecare_ui.dart' hide ShareholderDashboardScreen, FinanceDirectorDashboardScreen, VolunteerCoordinatorDashboardScreen, HrManagerDashboardScreen, HrHiringDashboardScreen, HrDirectorDashboardScreen, CxDirectorDashboardScreen, LegalDashboardScreen, CisoDashboardScreen, OwnerDashboardScreen, CooDashboardScreen, CfoDashboardScreen, CtoDashboardScreen, ComplianceManagerDashboardScreen, HeadOfBusDevDashboardScreen, HeadOfMarketingDashboardScreen, TrainingDirectorDashboardScreen;
import '../../features/corporate/presentation/widgets/widgets.dart';

class PrimeCareTenant extends PlatformTenant {
  @override
  String get tenantId => 'primecare_hq';

  @override
  String get name => 'PrimeCare Corporate';

  @override
  ThemeData get branding => PrimeThemeData(
        colors: const PrimeColors().copyWith(
          primary: const Color(0xFF1E3A8A), // Corporate Navy
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFDBEAFE),
        ),
      ).toThemeData();
}

''';

  roleToRoutes.forEach((role, routeList) {
    if (role.trim().isEmpty) return;
    String modClass = toPascalCase(role) + "Module";
    String platRole = "PlatformRole." + toCamelCase(role);
    
    fileCode += '''
class $modClass extends PlatformModule {
  @override
  String get moduleId => '${role}_module';

  @override
  String get name => '${toPascalCase(role)} Dashboard';

  @override
  IconData get icon => Icons.admin_panel_settings;

  @override
  List<PlatformRole> get allowedRoles => [$platRole];

  @override
  List<PrimeCareScreen> get screens => [
''';

    for (var route in routeList) {
      if (route.trim().isEmpty) continue;
      final parts = route.split('/');
      final screen = parts[5];
      final className = toPascalCase(role) + toPascalCase(screen) + 'Screen';
      final screenTitle = toPascalCase(screen).replaceAllMapped(RegExp(r'(?<=[a-z])[A-Z]'), (m) => " " + m.group(0)!);
      String routeProp = toCamelCase(role) + toPascalCase(screen);
      if (routeProp == 'ctoSystemVerification') routeProp = 'systemVerificationDashboard';
      if (routeProp == 'trainingDirectorCourseArchitect') routeProp = 'courseArchitectDashboard';
      if (routeProp == 'trainingDirectorHub') routeProp = 'trainingHubDashboard';
      if (routeProp == 'shareholderDashboard') routeProp = 'shareholderIntelligenceDashboard';
      if (routeProp == 'financeDirectorCashflow') routeProp = 'financeDirectorCashFlow';
      fileCode += '''    PrimeCareScreen(
      title: '$screenTitle',
      route: CorporateRoutes.$routeProp,
      builder: (context) => const $className(),
    ),
''';
    }

    fileCode += '''  ];
}
''';
  });

  fileCode += '''
class CorporateApplication extends PlatformApplication {
  @override
  String get appId => 'primecare_corporate';
  @override
  String get name => 'PrimeCare Corporate Portal';
  String get homeRoute => CorporateRoutes.ceoDashboard;
  @override
  PlatformTenant get tenant => PrimeCareTenant();

  @override
  List<PlatformRoleDefinition> get roleDefinitions => [
''';

  roleToRoutes.forEach((role, routeList) {
    if (role.trim().isEmpty) return;
    String modClass = toPascalCase(role) + "Module";
    String platRole = "PlatformRole." + toCamelCase(role);
    String dbRoute = routeList.firstWhere((r) => r.endsWith('dashboard'), orElse: () => routeList.first);
    final parts = dbRoute.split('/');
    final screen = parts[5];
    String routeProp = toCamelCase(role) + toPascalCase(screen);
    if (routeProp == 'ctoSystemVerification') routeProp = 'systemVerificationDashboard';
    if (routeProp == 'trainingDirectorCourseArchitect') routeProp = 'courseArchitectDashboard';
    if (routeProp == 'trainingDirectorHub') routeProp = 'trainingHubDashboard';
    if (routeProp == 'shareholderDashboard') routeProp = 'shareholderIntelligenceDashboard';
    if (routeProp == 'financeDirectorCashflow') routeProp = 'financeDirectorCashFlow';
    final fullRouteProp = "CorporateRoutes." + routeProp;

    fileCode += '''    PlatformRoleDefinition(
      role: $platRole,
      dashboardRoute: $fullRouteProp,
      modules: [$modClass()],
    ),
''';
  });

  fileCode += '''  ];
}
''';

  File('apps/primecare_corporate/lib/core/routing/corporate_routes.dart').writeAsStringSync(fileCode);
}
