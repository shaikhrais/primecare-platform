"""Validate source preservation and precise placeholder migration boundaries."""
from pathlib import Path
import hashlib,importlib.util,json,subprocess,unittest
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('migration',ROOT/'scripts/refactor_remaining_models.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
manifest=json.loads((ROOT/'docs/refactoring/remaining-model-migration.json').read_text())
class RemainingMigrationTest(unittest.TestCase):
    def test_all_original_sources_are_pinned(self):
        for record in manifest['files']:
            old=subprocess.check_output(['git','show',manifest['source_commit']+':'+record['path']],cwd=ROOT,text=True)
            self.assertEqual(hashlib.sha256(old.encode()).hexdigest(),record['original_sha256'])
            current=(ROOT/record['path']).read_text()
            if record['kind']=='inherited_empty_placeholder':
                self.assertEqual(m.convert(old),current)
                self.assertIsNone(m.convert(current))
            elif record['kind'] in ['shared_metadata_models','shared_custom_models','shared_dashboard_models']:
                target=(ROOT/'packages/primecare_models/lib/src/models'/Path(record['path']).name).read_text()
                expected=old.replace("import 'package:primecare_ui/src/shared/primecare_adapters.dart';","import 'primecare_view_model.dart';").replace("import 'package:flutter_core/flutter_core.dart';","import 'insight_impact.dart';")
                self.assertEqual(target,expected)
    def test_custom_model_is_not_converted_as_placeholder(self):
        self.assertIsNone(m.convert('class Custom { final String id; const Custom(this.id); }'))
    def test_all_placeholder_consumers_have_dependency(self):
        for record in manifest['files']:
            if record['kind']=='inherited_empty_placeholder':
                package=ROOT.joinpath(*Path(record['path']).parts[:2])
                self.assertIn('primecare_models:',(package/'pubspec.yaml').read_text())
if __name__=='__main__':unittest.main()
