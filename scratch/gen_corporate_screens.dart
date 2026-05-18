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

void main() {
  final outDir = Directory('apps/primecare_corporate/lib/features/corporate/presentation/widgets');
  outDir.createSync(recursive: true);

  final List<String> screenClassNames = [];
  final List<String> exports = [];

  for (final route in routes) {
    final parts = route.split('/');
    if (parts.length < 5) continue;
    final role = parts[4];
    final screen = parts[5];
    final className = toPascalCase(role) + toPascalCase(screen) + 'Screen';
    final fileName = role + '_' + screen.replaceAll('-', '_') + '_screen.dart';

    final code = "import 'package:flutter/material.dart';\n" +
        "import 'package:primecare_ui/primecare_ui.dart';\n\n" +
        "class " + className + " extends StatelessWidget {\n" +
        "  const " + className + "({super.key});\n\n" +
        "  @override\n" +
        "  Widget build(BuildContext context) {\n" +
        "    return EmptyState(\n" +
        "      icon: LucideIcons.building,\n" +
        "      title: '" + className + "',\n" +
        "      description: 'Corporate premium feature module pending hydration.',\n" +
        "      actionLabel: 'Refresh',\n" +
        "      onAction: () {},\n" +
        "    );\n" +
        "  }\n" +
        "}\n";
    File(outDir.path + '/' + fileName).writeAsStringSync(code);
    screenClassNames.add("    '" + route + "': (context) => const " + className + "(),");
    exports.add("export '" + fileName + "';");
  }
  File(outDir.path + '/widgets.dart').writeAsStringSync(exports.join('\n') + '\n');
  print(screenClassNames.join('\n'));
}
