import hashlib
import importlib.util
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
import sys
sys.path.insert(0,str(ROOT/'scripts'))
from reviewed_migration_history import before_controller_ref_aliases
spec = importlib.util.spec_from_file_location('dispatch', ROOT/'scripts/migrate-live-dispatch-palette.py')
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
spec = importlib.util.spec_from_file_location('boundary', ROOT/'scripts/check-shared-ui-boundary.py')
b = importlib.util.module_from_spec(spec); spec.loader.exec_module(b)


class LiveDispatchPaletteTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        current = before_controller_ref_aliases((ROOT/m.SOURCE).read_text(),m.SOURCE)
        cls.original, reversed_count = m.reverse_migrate(current)
        if not reversed_count:
            cls.original = current
        cls.updated, cls.count = m.migrate(current)
        if not cls.count:
            cls.updated = current
            cls.count = reversed_count

    def test_exact_source_hash_forward_and_idempotence(self):
        self.assertEqual(hashlib.sha256(self.original.encode()).hexdigest(), m.ORIGINAL_SHA)
        self.assertEqual(hashlib.sha256(self.updated.encode()).hexdigest(), m.UPDATED_SHA)
        self.assertEqual(self.count, 20)
        self.assertEqual(m.migrate(self.updated), (self.updated, 0))
        self.assertEqual(m.reverse_migrate(self.original), (self.original, 0))
        before = [x for x in b.violations(self.original, False) if x[1] == 'theme-color']
        after = [x for x in b.violations(self.updated, False) if x[1] == 'theme-color']
        self.assertEqual(len(before) - len(after), 20)

    def test_all_semantic_roles_and_readable_pairs_are_present(self):
        for value in ('warning.border', 'warning.surface', 'warning.onSurface',
                      'warning.onAccent', 'primary.onAccent', 'success.onAccent',
                      'error.surface', 'error.onSurface', 'inverseSurface',
                      'inverseOnSurface', 'shadowColor'):
            self.assertIn(value, self.updated)
        for fixed in ('Colors.amber', 'Colors.red', 'Colors.green', 'Colors.blue',
                      'Colors.white', 'Colors.black', 'Color('):
            self.assertNotIn(fixed, b.executable_code(self.updated))

    def test_logic_and_data_are_unchanged(self):
        for value in ("'delayed'", "'active'", "'warning'", "'success'",
                      'controller.reRouteVisit', 'controller.assignCaregiver',
                      "'Grace Hopper, PSW'", "'PENDING MATCH'", '43.6532', '-79.3832'):
            self.assertEqual(self.updated.count(value), self.original.count(value))

    def test_source_drift_is_rejected(self):
        changed = self.original.replace("'Live Operations Dispatch Control'", "'Changed'")
        self.assertEqual(m.migrate(changed), (changed, 0))


if __name__ == '__main__': unittest.main()
