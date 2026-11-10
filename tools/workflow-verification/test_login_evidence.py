"""Synthetic offline + native PostgreSQL cases, executed only on GitHub Actions."""
import copy
import concurrent.futures
import datetime
import json
import unittest
from unittest.mock import patch

from gates import digest
from execution import record_attempt
from record_login_evidence import FLOW, REPOSITORY, WORKFLOW, make_result, save_once, readback
from test_execution import ExecutionTests
from test_production_store import NativeStoreTests, URL


class LoginEvidenceTests(unittest.TestCase):
    def setUp(self):
        ExecutionTests.setUp(self)

    evidence = ExecutionTests.evidence

    def item(self, *, run=42, start='2026-11-09T10:00:00Z'):
        job = {'id': run * 10, 'name': 'login-race (unmerged-candidate)',
               'run_id': run, 'run_attempt': 1, 'conclusion': 'success',
               'started_at': start, 'completed_at': start,
               'html_url': f'https://github.com/{REPOSITORY}/actions/runs/{run}/job/{run * 10}'}
        receipt = {'workflow_id': FLOW, 'scope': 'scoped', 'wholeTaskVerified': False,
                   'commit': 'b' * 40, 'workflow_run_sha': 'a' * 40,
                   'passed': True, 'loginLifecycleOnly': True, 'loginLifecycleBaseline': False,
                   'started_at': start, 'finished_at': start, 'browser': 'chromium',
                   'browser_version': '148.0.7778.96', 'source_bindings': self.sources,
                   'criterion_results': {'ui.login-session-replacement': 'passed'},
                   'loginLifecycleCases': [{'locale': loc, 'replacementSessionPreserved': True,
                       'provisionalSessionRevoked': True, 'noStaleNavigation': True} for loc in ['en','fr','es']]}
        item = {'run': {'id': run, 'run_attempt': 1, 'repository': {'full_name': REPOSITORY},
                'path': WORKFLOW, 'head_branch': 'main', 'event': 'push', 'status': 'completed',
                'head_sha': 'a' * 40, 'html_url': f'https://github.com/{REPOSITORY}/actions/runs/{run}'},
                'job': job, 'matrix': {'source': 'b' * 40, 'label': 'unmerged-candidate', 'baseline': '0'},
                'receipt': receipt, 'source_bindings': self.sources,
                'evidence': [self.evidence('result.json','receipt')], 'validation_errors': [],
                'receipt_sha256': digest(self.root/'result.json')}
        return self.bind(item)

    def bind(self, item):
        if item.get('receipt') is not None:
            name = 'receipt-' + str(item['run']['id']) + '.json'
            (self.root/name).write_text(json.dumps(item['receipt']))
            item['receipt_path'] = name
            item['receipt_sha256'] = digest(self.root/name)
            item['evidence'] = [self.evidence(name,'receipt')]
            item['original_source_files'] = {'source.ts': 'source.ts'}
        return item

    def result(self, item):
        return make_result(self.bind(item), self.root)

    def save(self, item):
        return save_once(self.db, self.result(item), self.root, self.plan['id'])

    def test_duplicate_import_and_readback_preserve_original_time(self):
        item = self.item()
        first = self.save(item)
        second = self.save(item)
        self.assertEqual(first['attempt_id'],second['attempt_id'])
        self.assertFalse(first['duplicate']); self.assertTrue(second['duplicate'])
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0],1)
        saved = readback(self.db, first['attempt_id'], self.plan['id'])
        self.assertEqual(saved['verification_status'],'implemented-unverified')
        self.assertEqual(saved['checkpoint_id'],self.plan['id'])
        self.assertEqual(saved['execution']['started_at'],item['receipt']['started_at'])
        self.assertNotEqual(saved['ingested_at'],item['receipt']['started_at'])
        self.assertEqual(len(saved['execution']['cases']),3)

    def test_conflicting_same_identity_rejected_without_duplicate(self):
        item = self.item(); self.save(item)
        item['matrix']['source'] = 'c' * 40
        item['receipt']['commit'] = 'c' * 40
        with self.assertRaisesRegex(ValueError,'Conflicting'):
            self.save(item)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0],1)

    def test_pre_case_failure_is_failure_not_baseline_reproduction(self):
        item = self.item(); item['job']['conclusion'] = 'failure'
        item['receipt'].update(passed=False, error='Timed out waiting for platform-language',
                               loginLifecycleCases=[],loginLifecycleBaseline=True)
        result = self.result(item)
        self.assertEqual(result['test_status'],'failed')
        self.assertEqual(result['execution']['cases'],[])
        self.assertIn('Timed out',result['issues'][0]['actual'])
        saved = self.save(item)
        self.assertEqual(readback(self.db,saved['attempt_id'],self.plan['id'])['attempt_test_status'],'failed')

    def test_successful_baseline_job_with_defect_is_still_failure(self):
        item = self.item(); item['receipt'].update(passed=False, loginLifecycleBaseline=True,
            failures=[{'criterion_id':'ui.login-session-replacement','actual':'older overwrote newer'}])
        self.assertEqual(self.result(item)['test_status'],'failed')

    def test_missing_or_invalid_receipt_is_blocked_and_retains_github_evidence(self):
        for receipt in (None,self.item()['receipt']):
            item = self.item(); item.update(receipt=receipt,validation_errors=['Original evidence unavailable'])
            result = self.result(item)
            self.assertEqual(result['test_status'],'blocked')
            self.assertEqual(result['execution']['source_binding_status'],'metadata-only')
            self.assertEqual(result['execution']['cases'],[])
            self.assertTrue(result['evidence'])

    def test_incomplete_or_contradictory_pass_rejected(self):
        mutations = [lambda i:i['receipt']['loginLifecycleCases'].pop(),
            lambda i:i['receipt'].update(wholeTaskVerified=True),
            lambda i:i['receipt'].update(error='failure'),
            lambda i:i['job'].update(conclusion='failure'),
            lambda i:i['receipt'].update(loginLifecycleBaseline=True),
            lambda i:i['receipt']['loginLifecycleCases'][0].update(noStaleNavigation=False),
            lambda i:i['run'].update(head_branch='untrusted'),
            lambda i:i['job'].update(run_attempt=2),
            lambda i:i['matrix'].update(baseline='1'),
            lambda i:i['receipt']['loginLifecycleCases'][0].update(defectReproduced=True)]
        for mutate in mutations:
            item=self.item(); mutate(item)
            with self.assertRaises(ValueError): self.result(item)

    def test_historical_append_does_not_replace_newer_checkpoint(self):
        recent = self.save(self.item(run=44,start='2026-11-09T12:00:00Z'))
        older = self.save(self.item(run=43,start='2026-11-09T11:00:00Z'))
        saved = readback(self.db,older['attempt_id'],self.plan['id'])
        self.assertEqual(saved['checkpoint_attempt_id'],recent['attempt_id'])
        self.assertEqual(saved['execution']['started_at'],'2026-11-09T11:00:00Z')

    def test_unknown_existing_chronology_preserves_status_and_checkpoint(self):
        old=record_attempt(self.db,self.plan['id'],self.scoped,self.root)
        saved=self.save(self.item())
        self.assertEqual(readback(self.db,saved['attempt_id'],self.plan['id'])['checkpoint_attempt_id'],old['attempt_id'])

    def test_packet_tampering_and_unbound_source_are_rejected(self):
        item=self.item()
        item['receipt']['browser_version']='999'
        with self.assertRaisesRegex(ValueError,'receipt bytes'):
            make_result(item,self.root)
        item=self.item(); item['original_source_files']={}
        with self.assertRaisesRegex(ValueError,'reconstruction'):
            make_result(item,self.root)

    def test_readback_evidence_mismatch_fails(self):
        saved=self.save(self.item())
        # Exercise reader validation without adding a production write interface.
        original=self.db.execute
        def changed(sql,args=()):
            if sql.startswith('SELECT kind,path,sha256,url'):
                class Empty:
                    def fetchall(self):return []
                return Empty()
            return original(sql,args)
        class Reader:
            execute=staticmethod(changed)
        with self.assertRaisesRegex(ValueError,'evidence readback'):
            readback(Reader(),saved['attempt_id'],self.plan['id'])


@unittest.skipUnless(URL,'Native isolated PostgreSQL service required')
class NativeLoginEvidenceTests(LoginEvidenceTests):
    setUp = NativeStoreTests.setUp
    table = NativeStoreTests.table
    open_store = NativeStoreTests.open_store

    def test_concurrent_duplicate_imports_commit_one_attempt(self):
        item=self.item(); result=self.result(item)
        self.db.db.commit()
        def save(_):
            with self.open_store() as db:
                return save_once(db,result,self.root,self.plan['id'])
        with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
            saved=list(pool.map(save,range(2)))
        self.assertEqual(saved[0]['attempt_id'],saved[1]['attempt_id'])
        self.assertEqual(sorted(x['duplicate'] for x in saved),[False,True])
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0],1)


if __name__=='__main__':
    unittest.main()
