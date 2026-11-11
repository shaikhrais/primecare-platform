import importlib.util
import re
import subprocess
import unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('brand',ROOT/'scripts/migrate-premium-primary-brand.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

class BrandBindingMigrationTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        path='packages/primecare_ui/lib/src/features/generated_screens/premium_feature_112.dart'
        # Recover only the four known brand arguments and two enclosing consts
        # from this run's real consumer, retaining a reproducible before fixture.
        cls.before=(ROOT/'scripts/tests/fixtures/premium-primary-brand-before.dart').read_text()

    def test_four_precise_primary_bindings_and_const_ancestors(self):
        source=self.before;result,count=m.migrate(source)
        self.assertEqual(count,4)
        expected=source
        for snippet in m.SNIPPETS:
            expected=expected.replace(snippet,re.sub(r'(?:const )?Color\(0xFF6366F1\)','theme.colors.primary',snippet))
        expected=expected.replace('metrics: const [','metrics:  [').replace('const RecentActivityFeed(',' RecentActivityFeed(')
        self.assertEqual(result,expected)
        self.assertEqual(m.migrate(result),(result,0))
        for code in ['0xFF0EA5E9','0xFF10B981','0xFFF59E0B']:
            self.assertEqual(result.count(code),source.count(code))

    def test_each_unsupported_signature_is_preserved_independently(self):
        for snippet in m.SNIPPETS:
            changed=self.before.replace(snippet,snippet.replace('0xFF6366F1','0xFF6366F2'))
            result,count=m.migrate(changed);self.assertEqual(count,3)
            self.assertIn(snippet.replace('0xFF6366F1','0xFF6366F2'),result)

    def test_modified_owners_bindings_imports_parts_and_helpers_stay(self):
        for old,new in [('PremiumFeature112','OtherFeature'),('context.theme','other.theme'),
                        ("primecare_ui.dart';","primecare_ui.dart' show PrimeText;"),
                        ('class _StatCard ', 'class OtherCard '),('size: 100','size: 101')]:
            source=self.before.replace(old,new);self.assertEqual(m.migrate(source),(source,0))
        for source in ["part 'other.dart';\n"+self.before,self.before+'class Color {}',
                       self.before.replace('PremiumFeature112','OtherFeature')+'class PremiumFeature999 extends GovernedConsumerWidget {}',
                       self.before.replace('final dataState =','theme = other; final dataState ='),
                       self.before+'Widget _StatCard() => other;',
                       self.before.replace('final dataState =','final fn = (theme) => theme; final dataState =')]:
            self.assertEqual(m.migrate(source),(source,0))

    def test_comments_and_qualified_calls_stay(self):
        for snippet in m.SNIPPETS:
            source=self.before.replace(snippet,'/*'+snippet+'*/otherWidget')
            self.assertEqual(m.migrate(source)[1],3)
            qualified=self.before.replace(snippet,'custom.'+snippet)
            self.assertEqual(m.migrate(qualified)[1],3)

    def test_native_caller_fixture_retains_exact_migrated_expressions(self):
        fixture=(ROOT/'packages/primecare_ui/test/fixtures/premium_primary_brand_fixture.dart').read_text()
        for i,snippet in enumerate(m.SNIPPETS):
            call=re.sub(r'(?:const )?Color\(0xFF6366F1\)','theme.colors.primary',snippet)
            call=call.replace('_StatCard(','PremiumTrendCardFixture(').replace('_TelemetryPanel(','PremiumHealthPanelFixture(')
            if i==1:call=call.replace('data: data,','data: const {},')
            self.assertIn(call,fixture)
