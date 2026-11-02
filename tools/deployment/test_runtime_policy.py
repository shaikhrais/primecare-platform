import unittest
from .runtime_policy import validate, may_publish

class RuntimePolicyTests(unittest.TestCase):
    def test_exact_single_runtime_for_each_registered_project(self):
        selected = validate({'version':1, 'projects':{'a':'typescript', 'b':'flutter'}}, {'a':'co', 'b':'ci'})
        self.assertTrue(may_publish('a', 'typescript', selected)); self.assertFalse(may_publish('a', 'flutter', selected))
        self.assertTrue(may_publish('b', 'flutter', selected)); self.assertFalse(may_publish('b', 'typescript', selected))
    def test_unknown_project_and_runtime_fail_closed(self):
        for project, runtime in [('other', 'typescript'), ('a', 'unknown')]:
            with self.assertRaises(ValueError): may_publish(project, runtime, {'a':'typescript'})
    def test_incomplete_or_extra_project_policy_rejected(self):
        for selected in [{}, {'a':'typescript', 'other':'flutter'}]:
            with self.assertRaises(ValueError): validate({'version':1, 'projects':selected}, {'a':'co'})
    def test_ambiguous_or_unknown_runtime_rejected(self):
        for runtime in [['flutter','typescript'], 'automatic', None]:
            with self.assertRaises(ValueError): validate({'version':1, 'projects':{'a':runtime}}, {'a':'co'})
    def test_policy_schema_is_strict(self):
        for policy in [{'version':True,'projects':{'a':'typescript'}}, {'version':2,'projects':{'a':'typescript'}}, {'version':1,'projects':{'a':'typescript'},'fallback':'flutter'}]:
            with self.assertRaises(ValueError): validate(policy, {'a':'co'})
    def test_current_portals_choose_typescript(self):
        import json
        from pathlib import Path
        selected = validate(json.loads(Path('websites/production-runtime.json').read_text()), json.loads(Path('websites/typescript/projects.json').read_text()))
        self.assertEqual(len(selected),9)
        self.assertTrue(all(may_publish(p,'typescript',selected) and not may_publish(p,'flutter',selected) for p in selected))

if __name__ == '__main__': unittest.main()
