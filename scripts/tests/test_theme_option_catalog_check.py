"""CI checks the pinned production export without an operational SQLite file."""
import importlib.util
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from unittest.mock import patch

ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('theme_option_check',ROOT/'scripts/register-theme-center-options.py')
check=importlib.util.module_from_spec(spec);spec.loader.exec_module(check)

class PinnedOptionCheckTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup)
        self.root=Path(self.temp.name)
        for path in ['tools/governance-production/production-pin.json','tools/governance-production/theme-option-resources.json','tools/governance-production/theme_option_catalog.py','packages/primecare_theme/lib/theme/theme_center_options_generated.dart']:
            target=self.root/path;target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(ROOT/path,target)
        self.target=self.root/'packages/primecare_theme/lib/theme/theme_center_options_generated.dart'
        for key,value in [('ROOT',self.root),('TARGET',self.target)]:
            p=patch.object(check,key,value);p.start();self.addCleanup(p.stop)
    def test_check_works_without_database_and_preserves_files(self):
        before=self.target.read_bytes()
        check.check_pinned_catalog()
        self.assertEqual(self.target.read_bytes(),before)
        self.assertFalse((self.root/'.agents').exists())
    def test_changed_generated_copy_is_rejected_without_rewrite(self):
        self.target.write_text(self.target.read_text().replace('Home service','Changed wording'))
        before=self.target.read_bytes()
        with self.assertRaisesRegex(ValueError,'catalog drift'):check.check_pinned_catalog()
        self.assertEqual(self.target.read_bytes(),before)
    def test_changed_catalog_is_rejected_by_pin(self):
        p=self.root/'tools/governance-production/theme-option-resources.json';p.write_text(p.read_text()+'\n')
        with self.assertRaisesRegex(RuntimeError,'Pinned'):check.check_pinned_catalog()
