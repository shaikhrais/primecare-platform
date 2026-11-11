import hashlib
import importlib.util
from pathlib import Path
import unittest

ROOT=Path(__file__).resolve().parents[2]
s=importlib.util.spec_from_file_location('progress',ROOT/'scripts/migrate-shared-circular-progress.py')
m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('history',ROOT/'scripts/reviewed_migration_history.py')
history=importlib.util.module_from_spec(s);s.loader.exec_module(history)
s=importlib.util.spec_from_file_location('boundary',ROOT/'scripts/check-shared-ui-boundary.py')
b=importlib.util.module_from_spec(s);s.loader.exec_module(b)


class SharedCircularProgressTest(unittest.TestCase):
    def test_all_exact_sources_roundtrip_and_keep_literal_colors(self):
        self.assertEqual(len(m.MANIFEST),8)
        self.assertEqual(sum(r['calls'] for r in m.MANIFEST),11)
        for row in m.MANIFEST:
            latest=(ROOT/row['path']).read_text()
            current=history.before_shared_scaffolds(history.before_shared_text_fields(latest,row['path']),row['path'])
            original=history.before_circular_progress(current,row['path'])
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
            self.assertEqual(m.migrate(original),(current,row['calls']))
            self.assertEqual(m.migrate(current),(current,0))
            self.assertEqual(len(b.violations(original,True))-len(b.violations(current,True)),row['calls'])
            self.assertEqual([x[2] for x in b.violations(original,False)],[x[2] for x in b.violations(current,False)])

    def test_edited_sources_are_not_migrated(self):
        for row in m.MANIFEST:
            current=history.before_shared_scaffolds(history.before_shared_text_fields((ROOT/row['path']).read_text(),row['path']),row['path'])
            original=history.before_circular_progress(current,row['path'])
            for changed in [original+'\n',original+'\nclass PrimeCircularProgressIndicator {}\n']:
                self.assertEqual(m.migrate(changed),(changed,0))

    def test_native_compile_fixture_references_actual_sources(self):
        for row in m.MANIFEST:
            package=Path(row['path']).parts[:2];fixture=ROOT.joinpath(*package,'test/shared_circular_progress_compile_test.dart')
            self.assertIn(row['path'].split('/lib/')[1],fixture.read_text())


if __name__=='__main__':unittest.main()
