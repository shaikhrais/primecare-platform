import copy
import hashlib
import importlib.util
import json
import unittest
from pathlib import Path
from unittest.mock import patch

ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('native_host_history',ROOT/'scripts/reviewed_migration_history.py')
history=importlib.util.module_from_spec(spec);spec.loader.exec_module(history)
manifest=json.loads((ROOT/'scripts/native-application-host-amendment.json').read_text())
row=manifest['files'][0]

class NativeApplicationHostAmendmentTest(unittest.TestCase):
    def test_exact_one_file_roundtrip_preserves_both_source_identities(self):
        self.assertEqual(len(manifest['files']),1)
        self.assertEqual(row['path'],'apps/primecare_governance/lib/core/governance/route_registry.dart')
        current=(ROOT/row['path']).read_text()
        self.assertEqual(hashlib.sha256(current.encode()).hexdigest(),row['afterSha256'])
        before=history.before_native_application_host(current,row['path'])
        self.assertEqual(hashlib.sha256(before.encode()).hexdigest(),row['beforeSha256'])
        forward=before
        for edit in reversed(row['edits']):
            self.assertEqual(forward[edit['begin']:edit['begin']+len(edit['old'])],edit['old'])
            forward=forward[:edit['begin']]+edit['new']+forward[edit['begin']+len(edit['old']):]
        self.assertEqual(forward,current)
        self.assertEqual(history.before_native_application_host(before,row['path']),before)

    def test_unknown_router_revision_still_fails_closed(self):
        with self.assertRaisesRegex(AssertionError,'output drift'):
            history.before_native_application_host((ROOT/row['path']).read_text()+'\n',row['path'])

    def test_mismatched_edit_cannot_be_normalized(self):
        changed=copy.deepcopy(manifest);changed['files'][0]['edits'][0]['new']='unreviewed'
        with patch.object(history.json,'loads',return_value=changed):
            with self.assertRaisesRegex(AssertionError,'edit drift'):
                history.before_native_application_host((ROOT/row['path']).read_text(),row['path'])

    def test_an_unrelated_consumer_is_not_changed(self):
        self.assertEqual(history.before_native_application_host('any source','another.dart'),'any source')

    def test_original_scaffold_pin_and_constructor_count_are_unchanged(self):
        pins=json.loads((ROOT/'scripts/shared-scaffold-constructors-manifest.json').read_text())
        self.assertEqual(len(pins),23)
        original_sha,expected=pins[row['path']]
        spec=importlib.util.spec_from_file_location('native_scaffold_replay',ROOT/'scripts/migrate-shared-scaffolds.py')
        migration=importlib.util.module_from_spec(spec);spec.loader.exec_module(migration)
        current=history.before_shared_text_fields((ROOT/row['path']).read_text(),row['path'])
        original,count=migration.reverse_source(row['path'],current,expected)
        self.assertEqual(count,expected)
        self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),original_sha)

if __name__=='__main__':unittest.main()
