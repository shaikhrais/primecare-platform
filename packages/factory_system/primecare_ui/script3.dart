import 'dart:io';

void main() {
  final files = [
    'lib/src/components/aura/aura_financial_hud.dart',
    'lib/src/components/cards/primecare_aura_card.dart',
    'lib/src/features/clinical_director/presentation/widgets/clinical_director_screen.dart',
    'lib/src/features/customer_support/presentation/widgets/customer_support_screen.dart',
    'lib/src/features/intake_coordinator/presentation/widgets/intake_coordinator_screen.dart',
    'lib/src/features/marketing_manager/presentation/widgets/marketing_manager_screen.dart',
  ];

  for (var file in files) {
    var f = File(file);
    if (!f.existsSync()) continue;
    var lines = f.readAsLinesSync();

    for (var i = 0; i < lines.length; i++) {
      if (lines[i].trim() == 'insight.summary,' ||
          lines[i].trim() == 'insight.summary') {
        lines[i] = lines[i].replaceFirst(
          'insight.summary',
          'insight.summary.get(Localizations.localeOf(context).languageCode)',
        );
      }
      if (lines[i].trim() == 'insight.title,' ||
          lines[i].trim() == 'insight.title') {
        lines[i] = lines[i].replaceFirst(
          'insight.title',
          'insight.title.get(Localizations.localeOf(context).languageCode)',
        );
      }
    }

    f.writeAsStringSync(lines.join('\\n') + '\\n');
    print('Updated \$file');
  }
}
