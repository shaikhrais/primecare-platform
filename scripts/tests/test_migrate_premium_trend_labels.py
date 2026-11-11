import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('labels', Path(__file__).parents[1]/'migrate-premium-trend-labels.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\nclass PremiumFeature1 extends GovernedConsumerWidget {}\n"
LABEL = 'Text(change, style: TextStyle(color: isPositive ? const Color(0xFF047857) : Colors.amber.shade700, fontSize: 11, fontWeight: FontWeight.bold))'

def screen(body):
    if body.startswith('return '):
        body = 'return Container(decoration: BoxDecoration(color: isPositive ? theme.colors.success.withOpacity(0.1) : theme.colors.warning.withOpacity(0.1)), child: '+body[7:]+')'
    return PREFIX+'class _StatCard extends StatelessWidget { final String change; final bool isPositive; Widget build(BuildContext context) { '+body+'; } }'

class PremiumTrendLabelsTest(unittest.TestCase):
    def test_exact_label_becomes_shared_without_changing_surrounding_source(self):
        source = screen('return '+LABEL)
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace(LABEL, 'PrimeTrendLabel(change, isPositive: isPositive)'))
        self.assertEqual(m.migrate(result), (result, 0))

    def test_other_owners_conditions_and_styles_stay(self):
        source = screen('return '+LABEL)
        for old, new in [('_StatCard', '_Chart'), ('PremiumFeature1', 'CustomFeature'), ('isPositive ?', 'isNominal ?'),
                         ('0xFF047857', '0xFF10B981'), ('fontSize: 11', 'fontSize: 12'), ('FontWeight.bold', 'FontWeight.w500'),
                         ('Text(change,', 'Text(other,'), ('style: TextStyle(', "key: const Key('other'), style: TextStyle(")]:
            modified = source.replace(old, new)
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_extra_style_options_or_color_modifiers_stay(self):
        for old, new in [('fontSize: 11', 'fontSize: 11, letterSpacing: .2'),
                         ('Colors.amber.shade700', 'Colors.amber.shade700.withOpacity(.5)'),
                         ('Text(change,', 'Text(change, maxLines: 1,')]:
            source = screen('return '+LABEL.replace(old, new))
            self.assertEqual(m.migrate(source), (source, 0))

    def test_parts_shadowed_fields_and_restricted_imports_stay(self):
        source = screen('return '+LABEL)
        for modified in [source.replace('return ', 'final change=other; return '),
                         source.replace('return ', 'isPositive=other; return '),
                         source+'class PrimeTrendLabel {}', "part 'other.dart';"+source,
                         source.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;")]:
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_comments_strings_and_qualified_calls_stay(self):
        for body in ['return ui.'+LABEL, '// '+LABEL+'\nreturn content',
                     'final sample="'+LABEL+'"; return content',
                     'return '+LABEL.replace('color:', 'color: /*keep*/')]:
            source = screen(body)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_multiple_labels_preserve_both(self):
        source = screen('return Column(children: ['+LABEL+','+LABEL+'])')
        result, count = m.migrate(source)
        self.assertEqual(count, 2)
        self.assertEqual(result.count('PrimeTrendLabel('), 2)

class TrendLabelBackgroundTest(unittest.TestCase):
    def test_unknown_background_and_modified_tint_stay(self):
        source = screen('return '+LABEL)
        for modified in [source.replace('.withOpacity(0.1)', '.withOpacity(0.2)'),
                         source.replace('theme.colors.success', 'theme.colors.primary')]:
            self.assertEqual(m.migrate(modified), (modified, 0))

if __name__ == '__main__':
    unittest.main()
