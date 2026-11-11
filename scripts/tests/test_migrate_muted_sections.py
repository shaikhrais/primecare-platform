import importlib.util
import json
import subprocess
import tempfile
import unittest
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('muted',ROOT/'scripts/migrate-muted-sections.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

class MutedSectionsTest(unittest.TestCase):
    def test_exact_template_const_parents_semantics_and_data_preserved(self):
        result,count=m.migrate(m.TEMPLATE)
        self.assertEqual(count,1)
        self.assertEqual(result,m.IMPORT+m.TEMPLATE.replace(m.OLD,m.NEW))
        self.assertEqual(result.removeprefix(m.IMPORT).replace(m.NEW,m.OLD),m.TEMPLATE)
        self.assertEqual(m.migrate(result),(result,0))

    def test_heading_and_semantics_changes_stay_literal(self):
        source=m.TEMPLATE.replace('RnWorkflowTaskDetailsSection','CareSection').replace('rn_workflow_task_details_title','care_title').replace('Task Details Section','Care details')
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertEqual(result,m.IMPORT+source.replace(m.OLD,m.NEW))

    def test_modified_colors_layout_styles_shadowed_symbols_and_imports_stay(self):
        for source in [m.TEMPLATE.replace('Colors.grey','Colors.blue'), m.TEMPLATE.replace('height: 4','height: 5'),
                       m.TEMPLATE.replace('TextStyle(color: Colors.grey)','TextStyle(fontSize: 12, color: Colors.grey)'),
                       m.TEMPLATE+'class PrimeStatusText {}', '/*'+m.TEMPLATE+'*/',
                       m.TEMPLATE.replace("material.dart';", "material.dart' as ui;"),
                       m.TEMPLATE.replace('Clinical Care Operations Status.','Other label'),
                       m.TEMPLATE.replace('Task Details Section',r'Care ${state.label}'),
                       "part 'other.dart';\n"+m.TEMPLATE]:
            self.assertEqual(m.migrate(source),(source,0))

    def test_cli_defaults_to_dry_run_and_rejects_symlink_escape(self):
        with tempfile.TemporaryDirectory() as temp, tempfile.TemporaryDirectory() as outside:
            root=Path(temp);base=root/'packages/primecare_ui/lib/src/screens';base.mkdir(parents=True)
            target=base/'section.dart';target.write_text(m.TEMPLATE)
            external=Path(outside)/'section.dart';external.write_text(m.TEMPLATE)
            (base/'escape.dart').symlink_to(external)
            args=['python',str(ROOT/'scripts/migrate-muted-sections.py'),'--root',str(root),'--limit','10000']
            result=json.loads(subprocess.check_output(args,text=True))
            self.assertEqual(result['labels'],1);self.assertFalse(result['applied']);self.assertEqual(target.read_text(),m.TEMPLATE)
            subprocess.check_call(args+['--apply'],stdout=subprocess.DEVNULL)
            self.assertEqual(external.read_text(),m.TEMPLATE)
            self.assertEqual(json.loads(subprocess.check_output(args,text=True))['labels'],0)
