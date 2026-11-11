import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('health', Path(__file__).parents[1]/'migrate-premium-health-colors.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\nclass PremiumFeature1 extends GovernedConsumerWidget {}\n"
LABEL = "Text(data.isEmpty ? 'Offline' : 'Nominal', style: TextStyle(color: data.isEmpty ? Colors.amber : const Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 13))"

def screen(body):
    return PREFIX + 'class _TelemetryPanel extends StatelessWidget { final Map<String, dynamic> data; Widget build(BuildContext context) { final theme = context.theme; '+body+'; } }'

class PremiumHealthColorsTest(unittest.TestCase):
    def test_exact_health_colors_change_and_all_other_bytes_stay(self):
        source = screen('return '+LABEL)
        result, count = m.migrate(source)
        self.assertEqual(count, 2)
        self.assertEqual(result, source.replace('Colors.amber', 'theme.colors.warning').replace('const Color(0xFF10B981)', 'theme.colors.success'))
        self.assertEqual(m.migrate(result), (result, 0))

    def test_other_owners_labels_conditions_and_colors_stay(self):
        source = screen('return '+LABEL)
        for old, new in [('_TelemetryPanel', '_Chart'), ('PremiumFeature1', 'CustomFeature'), ('data.isEmpty', 'data.isNotEmpty'),
                         ("'Offline'", "'Other'"), ("'Nominal'", "'Other'"), ('0xFF10B981', '0xFF047857'),
                         ('Colors.amber', 'Colors.orange'), ('Text(', 'custom.Text('), ('TextStyle(', 'custom.TextStyle(')]:
            modified = source.replace(old, new)
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_bindings_parts_and_shadowed_symbols_stay(self):
        source = screen('return '+LABEL)
        for modified in [source.replace('final theme = context.theme;', ''),
                         source.replace('return ', 'theme = other; return '),
                         source.replace('return ', 'final data = other; return '),
                         source + 'class Colors {}', "part 'other.dart';"+source,
                         source.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;")]:
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_comments_and_strings_are_untouched(self):
        for body in ['// '+LABEL+'\nreturn content', 'final sample="'+LABEL+'"; return content',
                     'return '+LABEL.replace('Colors.amber', '/* keep */ Colors.amber')]:
            source = screen(body)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_multiple_labels_are_independent(self):
        source = screen('return Column(children: ['+LABEL+','+LABEL+'])')
        result, count = m.migrate(source)
        self.assertEqual(count, 4)
        self.assertEqual(result.count('theme.colors.warning'), 2)

class HealthFixtureCoverageTest(unittest.TestCase):
    def test_fixture_matches_every_generated_health_panel_and_row(self):
        root = Path(__file__).resolve().parents[2]
        fixture = (root/'packages/primecare_ui/test/fixtures/premium_health_panel_fixture.dart').read_text()
        fixture = fixture[fixture.index('class PremiumHealthPanelFixture '):].replace('PremiumHealthPanelFixture', '_TelemetryPanel').replace('PremiumHealthRowFixture', '_TelemetryRow')
        panel, row = fixture.split('\n\nclass _TelemetryRow ', 1)
        row = 'class _TelemetryRow '+row
        covered = 0
        for path in (root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'):
            source, count = m.migrate(path.read_text())
            begin = source.index('class _TelemetryPanel ')
            end = source.index('\nclass _AuditPanel', begin)
            self.assertEqual(source[begin:end].strip(), panel.strip(), path.name)
            begin = source.index('class _TelemetryRow ')
            end = source.index('\nclass _StatusBadge', begin)
            self.assertEqual(source[begin:end].strip(), row.strip(), path.name)
            covered += 1
        self.assertGreater(covered, 0)

if __name__ == '__main__':
    unittest.main()
