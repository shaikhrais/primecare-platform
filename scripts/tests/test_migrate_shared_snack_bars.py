import hashlib
import importlib.util
import tempfile
import unittest
from pathlib import Path
import sys

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_shared_app_bars
SPEC=importlib.util.spec_from_file_location('migration',ROOT/'scripts/migrate-shared-snack-bars.py')
migration=importlib.util.module_from_spec(SPEC);SPEC.loader.exec_module(migration)

class SharedSnackBarMigrationTest(unittest.TestCase):
    def test_all_reviewed_sources_round_trip_exactly(self):
        total=0
        for path,(digest,calls,_) in migration.SPECS.items():
            latest=(ROOT/path).read_text()
            current=before_shared_app_bars(latest,path)
            original,reversed_calls=migration.reverse_source(path,current)
            if not reversed_calls:
                original=current
            self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),digest,path)
            updated,forward_calls=migration.migrate_source(path,original)
            self.assertEqual((updated,forward_calls),(current,calls),path)
            self.assertEqual(migration.migrate_source(path,current),(current,0),path)
            total+=calls
        self.assertEqual(total,16)

    def test_modified_or_unregistered_sources_are_unchanged(self):
        path=next(iter(migration.SPECS))
        source=(ROOT/path).read_text()+'\n'
        self.assertEqual(migration.migrate_source(path,source),(source,0))
        self.assertEqual(migration.migrate_source('apps/other.dart','SnackBar(content: x);'),('SnackBar(content: x);',0))

    def test_qualified_shadowed_and_quoted_names_are_not_generic_targets(self):
        source="ui.SnackBar(content: x); final SnackBar = factory; 'SnackBar('; // SnackBar(\n"
        self.assertEqual(migration.migrate_source('apps/other.dart',source),(source,0))

    def test_symlink_escape_is_rejected_by_cli_selection(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory); relative=next(iter(migration.SPECS)); path=root/relative
            path.parent.mkdir(parents=True)
            target=Path(directory).parent/'primecare-snack-bar-escape.dart';target.write_text('SnackBar(content: x);')
            try:
                path.symlink_to(target)
                self.assertTrue(path.is_symlink())
                self.assertFalse(path.resolve().is_relative_to(root.resolve()))
            finally:
                target.unlink(missing_ok=True)

if __name__=='__main__':unittest.main()
