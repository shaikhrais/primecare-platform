import hashlib
import importlib.util
from pathlib import Path
import tempfile
import json
import unittest

ROOT=Path(__file__).resolve().parents[2]
s=importlib.util.spec_from_file_location('extensions',ROOT/'scripts/migrate-shared-control-extensions.py')
m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
s=importlib.util.spec_from_file_location('history',ROOT/'scripts/reviewed_migration_history.py')
history=importlib.util.module_from_spec(s);s.loader.exec_module(history)
s=importlib.util.spec_from_file_location('boundary',ROOT/'scripts/check-shared-ui-boundary.py')
b=importlib.util.module_from_spec(s);s.loader.exec_module(b)


class SharedControlExtensionsTest(unittest.TestCase):
    def test_every_actual_source_exact_roundtrip_and_idempotence(self):
        self.assertEqual(len(m.MANIFEST),22)
        self.assertEqual(sum(r['calls'] for r in m.MANIFEST),50)
        for row in m.MANIFEST:
            current=(ROOT/row['path']).read_text();original=history.before_control_extensions(current,row['path'])
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),row['sha256'])
            self.assertEqual(m.migrate(original),(current,row['calls']))
            self.assertEqual(m.migrate(current),(current,0))
            self.assertEqual(len(b.violations(original,True))-len(b.violations(current,True)),row['calls'])
            self.assertEqual([x[2] for x in b.violations(original,False)], [x[2] for x in b.violations(current,False)])
            self.assertTrue(m.verified_parts(ROOT,row))

    def test_source_revisions_rejected(self):
        for row in m.MANIFEST:
            source=history.before_control_extensions((ROOT/row['path']).read_text(),row['path'])
            for changed in [source+'\n',source+'\nclass PrimeIconButton {}\n']:
                self.assertEqual(m.migrate(changed),(changed,0))

    def test_missing_modified_or_escaping_generated_part_is_rejected(self):
        row=next(r for r in m.MANIFEST if r['parts'])
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory)
            self.assertFalse(m.verified_parts(root,row))
            part=row['parts'][0];target=root/part['path'];target.parent.mkdir(parents=True)
            target.write_bytes((ROOT/part['path']).read_bytes())
            self.assertTrue(m.verified_parts(root,row))
            target.write_text(target.read_text()+'\n')
            self.assertFalse(m.verified_parts(root,row))
            target.unlink();target.symlink_to(ROOT/part['path'])
            self.assertFalse(m.verified_parts(root,row))

    def test_native_compile_references_every_actual_library(self):
        for row in m.MANIFEST:
            package=Path(row['path']).parts[:2]
            directory=ROOT.joinpath(*package,'test')
            fixture=(directory/'shared_control_extensions_compile_test.dart').read_text()
            self.assertIn(row['path'].split('/lib/')[1],fixture)


if __name__=='__main__':unittest.main()
