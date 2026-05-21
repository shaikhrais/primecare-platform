import 'dart:io';

void main() {
  final missingKeys = [
    'FRANCHISESALESMANAGER_DASHBOARD',
    'FRANCHISESALESMANAGER_COMPLIANCE',
    'TERRITORYEXPANSIONMANAGER_DASHBOARD',
    'TERRITORYEXPANSIONMANAGER_COMPLIANCE',
    'TERRITORYSALESMANAGER_DASHBOARD',
    'TERRITORYSALESMANAGER_COMPLIANCE',
    'LOCALMARKETINGMANAGER_DASHBOARD',
    'LOCALMARKETINGMANAGER_COMPLIANCE',
    'TRAININGCOORDINATOR_COMPLIANCE',
    'VOLUNTEERCOORDINATOR_DASHBOARD',
    'VOLUNTEERCOORDINATOR_COMPLIANCE',
    'ARCHITECTUREPLANNING_DASHBOARD',
    'ARCHITECTUREPLANNING_COMPLIANCE',
    'BUSINESSDEVELOPMENT_COMPLIANCE',
    'SCREEN_CREATE_USER_FORM',
    'SCREEN_PASSWORD_RESET_FORM',
    'SCREEN_LIVE_DISPATCH_MAP',
    'SCREEN_CREATE_SHIFT_FORM',
    'SCREEN_COMPLIANCE_HUB',
    'SCREEN_GLOBAL_SETTINGS',
    'SCREEN_USER_MANAGEMENT',
    'SCREEN_ENTERPRISE_OVERVIEW',
    'SCREEN_STRATEGIC_KPIS',
    'SCREEN_CUSTOMER_SUPPORT_DASHBOARD',
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
    'SCREEN_HEAD_OF_MARKETING_DASHBOARD',
    'SCREEN_HEAD_OF_BUS_DEV_DASHBOARD',
    'SCREEN_OPERATIONS_MANAGER_DASHBOARD',
    'SCREEN_HR_HIRING_DASHBOARD',
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

  final libDir = Directory('packages/primecare_ui/lib/src');
  final files = libDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart')).toList();

  print('Total files in lib/src: ${files.length}');

  // Build index of class names to file path
  final Map<String, String> classToFile = {};
  for (final file in files) {
    if (file.path.contains('generated_screens')) continue;
    final content = file.readAsStringSync();
    final classMatches = RegExp(r'class\s+([A-Za-z0-9_]+)\s+extends').allMatches(content);
    for (final m in classMatches) {
      classToFile[m.group(1)!] = file.path;
    }
  }

  print('Total classes indexed: ${classToFile.length}');

  // Let's search matches for our missing keys
  for (final key in missingKeys) {
    final cleanKey = key.replaceFirst('SCREEN_', '');
    final parts = cleanKey.split('_');
    final pascalKey = parts.map((p) => p[0].toUpperCase() + p.substring(1).toLowerCase()).join('');
    
    // Check if pascalKey exists, or with "Screen" or "Form" or "Dashboard" suffixes
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
      print('KEY: $key -> Match found: $foundClass in ${classToFile[foundClass]}');
    } else {
      // Try loose matching
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
