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

    def test_exact_guard_proof_preserves_every_original_dependency_pin(self):
        doc = self.replay.doc
        self.assertEqual(len(doc['dependencies']), 29)
        self.assertEqual(m.digest(json.dumps(doc['dependencies'], sort_keys=True, separators=(',', ':')).encode()), m.DEPENDENCY_PINS_SHA256)
        self.assertEqual(doc['dependencies'][m.GUARD], m.GUARD_BASELINE_SHA256)
        current = (ROOT/m.GUARD).read_bytes()
        original = m.dependency_original(current, doc['dependencies'][m.GUARD], doc['dependencyAmendments'][m.GUARD])
        self.assertNotEqual(original, current)
        self.assertEqual(m.digest(original), m.GUARD_BASELINE_SHA256)

    def test_extra_dependency_bytes_cannot_hide_in_an_exact_proof(self):
        current = (ROOT/m.GUARD).read_bytes();proof = self.replay.doc['dependencyAmendments'][m.GUARD]
        for changed in (current+b'\n# unreviewed dependency code\n', current.replace(b'COLOR_TEAR_OFF', b'UNREVIEWED_PATTERN', 1)):
            with self.assertRaises(ValueError):m.dependency_original(changed, m.GUARD_BASELINE_SHA256, proof)
            forged = copy.deepcopy(proof);forged['updatedSha256'] = m.digest(changed)
            with self.assertRaises(ValueError):m.dependency_original(changed, m.GUARD_BASELINE_SHA256, forged)

    def test_dependency_paths_pin_refresh_and_malformed_spans_are_rejected(self):
        current_hash = m.digest((ROOT/m.GUARD).read_bytes())
        mutations = [lambda d:d['dependencies'].update({m.GUARD:current_hash}),
            lambda d:d['dependencyAmendments'].update({'scripts/migrate-shared-text.py':copy.deepcopy(d['dependencyAmendments'][m.GUARD])}),
            lambda d:d['dependencyAmendments'].update({m.GUARD:{**d['dependencyAmendments'][m.GUARD], 'edits':[]}}),
            lambda d:d['dependencyAmendments'][m.GUARD]['edits'][0].update(begin=True),
            lambda d:d['dependencyAmendments'][m.GUARD]['edits'][0].update(new='unreviewed'),
            lambda d:d.update(version=1),lambda d:d.update(dependencyAmendments={})]
        for mutate in mutations:
            doc = copy.deepcopy(self.replay.doc);mutate(doc)
            with patch.object(m.json, 'loads', return_value=doc):
                with self.assertRaises(ValueError):m.WorkflowThemeReplay(ROOT, self.hashes)

    def test_replay_keeps_the_stricter_live_guard_in_place(self):
        path = ROOT/m.GUARD;before = path.read_bytes()
        self.replay.verify(self.filename, self.content)
        self.assertEqual(path.read_bytes(), before)
        spec = importlib.util.spec_from_file_location('live_guard', path);guard = importlib.util.module_from_spec(spec);spec.loader.exec_module(guard)
        for name in ('new', 'fromARGB', 'fromRGBO', 'from'):
            self.assertEqual(len(guard.violations('final factory = Color.'+name+';', True)), 1)

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
