import 'dart:io';

void main() {
  final files = [
    'lib/src/components/aura/01_I_aura_financial_hud.dart',
    'lib/src/components/cards/01_I_primecare_aura_card.dart',
    'lib/src/features/clinical_director/presentation/widgets/05_U_clinical_director_screen.dart',
    'lib/src/features/cto_dashboard/presentation/widgets/01_I_cto_briefing_panel.dart',
    'lib/src/features/customer_support/presentation/widgets/05_U_customer_support_screen.dart',
    'lib/src/features/finance_director_dashboard/presentation/widgets/05_U_finance_director_dashboard_screen.dart',
    'lib/src/features/intake_coordinator/presentation/widgets/05_U_intake_coordinator_screen.dart',
    'lib/src/features/marketing_manager/presentation/widgets/05_U_marketing_manager_screen.dart',
  ];

  for (var file in files) {
    var f = File(file);
    if (!f.existsSync()) continue;
    var content = f.readAsStringSync();
    
    // In all places except the signature of methods, replace insight.title with insight.title.get(Localizations.localeOf(context).languageCode)
    // Wait, replacing 'insight.title' and 'insight.summary' globally is risky. Let's do it specifically.
    
    // For Finance Director:
    content = content.replaceAll(
      'title: insight.title,',
      'title: insight.title.get(Localizations.localeOf(context).languageCode),'
    );
    content = content.replaceAll(
      'description: insight.summary,',
      'description: insight.summary.get(Localizations.localeOf(context).languageCode),'
    );
    
    // For Aura Financial Hud & Aura Card & Clinical & CTO & Customer Support
    content = content.replaceAll(
      'Text(\n                  insight.title,',
      'Text(\n                  insight.title.get(Localizations.localeOf(context).languageCode),'
    );
    content = content.replaceAll(
      'Text(\n                  insight.summary,',
      'Text(\n                  insight.summary.get(Localizations.localeOf(context).languageCode),'
    );
    content = content.replaceAll(
      'Text(\n                insight.summary,',
      'Text(\n                insight.summary.get(Localizations.localeOf(context).languageCode),'
    );
    
    // For inline Text(insight.summary
    content = content.replaceAll(
      'Text(insight.summary,',
      'Text(insight.summary.get(Localizations.localeOf(context).languageCode),'
    );
    
    // For CTO Briefing Panel:
    if (file.contains('01_I_cto_briefing_panel.dart')) {
      content = content.replaceAll('_buildInsightItem(theme, insight)', '_buildInsightItem(context, theme, insight)');
      content = content.replaceAll('Widget _buildInsightItem(\n    PrimeCareThemeData theme,', 'Widget _buildInsightItem(\n    BuildContext context,\n    PrimeCareThemeData theme,');
    }
    
    // For Clinical Director Screen
    if (file.contains('05_U_clinical_director_screen.dart')) {
       content = content.replaceAll('_buildClinicalInsights(vm)', '_buildClinicalInsights(context, vm)');
       content = content.replaceAll('Widget _buildClinicalInsights(ClinicDashboardViewModel vm) {', 'Widget _buildClinicalInsights(BuildContext context, ClinicDashboardViewModel vm) {');
    }
    
    // Customer Support, Intake Coordinator, Marketing Manager
    if (file.contains('05_U_customer_support_screen.dart') || file.contains('05_U_intake_coordinator_screen.dart') || file.contains('05_U_marketing_manager_screen.dart')) {
       content = content.replaceAll('_buildClinicalInsights(vm)', '_buildClinicalInsights(context, vm)');
       content = content.replaceAll('_buildCustomerInsights(vm)', '_buildCustomerInsights(context, vm)');
       content = content.replaceAll('_buildIntakeInsights(vm)', '_buildIntakeInsights(context, vm)');
       content = content.replaceAll('_buildMarketingInsights(vm)', '_buildMarketingInsights(context, vm)');
       content = content.replaceAll('Widget _buildCustomerInsights(CustomerSupportViewModel vm) {', 'Widget _buildCustomerInsights(BuildContext context, CustomerSupportViewModel vm) {');
       content = content.replaceAll('Widget _buildIntakeInsights(IntakeDashboardViewModel vm) {', 'Widget _buildIntakeInsights(BuildContext context, IntakeDashboardViewModel vm) {');
       content = content.replaceAll('Widget _buildMarketingInsights(MarketingManagerViewModel vm) {', 'Widget _buildMarketingInsights(BuildContext context, MarketingManagerViewModel vm) {');
    }
    
    f.writeAsStringSync(content);
    print('Updated \$file');
  }
}
