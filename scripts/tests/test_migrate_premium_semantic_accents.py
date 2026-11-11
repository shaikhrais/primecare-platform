import importlib.util
import subprocess
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location(
    'accents', ROOT / 'scripts/migrate-premium-semantic-accents.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)


def restore_before(source):
    """Recover the exact pre-migration calls from a migrated real consumer."""
    for pattern, (template, old_color, role) in zip(m.MIGRATED_PATTERNS, m.RULES):
        matches = list(pattern.finditer(source))
        if len(matches) != 1:
            raise AssertionError((template.splitlines()[0], len(matches)))
        match = matches[0]
        value = match[0].replace('theme.colors.' + role, old_color)
        if template.startswith('const _AuditPanel('):
            value = value.replace('_AuditPanel(', 'const _AuditPanel(', 1)
        source = source[:match.start()] + value + source[match.end():]
    return source


class PremiumSemanticAccentMigrationTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.after = (ROOT / 'packages/primecare_ui/lib/src/features/generated_screens/premium_feature_112.dart').read_text()
        cls.before = restore_before(cls.after)

    def test_nine_exact_bindings_reproduce_real_consumer(self):
        result, count = m.migrate(self.before)
        self.assertEqual(count, 9)
        self.assertEqual(result, self.after)
        self.assertEqual(m.migrate(result), (result, 0))
        self.assertEqual(result.count('theme.colors.primary'), self.before.count('theme.colors.primary') + 3)
        self.assertEqual(result.count('theme.colors.success'), self.before.count('theme.colors.success') + 3)
        self.assertEqual(result.count('theme.colors.warning'), self.before.count('theme.colors.warning') + 3)

    def test_any_changed_signature_blocks_the_group(self):
        for pattern in m.PATTERNS:
            match = pattern.search(self.before)
            self.assertIsNotNone(match)
            field = 'icon:' if 'icon:' in match[0] else 'themeColor:'
            changed_call = match[0].replace(field, 'unsupported' + field.capitalize(), 1)
            changed = self.before[:match.start()] + changed_call + self.before[match.end():]
            self.assertEqual(m.migrate(changed), (changed, 0))

    def test_owner_import_binding_helper_and_shadow_guards(self):
        cases = [
            self.before.replace('PremiumFeature112', 'OtherFeature'),
            self.before.replace('context.theme', 'other.theme'),
            self.before.replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;"),
            self.before.replace('class _StatCard ', 'class OtherCard '),
            self.before.replace('class _AuditPanel ', 'class OtherPanel '),
            "part 'other.dart';\n" + self.before,
            self.before + 'class Color {}',
            self.before + 'Widget QuickActionItem() => other;',
            self.before.replace('final dataState =', 'final fn = (theme) => theme; final dataState ='),
        ]
        for source in cases:
            self.assertEqual(m.migrate(source), (source, 0))

    def test_comments_qualified_calls_and_cli_bounds_stay_safe(self):
        match = m.PATTERNS[0].search(self.before)
        commented = self.before[:match.start()] + '/*' + match[0] + '*/ other' + self.before[match.end():]
        qualified = self.before[:match.start()] + 'custom.' + match[0] + self.before[match.end():]
        self.assertEqual(m.migrate(commented), (commented, 0))
        self.assertEqual(m.migrate(qualified), (qualified, 0))
        command = ['python', str(ROOT / 'scripts/migrate-premium-semantic-accents.py'), '--offset', '-1']
        self.assertNotEqual(subprocess.run(command, capture_output=True).returncode, 0)

    def test_native_fixture_covers_every_role_and_label(self):
        fixture = (ROOT / 'packages/primecare_ui/test/fixtures/premium_semantic_accents_fixture.dart').read_text()
        for label in ('API Request Latency', 'Data Ingestion Rate', 'Governance Violations',
                      'Trigger Audit', 'Sync Schema', 'Export Logs',
                      'Prisma Client Hydration', 'Telemetry Session Start'):
            self.assertIn(label, fixture)
        self.assertEqual(fixture.count('theme.colors.primary'), 3)
        self.assertEqual(fixture.count('theme.colors.success'), 3)
        self.assertEqual(fixture.count('theme.colors.warning'), 3)


if __name__ == '__main__':
    unittest.main()
