import 'dart:io';

void main() {
  final dir = Directory('packages/primecare_ui/lib/src/features/generated_screens');
  if (!dir.existsSync()) {
    print('generated_screens directory not found!');
    return;
  }

  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart')).toList();
  print('Total generated files: ${files.length}');

  final Map<String, String> classToFile = {};
  for (final file in files) {
    final filename = file.path.split('/').last.split('\\').last;
    final content = file.readAsStringSync();
    final classMatches = RegExp(r'class\s+([A-Za-z0-9_]+)\s+extends').allMatches(content);
    for (final m in classMatches) {
      classToFile[m.group(1)!] = filename;
    }
  }

  print('Total classes in generated_screens: ${classToFile.length}');

  final missingKeys = [
    'SCREEN_CREATE_USER_FORM',
    'SCREEN_PASSWORD_RESET_FORM',
    'SCREEN_LIVE_DISPATCH_MAP',
    'SCREEN_CREATE_SHIFT_FORM',
    'SCREEN_COMPLIANCE_HUB',
    'SCREEN_GLOBAL_SETTINGS',
    'SCREEN_ENTERPRISE_OVERVIEW',
    'SCREEN_STRATEGIC_KPIS',
    'SCREEN_GROWTH_PIPELINE',
    'SCREEN_REGION_PERFORMANCE',
    'SCREEN_LEADERSHIP_REPORTS',
    'SCREEN_FINANCIAL_OVERVIEW',
    'SCREEN_REVENUE_TRACKER',
    'SCREEN_PROFITABILITY',
    'SCREEN_TAX_REMITTANCE',
    'SCREEN_OPERATIONS_BOARD',
    'SCREEN_BRANCH_OPERATIONS',
    'SCREEN_SCHEDULING_HEALTH',
    'SCREEN_INCIDENT_REVIEWS',
    'SCREEN_SYSTEM_HEALTH',
    'SCREEN_PLATFORM_USAGE',
    'SCREEN_API_MONITORING',
    'SCREEN_AUDIT_LOGS',
    'SCREEN_CASES',
    'SCREEN_POLICY_MANAGER',
    'SCREEN_AUDITS',
    'SCREEN_RISK_REGISTER',
    'SCREEN_CURRICULUM_HUB',
    'SCREEN_SKILL_MATRIX',
    'SCREEN_REGION_DASHBOARD',
    'SCREEN_BRANCH_COMPARISON',
    'SCREEN_LEDGER_COMMAND',
    'SCREEN_CASH_FLOW',
    'SCREEN_INTAKE_PIPELINE',
    'SCREEN_REFERRALS',
    'SCREEN_PENDING_ASSESSMENTS',
    'SCREEN_BILLING_CONSOLE',
    'SCREEN_INVOICES',
    'SCREEN_MARKETING_HUB',
    'SCREEN_CAMPAIGN_ANALYTICS',
    'SCREEN_BUSINESS_OVERVIEW',
    'SCREEN_FINANCIAL_PERFORMANCE',
    'SCREEN_COMPLIANCE_STATUS',
    'SCREEN_SHIFT_TRACKER',
    'SCREEN_MESSAGES',
    'SCREEN_FAMILY_HOME',
    'SCREEN_CARE_PLAN',
    'SCREEN_BILLING',
    'SCREEN_MESSAGING_HUB',
    'SCREEN_DOCUMENT_VAULT',
    'SCREEN_NOTIFICATION_CENTER',
    'SCREEN_CLINICAL_DIRECTOR_DASHBOARD',
    'SCREEN_COMMON_DASHBOARD_LABELS',
    'SCREEN_REGIONAL_MANAGER_LABELS',
    'SCREEN_CLINICAL_DIRECTOR_LABELS',
    'SCREEN_COMMAND_CENTER_LABELS',
    'SCREEN_CTO_DASHBOARD_LABELS',
    'SCREEN_CEO_DASHBOARD_LABELS',
    'SCREEN_CLINICAL_LABELS',
    'SCREEN_CFO_DASHBOARD_LABELS',
    'SCREEN_SUPPORT_DASHBOARD_LABELS',
    'SCREEN_MARKETING_DASHBOARD_LABELS'
  ];

  for (final key in missingKeys) {
    final cleanKey = key.replaceFirst('SCREEN_', '');
    final parts = cleanKey.split('_');
    final pascalKey = parts.map((p) => p[0].toUpperCase() + p.substring(1).toLowerCase()).join('');

    final candidateNames = [
      pascalKey,
      '${pascalKey}Screen',
      '${pascalKey}Form',
      '${pascalKey}View',
      '${pascalKey}Widget',
    ];

    String? foundClass;
    for (final candidate in candidateNames) {
      if (classToFile.containsKey(candidate)) {
        foundClass = candidate;
        break;
      }
    }

    if (foundClass != null) {
      print('KEY: $key -> Match found: $foundClass in $foundClass ($foundClass.dart)');
    } else {
      final cleanLower = cleanKey.toLowerCase().replaceAll('_', '');
      String? looseMatch;
      for (final className in classToFile.keys) {
        final classLower = className.toLowerCase();
        if (classLower == cleanLower || classLower == '${cleanLower}screen' || classLower == '${cleanLower}view') {
          looseMatch = className;
          break;
        }
      }
      if (looseMatch != null) {
        print('KEY: $key -> Loose Match found: $looseMatch in ${classToFile[looseMatch]}');
      } else {
        // print('KEY: $key -> NO MATCH');
      }
    }
  }
}
