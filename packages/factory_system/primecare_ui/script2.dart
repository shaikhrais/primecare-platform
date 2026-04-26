import 'dart:io';

void main() {
  final files = [
    'lib/src/components/aura/01_I_aura_financial_hud.dart',
    'lib/src/components/cards/01_I_primecare_aura_card.dart',
    'lib/src/features/clinical_director/presentation/widgets/05_U_clinical_director_screen.dart',
    'lib/src/features/customer_support/presentation/widgets/05_U_customer_support_screen.dart',
    'lib/src/features/intake_coordinator/presentation/widgets/05_U_intake_coordinator_screen.dart',
    'lib/src/features/marketing_manager/presentation/widgets/05_U_marketing_manager_screen.dart',
  ];

  for (var file in files) {
    var f = File(file);
    if (!f.existsSync()) continue;
    var content = f.readAsStringSync();

    // Replace 'insight.summary,' with 'insight.summary.get(Localizations.localeOf(context).languageCode),'
    // if preceded by whitespace and followed by newline

    content = content.replaceAll(
      'insight.summary,\n',
      'insight.summary.get(Localizations.localeOf(context).languageCode),\n',
    );

    content = content.replaceAll(
      'insight.title,\n',
      'insight.title.get(Localizations.localeOf(context).languageCode),\n',
    );

    f.writeAsStringSync(content);
    print('Updated \$file');
  }
}
