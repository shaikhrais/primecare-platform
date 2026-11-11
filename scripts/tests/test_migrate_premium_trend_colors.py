import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('trend', Path(__file__).parents[1]/'migrate-premium-trend-colors.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\nclass PremiumFeature1 extends GovernedConsumerWidget {}\n"
BADGE = 'BoxDecoration(color: isPositive ? const Color(0xFF10B981).withOpacity(0.1) : Colors.amber.withOpacity(0.1))'
ICON = 'Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, color: isPositive ? const Color(0xFF10B981) : Colors.amber, size: 12)'

def screen(body):
    return PREFIX + 'class _StatCard extends StatelessWidget { final bool isPositive; Widget build(BuildContext context) { final theme = context.theme; '+body+'; } }'

class PremiumTrendColorsTest(unittest.TestCase):
    def test_only_exact_badge_and_icon_colors_change(self):
        source = screen('return Column(children: ['+BADGE+','+ICON+'])')
        result, count = m.migrate(source)
        self.assertEqual(count, 4)
        self.assertEqual(result, source.replace('const Color(0xFF10B981)', 'theme.colors.success').replace('Colors.amber', 'theme.colors.warning'))
        self.assertEqual(m.migrate(result), (result, 0))
        self.assertIn('isPositive ? Icons.arrow_upward : Icons.arrow_downward', result)
        self.assertEqual(result.count('.withOpacity(0.1)'), 2)

    def test_other_owners_conditions_colors_and_opacities_stay(self):
        source = screen('return '+BADGE)
        for old, new in [('_StatCard', '_Chart'), ('PremiumFeature1', 'CustomFeature'), ('isPositive ?', 'isNominal ?'),
                         ('0.1)', '0.2)'), ('0xFF10B981', '0xFF047857'), ('Colors.amber', 'Colors.orange'),
                         ('BoxDecoration(', 'CustomDecoration('), ('Colors.amber.withOpacity(0.1)', 'Colors.amber.shade700')]:
            modified = source.replace(old, new)
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_unlabelled_foreground_chart_and_decorative_colors_stay(self):
        for body in ['return TextStyle(color: isPositive ? const Color(0xFF10B981) : Colors.amber)',
                     'return Chart(color: isPositive ? const Color(0xFF10B981) : Colors.amber)',
                     'return Icon(Icons.star, color: const Color(0xFF10B981))']:
            source = screen(body)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_binding_shadow_part_and_restricted_imports_stay(self):
        source = screen('return '+BADGE)
        for modified in [source.replace('final theme = context.theme;', ''),
                         source.replace('return ', 'theme = other; return '),
                         source.replace('return ', 'final isPositive = other; return '),
                         source + 'class Colors {}',
                         "part 'other.dart';"+source,
                         source.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;")]:
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_strings_comments_qualified_calls_and_comment_in_pair_stay(self):
        for body in ['return custom.'+BADGE, '// '+BADGE+'\nreturn content',
                     'final sample="'+BADGE+'"; return content',
                     'return '+BADGE.replace('isPositive ?', 'isPositive /*keep*/ ?')]:
            source = screen(body)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_second_badge_and_icon_are_independent(self):
        source = screen('return Column(children: ['+ICON+','+ICON+'])')
        result, count = m.migrate(source)
        self.assertEqual(count, 4)
        self.assertEqual(result.count('theme.colors.warning'), 2)
        self.assertEqual(result.count('theme.colors.success'), 2)

class TrendFixtureCoverageTest(unittest.TestCase):
    def test_behavioral_fixture_matches_every_eligible_generated_helper(self):
        root = Path(__file__).resolve().parents[2]
        fixture = (root/'packages/primecare_ui/test/fixtures/premium_trend_card_fixture.dart').read_text()
        expected = fixture[fixture.index('class PremiumTrendCardFixture '):].strip().replace('PremiumTrendCardFixture', '_StatCard')
        covered = 0
        for path in (root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'):
            source, count = m.migrate(path.read_text())
            begin = source.index('class _StatCard ')
            end = source.index('\nclass _TelemetryPanel', begin)
            self.assertEqual(source[begin:end].strip(), expected, path.name)
            covered += 1
        self.assertGreater(covered, 0)

if __name__ == '__main__':
    unittest.main()
