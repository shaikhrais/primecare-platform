import importlib.util
import unittest
import re
from pathlib import Path

spec = importlib.util.spec_from_file_location('metrics', Path(__file__).parents[1]/'migrate-governance-status-colors.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"
ACTIVE = "GovMetricCard(title: 'Operational Status', value: 'Active', trendLabel: 'Optimal', progress: 0.92, icon: LucideIcons.activity, brandColor: Color(0xFF0D9488))"
CLEAR = "GovMetricCard(title: 'Security Sync', value: 'Clear', trendLabel: 'Secured', progress: 1.0, icon: LucideIcons.shieldCheck, brandColor: Color(0xFF16A34A))"

def screen(body):
    return PREFIX + 'class Screen { Widget buildScreen(BuildContext context, WidgetRef ref) { final theme = context.theme; '+body+'; } }'

class GovernanceStatusColorsTest(unittest.TestCase):
    def test_known_status_cards_resolve_success_and_preserve_every_other_byte(self):
        source = screen('return Column(children: ['+ACTIVE+','+CLEAR+'])')
        result, count = m.migrate(source)
        self.assertEqual(count, 2)
        self.assertEqual(result, source.replace('Color(0xFF0D9488)', 'theme.colors.success').replace('Color(0xFF16A34A)', 'theme.colors.success'))
        self.assertEqual(m.migrate(result), (result, 0))

    def test_exact_latency_card_resolves_warning_and_is_idempotent(self):
        card = "GovMetricCard(title: 'Latency Telemetry', value: '14ms', trendLabel: 'Optimal', progress: 0.97, icon: LucideIcons.zap, brandColor: Color(0xFFEAB308))"
        source = screen('return '+card)
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(result, source.replace('Color(0xFFEAB308)', 'theme.colors.warning'))
        self.assertEqual(m.migrate(result), (result, 0))
        for old, new in [("'14ms'", "'200ms'"), ('0.97', '0.5'), ('LucideIcons.zap', 'LucideIcons.activity'), ('EAB308', 'FF0000')]:
            changed = source.replace(old, new)
            self.assertEqual(m.migrate(changed), (changed, 0))

    def test_const_ancestors_are_removed_only_when_needed(self):
        source = screen('return const Column(children: ['+ACTIVE+', const SizedBox(height: 12)])')
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertNotIn('const Column', result)
        self.assertIn('const SizedBox(height: 12)', result)
        source = screen('return Column(children: const ['+CLEAR+'])')
        result, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertNotIn('children: const', result)

    def test_changed_labels_values_icons_progress_colors_and_options_stay(self):
        for old, new in [("'Active'", "'Inactive'"), ("'Operational Status'", "'Latency Telemetry'"),
                         ('0.92', '0.5'), ('LucideIcons.activity', 'LucideIcons.zap'),
                         ('0xFF0D9488', '0xFF16A34A'), ('Color(0xFF0D9488)', 'Color(0xFF0D9488).withOpacity(.5)'),
                         ('brandColor:', 'other:'), ('GovMetricCard(', "GovMetricCard(key: Key('other'), ")]:
            source = screen('return '+ACTIVE.replace(old, new))
            self.assertEqual(m.migrate(source), (source, 0))

    def test_context_binding_shadowed_symbols_parts_and_imports_stay(self):
        source = screen('return '+ACTIVE)
        for modified in [source.replace('final theme = context.theme;', ''),
                         source.replace('return ', 'theme = other; return '),
                         source + 'class GovMetricCard {}', "part 'other.dart';"+source,
                         source.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;")]:
            self.assertEqual(m.migrate(modified), (modified, 0))

    def test_comments_strings_and_qualified_calls_stay(self):
        for body in ['return ui.'+ACTIVE, '// '+ACTIVE+'\nreturn content',
                     'final sample="'+ACTIVE+'"; return content',
                     'return '+ACTIVE.replace('brandColor:', 'brandColor: /*keep*/')]:
            source = screen(body)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_unlabelled_colors_and_unknown_constructor_stay(self):
        source = screen('return '+ACTIVE.replace('GovMetricCard', 'Chart'))
        self.assertEqual(m.migrate(source), (source, 0))

class GovernanceMetricFixtureTest(unittest.TestCase):
    def test_native_fixture_uses_the_exact_known_transformed_cards(self):
        root = Path(__file__).resolve().parents[2]
        fixture = (root/'packages/primecare_ui/test/fixtures/governance_status_metrics_fixture.dart').read_text()
        def compact(value):
            return re.sub(r',\s*\)', ')', re.sub(r'\s+', '', value))
        for card in [ACTIVE, CLEAR]:
            transformed, count = m.migrate(screen('return '+card))
            value = transformed[transformed.index('GovMetricCard('):].split(';', 1)[0]
            self.assertEqual(count, 1)
            self.assertIn(compact(value), compact(fixture))

if __name__ == '__main__':
    unittest.main()
