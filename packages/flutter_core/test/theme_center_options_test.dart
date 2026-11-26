import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/theme_center_catalog_generated.dart';
import 'package:flutter_core/theme/theme_center_options.dart';
import 'package:flutter_core/theme/theme_center_options_generated.dart';

void main() {
  test('all editor font and color identifiers have en/es/fr display text', () {
    final keys = themeCenterOptions['en']!.keys.toSet();
    for (final language in ['en', 'es', 'fr']) {
      final entries = themeCenterOptions[language]!;
      expect(entries.keys.toSet(), keys);
      for (final font in ['system', 'serif', 'monospace']) {
        expect(entries['font.$font'], isNotEmpty);
      }
      for (final color in themeCenterColorKeys) {
        expect(entries['color.$color'], isNotEmpty);
      }
      expect(entries['invalidColor'], contains('#RRGGBB'));
      expect(entries['copyName'], contains('{name}'));
    }
  });

  testWidgets('editor text follows locale and preserves literal user names', (tester) async {
    for (final language in ['en', 'es', 'fr', 'de']) {
      late BuildContext context;
      await tester.pumpWidget(Localizations(
        locale: Locale(language),
        delegates: const [DefaultWidgetsLocalizations.delegate],
        child: Builder(builder: (value) {
          context = value;
          return Text(themeCenterOption(value, 'color.primaryContainer'));
        }),
      ));
      await tester.pumpAndSettle();
      final catalog = themeCenterOptions[language] ?? themeCenterOptions['en']!;
      expect(find.text(catalog['color.primaryContainer']!), findsOneWidget);
      expect(themeCenterOption(context, 'font.system'), catalog['font.system']);
      expect(themeCenterOption(context, 'invalidColor'), catalog['invalidColor']);
      expect(themeCenterOption(context, 'copyName', name: r'{name} $theme'),
        catalog['copyName']!.replaceAll('{name}', r'{name} $theme'));
      expect(() => themeCenterOption(context, 'copyName'), throwsArgumentError);
      expect(() => themeCenterOption(context, 'unknown'), throwsArgumentError);
    }
  });
}
