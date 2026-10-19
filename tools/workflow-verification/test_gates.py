import copy
import tempfile
import unittest
from pathlib import Path
from gates import GATES, digest, evaluate


class GatesTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        for name in ('source.ts', 'spec.json', 'result.json'):
            (self.root / name).write_text(name)
        self.record = {'workflow_id': 'synthetic-gate-test', 'gates': {
            name: {'status': 'passed', 'sources': {'source.ts': digest(self.root / 'source.ts')},
                   'specifications': {'spec.json': digest(self.root / 'spec.json')},
                   'artifacts': {'result.json': digest(self.root / 'result.json')},
                   'approval_id': 'synthetic-only'} for name in GATES}}

    def test_all_seven_current_gates_required(self):
        self.assertTrue(evaluate(self.record, self.root)['green'])
        for name in GATES:
            for status in ('failed', 'blocked', 'skipped', 'unverified', 'invalid'):
                with self.subTest(gate=name, status=status):
                    record = copy.deepcopy(self.record)
                    record['gates'][name]['status'] = status
                    self.assertFalse(evaluate(record, self.root)['green'])
            record = copy.deepcopy(self.record)
            del record['gates'][name]
            self.assertFalse(evaluate(record, self.root)['green'])

    def test_stale_or_missing_bindings_cannot_pass(self):
        for filename in ('source.ts', 'spec.json', 'result.json'):
            with self.subTest(filename=filename):
                path = self.root / filename
                original = path.read_text()
                path.write_text('changed')
                self.assertFalse(evaluate(self.record, self.root)['green'])
                path.unlink()
                self.assertFalse(evaluate(self.record, self.root)['green'])
                path.write_text(original)

    def test_approval_and_bindings_cannot_be_omitted(self):
        del self.record['gates']['review']['approval_id']
        self.assertFalse(evaluate(self.record, self.root)['green'])
        self.record['gates']['files']['sources'] = {}
        self.assertEqual(evaluate(self.record, self.root)['gates']['files']['status'], 'unverified')

    def test_outside_root_reference_is_rejected(self):
        self.record['gates']['behavior']['artifacts'] = {'../outside': 'abc'}
        self.assertFalse(evaluate(self.record, self.root)['green'])


if __name__ == '__main__':
    unittest.main()
