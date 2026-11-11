import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('compliance', Path(__file__).parents[1]/'migrate-premium-compliance-badges.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\nclass PremiumFeature1 extends GovernedConsumerWidget {}\n"

def screen(header=m.OLD):
    return PREFIX + 'class _AuditPanel extends StatelessWidget { Widget build(BuildContext context) { final theme = context.theme; return Card(child: Column(children: [' + header + '])); } }\n' + m.HELPER

class ComplianceBadgeMigrationTest(unittest.TestCase):
    def test_replaces_exact_badge_and_is_idempotent(self):
        source = screen()
        updated, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertEqual(updated, source.replace(m.OLD, m.NEW))
        self.assertIn("PrimeStatusBadge('HIPAA Compliant', tone: PrimeStatusTone.success)", updated)
        self.assertNotIn('const PrimeText', updated)
        self.assertEqual(m.migrate(updated), (updated, 0))

    def test_other_styles_owners_imports_and_shadowing_are_untouched(self):
        source = screen()
        for old, new in [('_AuditPanel', '_OtherPanel'), ('PremiumFeature1', 'CustomFeature'),
                         ('0xFF10B981', '0xFF10B982'), ('HIPAA Compliant', 'Other Status'),
                         ('context.theme', 'other.theme'), ('return Card(', 'return const Card('),
                         ("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;")]:
            changed = source.replace(old, new)
            self.assertEqual(m.migrate(changed), (changed, 0))
        for changed in [source+'class PrimeStatusBadge {}', "part 'other.dart';"+source,
                        source.replace('return Card', 'final theme = other; return Card')]:
            self.assertEqual(m.migrate(changed), (changed, 0))

    def test_comments_and_strings_are_not_candidates(self):
        for header in ['/*'+m.OLD+'*/', '"""'+m.OLD+'"""']:
            source = screen(header)
            self.assertEqual(m.migrate(source), (source, 0))

    def test_modified_local_renderer_is_not_migrated(self):
        source = screen().replace('fontSize: 10.5', 'fontSize: 15')
        self.assertEqual(m.migrate(source), (source, 0))

    def test_unrelated_amber_is_preserved(self):
        source = screen().replace('Widget build', 'final decorative = Colors.amber; Widget build', 1)
        updated, count = m.migrate(source)
        self.assertEqual(count, 1)
        self.assertIn('final decorative = Colors.amber;', updated)

if __name__ == '__main__':
    unittest.main()

class RemainingPositiveBadgesTest(unittest.TestCase):
    def source(self):
        return PREFIX+m.EXTRA_OLD_PANEL+m.HELPER

    def test_exact_panel_shared_badges_and_responsive_group(self):
        source=self.source();result,count=m.migrate(source)
        self.assertEqual(count,2)
        self.assertEqual(result,PREFIX+m.EXTRA_NEW_PANEL)
        self.assertEqual(m.migrate(result),(result,0))
        self.assertIn("PrimeStatusBadge('GDPR Verified', tone: PrimeStatusTone.success)",result)
        self.assertIn("PrimeStatusBadge('TLS 1.3 Active', tone: PrimeStatusTone.success)",result)
        self.assertIn('const Wrap(',result)
        self.assertIn('Expanded(child: Column(',result)
        self.assertNotIn('class _StatusBadge ',result)

    def test_modified_semantics_colors_layout_and_external_helper_references_stay(self):
        source=self.source()
        for old,new in [('GDPR Verified','GDPR Pending'),('TLS 1.3 Active','TLS Inactive'),
                        ('Colors.blue','Colors.indigo'),('Colors.purple','Colors.deepPurple'),
                        ('height: 24','height: 25'),('class _AuditPanel ','class OtherPanel ')]:
            modified=source.replace(old,new)
            self.assertEqual(m.migrate(modified),(modified,0))
        modified=source+"final extra = _StatusBadge(label: 'Other', color: Colors.blue);"
        self.assertEqual(m.migrate(modified),(modified,0))

    def test_commented_panel_restricted_import_and_shadows_stay(self):
        source=self.source()
        for modified in ['/*'+source+'*/',source.replace("primecare_ui.dart';","primecare_ui.dart' show PrimeText;"),
                         source+'class PrimeStatusTone {}',"part 'other.dart';\n"+source]:
            self.assertEqual(m.migrate(modified),(modified,0))

    def test_all_real_panels_match_behavior_fixture_and_idempotence(self):
        root=Path(__file__).resolve().parents[2]
        fixture=(root/'packages/primecare_ui/test/fixtures/premium_audit_panel_fixture.dart').read_text()
        fixture=fixture[fixture.index('class PremiumAuditPanelFixture '):].replace('PremiumAuditPanelFixture','_AuditPanel')
        self.assertEqual(fixture,m.EXTRA_NEW_PANEL)
        count=0
        for path in (root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'):
            source=path.read_text();begin=source.index('class _AuditPanel ')
            self.assertEqual(source[begin:],m.EXTRA_NEW_PANEL,path.name)
            self.assertEqual(m.migrate(source),(source,0),path.name);count+=1
        self.assertEqual(count,251)
