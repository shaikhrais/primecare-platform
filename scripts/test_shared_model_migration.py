"""Verify migration scope, preservation, dependencies and repeatability."""
import hashlib
import importlib.util
import json
import subprocess
import unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('migration',ROOT/'scripts/refactor_shared_models.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
manifest=json.loads((ROOT/'docs/refactoring/shared-model-migration.json').read_text())

class MigrationTest(unittest.TestCase):
    def test_every_converted_state_matches_exact_original_template(self):
        for record in manifest['files']:
            if record['kind']!='inherited_screen_state':continue
            with self.subTest(path=record['path']):
                original=subprocess.check_output(['git','show',manifest['source_commit']+':'+record['path']],cwd=ROOT,text=True)
                self.assertEqual(m.convert(original),(ROOT/record['path']).read_text())
                self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),record['original_sha256'])
                self.assertIsNone(m.convert((ROOT/record['path']).read_text()))
    def test_domain_models_preserve_original_bytes(self):
        for record in manifest['files']:
            if record['kind']!='shared_domain_model':continue
            original=subprocess.check_output(['git','show',manifest['source_commit']+':'+record['path']],cwd=ROOT)
            target=ROOT/'packages/primecare_models/lib/src/models'/Path(record['path']).name
            self.assertEqual(original,target.read_bytes())
            self.assertIn('export ',(ROOT/record['path']).read_text())
    def test_custom_model_is_not_changed(self):
        self.assertIsNone(m.convert('class CustomModel { final String id; CustomModel(this.id); }'))
    def test_each_consumer_declares_shared_dependency(self):
        for record in manifest['files']:
            folder=ROOT.joinpath(*Path(record['path']).parts[:2])
            self.assertIn('primecare_models:',(folder/'pubspec.yaml').read_text())
    def test_shared_package_has_no_flutter_or_backend_import(self):
        for p in (ROOT/'packages/primecare_models/lib').rglob('*.dart'):
            self.assertNotIn('package:flutter',(p.read_text()))
            self.assertNotIn('package:database_client',(p.read_text()))

if __name__=='__main__':unittest.main()
