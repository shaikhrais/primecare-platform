import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from check_governance_workspace_mappings import check, ROUTER, REGISTRY, EXCEPTIONS


class GovernanceWorkspaceMappingsTest(unittest.TestCase):
    def test_unreviewed_missing_route_and_resolved_exception_are_reported(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name in (ROUTER, REGISTRY, EXCEPTIONS):
                (root / name).parent.mkdir(parents=True, exist_ok=True)
            (root / ROUTER).write_text("const governanceNativeScreenRoutes = <String>{ '/known', '/new' };\n")
            (root / REGISTRY).write_text(json.dumps({'screens': [{'route': '/known'}]}))
            (root / EXCEPTIONS).write_text(json.dumps([{'route': '/known', 'reason': 'old', 'next': 'review'}]))
            total, missing, problems = check(root)
            self.assertEqual((total, missing), (2, 1))
            self.assertEqual(len(problems), 2)
            self.assertIn('/new: missing workspace grant mapping', problems[0])
            self.assertIn('/known: exception no longer matches', problems[1])


if __name__ == '__main__':
    unittest.main()
