"""Synthetic recorder tests; never execute or approve a PrimeCare workflow."""
import copy
import json
import sqlite3
import tempfile
import unittest
from pathlib import Path

from execution import acceptance_ids, prepare, record_attempt, refresh, summary
from gates import GATES, digest
from register_virtual_flows import prepare as prepare_catalog, save


class ExecutionTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.regression_runs = 0
        self.db = sqlite3.connect(':memory:')
        self.addCleanup(self.db.close)
        prepare_catalog(self.db)
        prepare(self.db)
        self.plan = {'id': 'synthetic.workflow', 'kind': 'business_process',
                     'title': 'Synthetic recorder fixture', 'actor_roles': ['synthetic'],
                     'trigger': 'Synthetic trigger', 'preconditions': ['Synthetic isolated account'],
                     'outcome': 'Synthetic persisted result',
                     'steps': [{'action': 'Synthetic login', 'expected': 'Synthetic session'},
                               {'action': 'Synthetic save/reload', 'expected': 'Synthetic same result'}],
                     'alternative_paths': ['Synthetic denied cross-tenant action'],
                     'source_paths': ['source.ts'], 'definition_quality': 'source_mapped'}
        save(self.db, self.plan)
        (self.root / 'source.ts').write_text('synthetic source only')
        (self.root / 'result.json').write_text('{"synthetic": true}')
        self.sources = {'source.ts': digest(self.root / 'source.ts')}
        self.scoped = {'status': 'implemented-unverified', 'test_status': 'scoped_pass',
                       'scope': 'scoped', 'next_action': 'Run actual credential browser workflow.',
                       'source_bindings': self.sources, 'evidence': [self.evidence('result.json', 'api')],
                       'issues': [], 'blockers': ['Synthetic scoped evidence only; no real workflow execution.']}

    def evidence(self, name, kind):
        return {'path': name, 'sha256': digest(self.root / name), 'kind': kind}

    def full_proof(self):
        """Entirely synthetic gate/receipt data solely for recorder validation."""
        definition, sha = self.db.execute('SELECT definition_json,definition_sha256 FROM virtual_workflow_definitions').fetchone()
        (self.root / 'spec.json').write_text(definition)
        ids = acceptance_ids(self.plan)
        review = {'workflow_id': self.plan['id'], 'definition_sha256': sha,
                  'reviewed_by': 'synthetic-test-reviewer', 'approval_id': 'synthetic-approval',
                  'acceptance_ids': ids}
        (self.root / 'review.json').write_text(json.dumps(review))
        artifacts = []
        for kind in ('browser', 'api', 'database', 'security', 'video'):
            name = kind + '.artifact'
            (self.root / name).write_text('Synthetic ' + kind + ' fixture; not real workflow evidence.')
            artifacts.append(self.evidence(name, kind))
        receipt = {'workflow_id': self.plan['id'], 'definition_sha256': sha,
                   'scope': 'workflow', 'result': 'passed', 'run_id': 'synthetic-run',
                   'runner': 'synthetic-unittest', 'started_at': '2026-01-01T00:00:00Z',
                   'finished_at': '2026-01-01T00:01:00Z', 'login_method': 'credentials',
                   'isolated_database': True, 'reload_confirmed': True,
                   'source_bindings': self.sources,
                   'acceptance_results': {key: 'passed' for key in ids}, 'artifacts': artifacts}
        (self.root / 'receipt.json').write_text(json.dumps(receipt))
        gates = {'workflow_id': self.plan['id'], 'gates': {
            name: {'status': 'passed', 'sources': self.sources,
                   'specifications': {'spec.json': sha},
                   'artifacts': {'result.json': digest(self.root / 'result.json')},
                   'approval_id': 'synthetic-approval'} for name in GATES}}
        gates['gates']['review']['artifacts'] = {'review.json': digest(self.root / 'review.json')}
        gates['gates']['behavior']['artifacts'] = {'receipt.json': digest(self.root / 'receipt.json')}
        return {**self.scoped, 'status': 'verified', 'scope': 'workflow', 'test_status': 'passed',
                'source_bindings': self.sources,
                'blockers': [], 'next_action': 'Monitor current synthetic bindings.',
                'gate_record': gates, 'acceptance_review_path': 'review.json',
                'workflow_receipt_path': 'receipt.json',
                'evidence': artifacts + [self.evidence('receipt.json', 'receipt'), self.evidence('review.json', 'review')]}

    def test_scoped_pass_records_resume_evidence_but_never_completes(self):
        result = record_attempt(self.db, self.plan['id'], self.scoped, self.root)
        self.assertEqual(result['summary'], {'total': 1, 'missing': 0, 'implemented-unverified': 1,
                                            'verified': 0, 'blocked': 0, 'done': 0, 'pending': 1})
        self.assertEqual(self.db.execute('SELECT next_action FROM virtual_workflow_checkpoints').fetchone()[0], self.scoped['next_action'])
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_evidence').fetchone()[0], 1)

    def test_failure_requires_issue_and_preserves_exact_reproduction(self):
        failed = {**self.scoped, 'test_status': 'failed'}
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], failed, self.root)
        failed['issues'] = [{'criterion_id': 'step:2', 'reproduction': 'Synthetic save then reload.',
                            'expected': 'Synthetic row is present.', 'actual': 'Synthetic row is absent.',
                            'affected_sources': ['source.ts']}]
        record_attempt(self.db, self.plan['id'], failed, self.root)
        self.assertEqual(self.db.execute('SELECT reproduction,actual_text FROM virtual_workflow_issues').fetchone(),
                         ('Synthetic save then reload.', 'Synthetic row is absent.'))

    def test_unknown_flow_supporting_guide_and_invalid_status_rejected(self):
        for flow_id in ('invented', 'screen.1'):
            with self.assertRaises(ValueError):
                record_attempt(self.db, flow_id, self.scoped, self.root)
        for value in ('done', 'passed', 'complete'):
            with self.assertRaises(ValueError):
                record_attempt(self.db, self.plan['id'], {**self.scoped, 'status': value}, self.root)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0], 0)

    def test_blocked_and_missing_need_exact_explanation_not_review(self):
        record_attempt(self.db, self.plan['id'], {**self.scoped, 'status': 'blocked',
                       'test_status': 'blocked', 'evidence': []}, self.root)
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], {**self.scoped, 'status': 'blocked', 'blockers': []}, self.root)
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], {**self.scoped, 'status': 'missing'}, self.root)

    def test_generic_pass_or_seven_gates_without_receipt_cannot_verify(self):
        result = {**self.scoped, 'status': 'verified', 'test_status': 'passed', 'scope': 'workflow', 'blockers': []}
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], result, self.root)
        result['gate_record'] = self.full_proof()['gate_record']
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], result, self.root)

    def test_all_current_reviewed_criteria_and_receipts_required(self):
        result = self.full_proof()
        self.assertEqual(record_attempt(self.db, self.plan['id'], result, self.root)['summary']['verified'], 1)
        for mutate in (lambda r: r.update(scope='scoped'),
                       lambda r: r['gate_record']['gates']['security'].update(status='blocked'),
                       lambda r: r.update(blockers=['Still missing browser proof.']),
                       lambda r: r.update(issues=[{'criterion_id': 'outcome', 'reproduction': 'Synthetic',
                                                  'expected': 'Synthetic', 'actual': 'Synthetic fail',
                                                  'affected_sources': ['source.ts']}])):
            changed = copy.deepcopy(result)
            mutate(changed)
            with self.assertRaises(ValueError):
                record_attempt(self.db, self.plan['id'], changed, self.root)

    def test_omitted_acceptance_result_rejected_even_if_rehashed(self):
        result = self.full_proof()
        receipt_path = self.root / 'receipt.json'
        receipt = json.loads(receipt_path.read_text())
        del receipt['acceptance_results']['alternative:1']
        receipt_path.write_text(json.dumps(receipt))
        for evidence in result['evidence']:
            if evidence['path'] == 'receipt.json': evidence['sha256'] = digest(receipt_path)
        result['gate_record']['gates']['behavior']['artifacts']['receipt.json'] = digest(receipt_path)
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], result, self.root)

    def test_unreviewed_criterion_and_missing_video_cannot_be_promoted(self):
        for target in ('review', 'video'):
            with self.subTest(target=target):
                result = self.full_proof()
                if target == 'review':
                    path = self.root / 'review.json'
                    review = json.loads(path.read_text())
                    review['acceptance_ids'].remove('step:2')
                    path.write_text(json.dumps(review))
                    for evidence in result['evidence']:
                        if evidence['path'] == 'review.json': evidence['sha256'] = digest(path)
                    result['gate_record']['gates']['review']['artifacts']['review.json'] = digest(path)
                else:
                    result['evidence'] = [e for e in result['evidence'] if e['kind'] != 'video']
                with self.assertRaises(ValueError):
                    record_attempt(self.db, self.plan['id'], result, self.root)

    def test_source_change_invalidates_completion_and_preserves_history(self):
        record_attempt(self.db, self.plan['id'], self.full_proof(), self.root)
        before = self.db.execute('SELECT COUNT(*) FROM virtual_workflow_evidence').fetchone()[0]
        (self.root / 'source.ts').write_text('changed synthetic source')
        result = refresh(self.db, self.root)
        self.assertEqual(result['summary']['verified'], 0)
        self.assertEqual(result['summary']['implemented-unverified'], 1)
        self.assertEqual(self.db.execute('SELECT test_status FROM virtual_workflow_definitions').fetchone()[0], 'stale')
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_evidence').fetchone()[0], before)

    def test_definition_change_blocks_and_evidence_change_invalidates(self):
        record_attempt(self.db, self.plan['id'], self.scoped, self.root)
        self.plan['outcome'] += ' A revised synthetic expectation.'
        save(self.db, self.plan)
        self.assertEqual(refresh(self.db, self.root)['summary']['blocked'], 1)
        current = {**self.scoped}
        record_attempt(self.db, self.plan['id'], current, self.root)
        (self.root / 'result.json').write_text('changed evidence')
        self.assertEqual(refresh(self.db, self.root)['summary']['implemented-unverified'], 1)
        self.assertIn('Evidence binding', self.db.execute('SELECT invalidation_json FROM virtual_workflow_checkpoints').fetchone()[0])

    def test_missing_stale_unsafe_evidence_rejected_without_partial_attempt(self):
        for bindings in ({'../outside.ts': 'abc'}, {'missing.ts': 'abc'}, {'source.ts': 'abc'}, {}):
            with self.assertRaises(ValueError):
                record_attempt(self.db, self.plan['id'], {**self.scoped, 'source_bindings': bindings}, self.root)
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], {**self.scoped, 'evidence': []}, self.root)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0], 0)

    def test_summary_excludes_supporting_guides_and_is_repeatable(self):
        guide = {**self.plan, 'id': 'screen.1', 'kind': 'screen_journey'}
        save(self.db, guide)
        for _ in range(2):
            record_attempt(self.db, self.plan['id'], self.scoped, self.root)
        self.assertEqual(summary(self.db)['total'], 1)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0], 2)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_checkpoints').fetchone()[0], 1)
        with self.assertRaises(ValueError):
            record_attempt(self.db, 'screen.1', self.scoped, self.root)

    def test_recording_does_not_commit_unrelated_caller_changes(self):
        self.db.commit()
        self.db.execute('CREATE TABLE unrelated(value TEXT)')
        self.db.commit()
        self.db.execute("INSERT INTO unrelated VALUES('caller uncommitted')")
        record_attempt(self.db, self.plan['id'], self.scoped, self.root)
        self.db.rollback()
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM unrelated').fetchone()[0], 0)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0], 0)

    def failed_issue(self):
        failed = {**self.scoped, 'test_status': 'failed', 'issues': [
            {'criterion_id': 'step:2', 'reproduction': 'Synthetic save then reload.',
             'expected': 'Synthetic persisted value.', 'actual': 'Synthetic stale value.',
             'affected_sources': ['source.ts']}]}
        record_attempt(self.db, self.plan['id'], failed, self.root)
        return self.db.execute('SELECT MAX(issue_id) FROM virtual_workflow_issues').fetchone()[0]

    def resolution_result(self, issue_id):
        self.regression_runs += 1
        (self.root / 'regression.json').write_text(json.dumps({
            'run_id': 'synthetic-focused-rerun-' + str(self.regression_runs),
            'criterion_results': {'step:2': 'passed'}}))
        return {**self.scoped, 'source_bindings': self.sources,
                'evidence': self.scoped['evidence'] + [self.evidence('regression.json', 'regression')],
                'resolves_issue_ids': [issue_id], 'resolution_note': 'Synthetic original reproduction now passes.',
                'issue_resolution_results': {str(issue_id): {
                    'criterion_id': 'step:2', 'result': 'passed', 'reproduction_verified': True,
                    'evidence_path': 'regression.json'}}}

    def test_successful_rerun_links_resolution_and_retains_original_failure(self):
        issue_id = self.failed_issue()
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], self.full_proof(), self.root)
        resolution = {**self.resolution_result(issue_id),
                      'resolution_note': 'Synthetic defect fixed; original reproduction now passes.'}
        result = record_attempt(self.db, self.plan['id'], resolution, self.root)
        self.assertEqual(result['summary']['verified'], 0)
        self.assertEqual(self.db.execute('SELECT issue_id,attempt_id,resolution_note FROM virtual_workflow_issue_resolutions').fetchone(),
                         (issue_id, result['attempt_id'], 'Synthetic defect fixed; original reproduction now passes.'))
        self.assertEqual(self.db.execute('SELECT actual_text FROM virtual_workflow_issues').fetchone()[0], 'Synthetic stale value.')
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0], 2)

    def test_resolution_rejects_foreign_missing_duplicate_unsuccessful_and_unproved_references(self):
        issue_id = self.failed_issue()
        resolution = self.resolution_result(issue_id)
        other = {**self.plan, 'id': 'synthetic.other'}
        save(self.db, other)
        for flow_id, changed in (
            (other['id'], resolution),
            (self.plan['id'], {**resolution, 'resolves_issue_ids': [999]}),
            (self.plan['id'], {**resolution, 'resolves_issue_ids': [issue_id, issue_id]}),
            (self.plan['id'], {**resolution, 'resolution_note': ''}),
            (self.plan['id'], {**resolution, 'test_status': 'not_run'}),
            (self.plan['id'], {**resolution, 'evidence': []})):
            with self.subTest(flow_id=flow_id, changed=changed):
                with self.assertRaises(ValueError):
                    record_attempt(self.db, flow_id, changed, self.root)
        record_attempt(self.db, self.plan['id'], resolution, self.root)
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], resolution, self.root)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_issue_resolutions').fetchone()[0], 1)

    def test_unrelated_pass_unbound_receipt_and_conflicting_failure_cannot_close_issue(self):
        issue_id = self.failed_issue()
        resolution = self.resolution_result(issue_id)
        for changed in (
            {**resolution, 'issue_resolution_results': {}},
            {**resolution, 'issue_resolution_results': {str(issue_id): {
                'criterion_id': 'step:1', 'result': 'passed', 'reproduction_verified': True,
                'evidence_path': 'regression.json'}}},
            {**resolution, 'evidence': self.scoped['evidence']},
            {**resolution, 'issues': [{'criterion_id': 'step:2', 'reproduction': 'Synthetic fail.',
                'expected': 'Synthetic success.', 'actual': 'Synthetic failure.', 'affected_sources': ['source.ts']}]}
        ):
            with self.assertRaises(ValueError):
                record_attempt(self.db, self.plan['id'], changed, self.root)
        (self.root / 'regression.json').write_text('{"criterion_results":{"step:1":"passed"}}')
        resolution['evidence'][-1] = self.evidence('regression.json', 'regression')
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], resolution, self.root)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_issue_resolutions').fetchone()[0], 0)

    def test_stale_source_spec_or_evidence_requires_fresh_focused_resolution_before_verified(self):
        issue_id = self.failed_issue()
        record_attempt(self.db, self.plan['id'], self.resolution_result(issue_id), self.root)
        for changed in ('source', 'specification', 'evidence'):
            with self.subTest(changed=changed):
                if changed == 'source':
                    (self.root / 'source.ts').write_text('changed synthetic source after focused test')
                    self.sources = {'source.ts': digest(self.root / 'source.ts')}
                elif changed == 'specification':
                    self.plan['outcome'] += ' Changed synthetic acceptance.'
                    save(self.db, self.plan)
                else:
                    (self.root / 'regression.json').write_text('{"criterion_results":{"step:2":"passed"},"changed":true}')
                proof = self.full_proof()
                with self.assertRaises(ValueError):
                    record_attempt(self.db, self.plan['id'], proof, self.root)
                record_attempt(self.db, self.plan['id'], self.resolution_result(issue_id), self.root)
                self.assertEqual(record_attempt(self.db, self.plan['id'], self.full_proof(), self.root)['status'], 'verified')
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_issue_resolutions').fetchone()[0], 4)

    def test_attempt_without_prior_dml_remains_in_callers_transaction(self):
        self.db.commit()
        with self.assertRaises(RuntimeError):
            with self.db:
                record_attempt(self.db, self.plan['id'], self.scoped, self.root)
                raise RuntimeError('Synthetic later checkpoint failure.')
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0], 0)

    def test_recheck_reuses_original_open_issue_without_duplicate_rows_or_closure(self):
        issue_id = self.failed_issue()
        original = self.db.execute('SELECT * FROM virtual_workflow_issues').fetchone()
        recheck = {**self.scoped, 'status': 'missing', 'test_status': 'failed',
                   'issues': [], 'existing_issue_ids': [issue_id]}
        for _ in range(2):
            result = record_attempt(self.db, self.plan['id'], recheck, self.root)
            self.assertEqual(result['status'], 'missing')
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_issues').fetchone()[0], 1)
        self.assertEqual(self.db.execute('SELECT * FROM virtual_workflow_issues').fetchone(), original)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0], 3)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_issue_resolutions').fetchone()[0], 0)
        saved = json.loads(self.db.execute('SELECT result_json FROM virtual_workflow_attempts ORDER BY attempt_id DESC LIMIT 1').fetchone()[0])
        self.assertEqual(saved['existing_issue_ids'], [issue_id])
        with self.assertRaises(ValueError):
            record_attempt(self.db, self.plan['id'], self.full_proof(), self.root)

    def test_recheck_rejects_foreign_invalid_unbound_and_unproved_issue_references(self):
        issue_id = self.failed_issue()
        other = {**self.plan, 'id': 'synthetic.other'}
        save(self.db, other)
        recheck = {**self.scoped, 'test_status': 'failed', 'existing_issue_ids': [issue_id]}
        (self.root / 'other.ts').write_text('Synthetic unrelated source.')
        for flow_id, changed in (
            (other['id'], recheck),
            (self.plan['id'], {**recheck, 'existing_issue_ids': [issue_id, issue_id]}),
            (self.plan['id'], {**recheck, 'existing_issue_ids': [0]}),
            (self.plan['id'], {**recheck, 'existing_issue_ids': [True]}),
            (self.plan['id'], {**recheck, 'existing_issue_ids': [999]}),
            (self.plan['id'], {**recheck, 'evidence': []}),
            (self.plan['id'], {**recheck, 'source_bindings': {'other.ts': digest(self.root / 'other.ts')}})):
            with self.subTest(flow_id=flow_id, changed=changed):
                with self.assertRaises(ValueError):
                    record_attempt(self.db, flow_id, changed, self.root)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0], 1)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_issues').fetchone()[0], 1)

    def test_evidence_links_allow_web_and_application_urls_and_reject_executable_schemes(self):
        for value in ('https://example.test/evidence/video.webm', 'http://localhost/evidence', '/v1/evidence/video'):
            result = copy.deepcopy(self.scoped)
            result['evidence'][0]['url'] = value
            record_attempt(self.db, self.plan['id'], result, self.root)
        for value in ('javascript:alert(1)', 'data:text/html,test', 'file:///tmp/video',
                      '//example.test/video', '/\\example.test/video', 'https://user:password@example.test/video',
                      'https://example.test/with space', ''):
            result = copy.deepcopy(self.scoped)
            result['evidence'][0]['url'] = value
            with self.subTest(value=value):
                with self.assertRaises(ValueError):
                    record_attempt(self.db, self.plan['id'], result, self.root)


if __name__ == '__main__':
    unittest.main()
