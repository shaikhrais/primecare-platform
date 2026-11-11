"""Exact replay rejects extra code, endpoint changes and weakened proof inputs."""
import copy
import importlib.util
import json
from pathlib import Path
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('replay', Path(__file__).with_name('workflow_theme_replay.py'))
m = importlib.util.module_from_spec(spec);spec.loader.exec_module(m)


class ReplayTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.hashes = json.loads((ROOT/'docs/api/workflow-contract-reviews.json').read_text())['sourceHashes']
        cls.replay = m.WorkflowThemeReplay(ROOT, cls.hashes)
        cls.filename = 'packages/primecare_ui/lib/src/features/generated_screens/premium_feature_1.dart'
        cls.content = (ROOT/cls.filename).read_bytes()

    def test_premium_and_core_recipes_reproduce_current_bytes_without_refreshing_hashes(self):
        hashes = dict(self.hashes)
        for filename in (self.filename, 'packages/flutter_core/lib/registry/widgets/responsive_split_dashboard.dart'):
            self.replay.verify(filename, (ROOT/filename).read_bytes())
        self.assertEqual(self.hashes, hashes)
        self.assertEqual(len(self.replay.recipes), 189)

    def test_extra_code_route_and_label_drift_cannot_use_a_theme_receipt(self):
        variants = [self.content+b'\nvoid unreviewed() {}\n',
            self.content.replace(b'/v1/premium/user', b'/v1/premium/unreviewed', 1),
            self.content.replace(b'Telemetry Node Health', b'Changed business label', 1)]
        for content in variants:
            self.assertNotEqual(content, self.content)
            with self.assertRaisesRegex(ValueError, 'exceeds exact reviewed'):
                self.replay.verify(self.filename, content)

    def test_wrong_original_bytes_fail_even_if_current_output_is_unchanged(self):
        with patch.object(self.replay, 'historical', return_value=b'forged baseline'):
            with self.assertRaisesRegex(ValueError, 'historical source hash mismatch'):
                self.replay.verify(self.filename, self.content)

    def test_unlisted_sources_remain_unreviewed(self):
        with self.assertRaisesRegex(ValueError, 'Unreviewed theme replay source'):
            self.replay.verify('packages/primecare_ui/lib/src/components/governance_components.dart', b'anything')

    def test_operation_count_drift_is_rejected(self):
        replay = m.WorkflowThemeReplay(ROOT, self.hashes)
        replay.doc['pipelines'][replay.recipes[self.filename]][0][2] += 1
        with self.assertRaisesRegex(ValueError, 'operation count changed'):
            replay.verify(self.filename, self.content)

    def test_authority_flags_dependencies_paths_and_unreviewed_steps_are_rejected(self):
        mutations = [lambda d:d.update(noActivation=False), lambda d:d.update(implementationCredits=1),
            lambda d:d.update(retirementCredits=1), lambda d:d.update(implementationCredits=False),
            lambda d:d.update(baselineCommit='0'*40), lambda d:d['dependencies'].pop(next(iter(d['dependencies']))),
            lambda d:d['dependencies'].update({'scripts/migrate-shared-status.py':'0'*64}),
            lambda d:d['recipes'].update({'../unreviewed.dart':'premium-template-v1'}),
            lambda d:d['pipelines']['premium-template-v1'][0].__setitem__(0,'generate-workflow-contract-plan.py'),
            lambda d:d['pipelines']['premium-template-v1'][0].__setitem__(2,True)]
        for mutate in mutations:
            doc = copy.deepcopy(self.replay.doc);mutate(doc)
            with patch.object(m.json, 'loads', return_value=doc):
                with self.assertRaises(ValueError):m.WorkflowThemeReplay(ROOT, self.hashes)


if __name__ == '__main__':unittest.main()
