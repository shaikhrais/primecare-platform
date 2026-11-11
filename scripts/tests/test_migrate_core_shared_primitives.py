import hashlib
import json
import importlib.util
from pathlib import Path
import re
import tempfile
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[2]
history_spec=importlib.util.spec_from_file_location('history',ROOT/'scripts/reviewed_migration_history.py')
history=importlib.util.module_from_spec(history_spec);history_spec.loader.exec_module(history)

spec = importlib.util.spec_from_file_location('core_migration', ROOT/'scripts/migrate-core-shared-primitives.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)


def original_source(source):
    for name in ('PrimeText', 'PrimeIcon'):
        source = source.replace(m.FOUNDATION_IMPORT+name+';\n', '')
    code = m.text.boundary.executable_code(source)
    positions = list(re.finditer(r'\bPrime(Text|Icon)\s*\(', code))
    for call in reversed(positions):
        source = source[:call.start()]+source[call.start()+5:]
    return source


def before_later_button_migration(source, path):
    source=history.before_control_extensions(source,path)
    manifest = ROOT/'scripts/shared-button-families-manifest.json'
    if not manifest.exists():
        return source
    row = next((row for row in json.loads(manifest.read_text()) if row['path'] == path), None)
    if row is None:
        return source
    # Reverse the exact later, separately verified button edits before replaying
    # the earlier text/icon migration. Hash checks still reject unrelated drift.
    edits=[];delta=0
    for edit in row['edits']:
        begin=edit['begin']+delta
        if source[begin:begin+len(edit['new'])] != edit['new']:
            raise AssertionError('Later button edit drift: '+path)
        edits.append((begin, begin+len(edit['new']), edit['old']))
        delta+=len(edit['new'])-(edit['end']-edit['begin'])
    for begin,end,old in reversed(edits):
        source=source[:begin]+old+source[end:]
    if hashlib.sha256(source.encode()).hexdigest() != row['sha256']:
        raise AssertionError('Later button input drift: '+path)
    return source


class CoreSharedPrimitivesTest(unittest.TestCase):
    def test_all_actual_sources_exact_roundtrip_and_idempotence(self):
        self.assertEqual(sum(x['text'] for x in m.MANIFEST), 401)
        self.assertEqual(sum(x['icons'] for x in m.MANIFEST), 51)
        fixture = (ROOT/'packages/flutter_core/test/shared_primitives_migration_compile_test.dart').read_text()
        for row in m.MANIFEST:
            updated = before_later_button_migration((ROOT/row['path']).read_text(), row['path'])
            original = original_source(updated)
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(), row['sha256'], row['path'])
            self.assertEqual(m.migrate(original), (updated, row['text']+row['icons']))
            self.assertEqual(m.migrate(updated), (updated, 0))
            self.assertNotIn('package:primecare_ui/', updated)
            self.assertIn(row['path'].split('/lib/')[1], fixture)
            before=m.text.boundary.violations(original, True)
            after=m.text.boundary.violations(updated, True)
            self.assertEqual(len(before)-len(after), row['text']+row['icons'])
            self.assertEqual([x[2] for x in before if x[1]=='theme-color'],
                             [x[2] for x in after if x[1]=='theme-color'])

    def test_changed_inputs_are_not_silently_migrated(self):
        row=m.MANIFEST[0]
        source=original_source(before_later_button_migration((ROOT/row['path']).read_text(), row['path']))
        for changed in [source+'\n', source.replace("package:flutter/material.dart", "package:other/material.dart"),
                        source+'\nclass PrimeText {}\n', source+'\nfinal Icon = other;\n']:
            self.assertEqual(m.migrate(changed), (changed, 0))

    def test_package_graph_and_compatibility_exports(self):
        foundation=(ROOT/'packages/primecare_ui_foundation/pubspec.yaml').read_text()
        dependencies=re.search(r'^dependencies:\n(.*?)(?=^\S)', foundation, re.M|re.S)[1]
        self.assertEqual(re.findall(r'^  (\w+):', dependencies, re.M), ['flutter'])
        for package in ['primecare_ui','flutter_core']:
            spec=(ROOT/f'packages/{package}/pubspec.yaml').read_text()
            self.assertIn('  primecare_ui_foundation:\n    path: ../primecare_ui_foundation\n', spec)
        core=(ROOT/'packages/flutter_core/pubspec.yaml').read_text()
        self.assertNotRegex(core, r'(?m)^  primecare_ui:')
        for filename,name in [('prime_text','PrimeText'),('prime_icon','PrimeIcon')]:
            wrapper=(ROOT/f'packages/primecare_ui/lib/src/components/{filename}.dart').read_text()
            self.assertIn(m.FOUNDATION_IMPORT.replace('import ', 'export ')+name+';',wrapper)
            self.assertNotIn('class '+name,wrapper)

    def test_dependency_and_scope_checks(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);base=root/'packages/flutter_core';base.mkdir(parents=True)
            script=ROOT/'scripts/migrate-core-shared-primitives.py'
            result=subprocess.run(['python3',str(script),'--root',str(root)],capture_output=True,text=True)
            self.assertNotEqual(result.returncode,0)
            self.assertIn('dependency is required',result.stderr)


if __name__ == '__main__':
    unittest.main()
