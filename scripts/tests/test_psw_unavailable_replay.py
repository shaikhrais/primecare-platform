"""Exact migration history must not restore disconnected runtime actions."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'scripts'))
import reviewed_migration_history as history

class PswUnavailableReplayTest(unittest.TestCase):
    def setUp(self):
        self.doc=json.loads((ROOT/'scripts/psw-unavailable-sections-replay.json').read_text())
        self.row=self.doc['files'][0]
        self.current=(ROOT/self.row['path']).read_text()
    def test_exact_runtime_source_reconstructs_the_pinned_palette_output(self):
        self.assertEqual(self.current,self.row['after'])
        previous=history.before_psw_unavailable_sections(self.current,self.row['path'])
        self.assertEqual(hashlib.sha256(previous.encode()).hexdigest(),self.row['beforeSha256'])
        palette=next(row for row in json.loads((ROOT/'scripts/remaining-theme-palette-manifest.json').read_text()) if row['path']==self.row['path'])
        self.assertEqual(self.row['beforeSha256'],palette['updated_sha256'])
        original=history.before_remaining_palette(self.current,self.row['path'])
        self.assertEqual(hashlib.sha256(original.encode()).hexdigest(),palette['sha256'])
    def test_unreviewed_changes_and_unrelated_paths_are_not_reversed(self):
        for source in [self.current+'\n',self.current.replace('onPressed: null','onPressed: () {}',1)]:
            self.assertEqual(history.before_psw_unavailable_sections(source,self.row['path']),source)
        self.assertEqual(history.before_psw_unavailable_sections(self.current,'unrelated.dart'),self.current)
    def test_tampered_receipts_and_duplicate_entries_fail_closed(self):
        for kind in ['before_hash','after_text','duplicate']:
            doc=json.loads(json.dumps(self.doc))
            if kind=='before_hash':doc['files'][0]['before']+=' extra'
            elif kind=='after_text':doc['files'][0]['after']+=' extra'
            else:doc['files'].append(doc['files'][0])
            with tempfile.TemporaryDirectory() as directory:
                root=Path(directory);(root/'scripts').mkdir()
                (root/'scripts/psw-unavailable-sections-replay.json').write_text(json.dumps(doc))
                with patch.object(history,'ROOT',root):
                    with self.assertRaises(AssertionError):history.before_psw_unavailable_sections(self.current,self.row['path'])

if __name__=='__main__':unittest.main()
