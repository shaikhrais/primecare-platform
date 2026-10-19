"""Native PostgreSQL regression suite, using a disposable service database only."""
import concurrent.futures
import copy
import hashlib
import json
import os
import sqlite3
import unittest
from pathlib import Path
from unittest.mock import patch

import psycopg
from psycopg.types.json import Jsonb
import test_execution as fixtures
from production_store import ProductionWorkflowStore, KEYS, PIN, quote
from execution import record_attempt, refresh, export_progress

URL = os.environ.get('WORKFLOW_TEST_DATABASE_URL')


@unittest.skipUnless(URL, 'Native isolated PostgreSQL service required')
class NativeStoreTests(unittest.TestCase):
    def setUp(self):
        fixtures.ExecutionTests.setUp(self)
        self.sqlite = self.db
        self.env = patch.dict(os.environ, {'GOVERNANCE_ALLOW_TEST_FIXTURE': '1', 'NODE_ENV': 'test'})
        self.env.start()
        self.addCleanup(self.env.stop)
        pin = json.loads(PIN.read_text())
        self.schema = pin['schema']
        # Test connection is accepted only without any production credentials.
        if os.environ.get('GOVERNANCE_DATABASE_URL') or os.environ.get('PRODUCTION_DATABASE_URL'):
            raise RuntimeError('Never run fixture setup with production credentials')
        admin = psycopg.connect(URL, autocommit=True)
        self.addCleanup(admin.close)
        admin.execute('DROP SCHEMA IF EXISTS '+quote(self.schema)+' CASCADE')
        admin.execute('CREATE SCHEMA '+quote(self.schema))
        manifest = {'tables': [], 'sqlite_objects': []}
        for table in KEYS:
            info = self.sqlite.execute('PRAGMA table_info('+table+')').fetchall()
            data = self.sqlite.execute('SELECT * FROM '+table).fetchall()
            columns = []
            types = []
            for index, col in enumerate(info):
                kinds = sorted({'integer' if type(row[index]) is int else 'text' for row in data if row[index] is not None})
                columns.append({'name': col[1], 'declared_type': col[2], 'storage_types': kinds})
                types.append('bigint' if kinds == ['integer'] else 'text' if kinds == ['text'] else 'jsonb')
            manifest['tables'].append({'name': table, 'columns': columns})
            admin.execute('CREATE TABLE '+self.table(table)+' (_primecare_import_row bigint PRIMARY KEY,'+','.join(quote(c['name'])+' '+t for c,t in zip(columns,types))+')')
            for ordinal, row in enumerate(data):
                values=[Jsonb({'t':'null','v':None}) if t=='jsonb' else v for v,t in zip(row,types)]
                admin.execute('INSERT INTO '+self.table(table)+' VALUES ('+','.join(['%s']*(len(row)+1))+')',[ordinal,*values])
        admin.execute('CREATE TABLE '+self.table('source_manifest')+' (manifest_sha256 text,manifest jsonb)')
        admin.execute('INSERT INTO '+self.table('source_manifest')+' VALUES (%s,%s)',(pin['manifestSha256'],Jsonb(manifest)))
        self.db = self.open_store()
        self.addCleanup(lambda: self.db.__exit__(Exception, None, None) if not self.db.db.closed else None)

    def table(self, name):
        return quote(self.schema)+'.'+quote('govt_'+name)

    def open_store(self):
        return ProductionWorkflowStore(_test_connection=psycopg.connect(URL))

    def test_resolution_rejects_foreign_missing_duplicate_unsuccessful_and_unproved_references(self):
        issue_id=self.failed_issue()
        resolution=self.resolution_result(issue_id)
        columns=[c['name'] for c in self.db.tables['virtual_workflow_definitions']['columns']]
        self.db.db.execute('INSERT INTO '+self.table('virtual_workflow_definitions')+' SELECT 1,'+','.join("'synthetic.other'" if c=='flow_id' else quote(c) for c in columns)+' FROM '+self.table('virtual_workflow_definitions')+' WHERE flow_id=%s',(self.plan['id'],))
        for flow_id, changed in [('synthetic.other', resolution),
            (self.plan['id'],{**resolution,'resolves_issue_ids':[999]}),
            (self.plan['id'],{**resolution,'resolves_issue_ids':[issue_id,issue_id]}),
            (self.plan['id'],{**resolution,'resolution_note':''}),
            (self.plan['id'],{**resolution,'test_status':'not_run'}),
            (self.plan['id'],{**resolution,'evidence':[]})]:
            with self.assertRaises(ValueError):record_attempt(self.db,flow_id,changed,self.root)
        record_attempt(self.db,self.plan['id'],resolution,self.root)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_issue_resolutions').fetchone()[0],1)

    def test_partial_insert_failure_rolls_back_attempt_and_evidence(self):
        self.db.db.execute('CREATE FUNCTION '+quote(self.schema)+".reject_fixture_evidence() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Synthetic evidence insert failure'; END $$")
        self.db.db.execute('CREATE TRIGGER reject_fixture_evidence BEFORE INSERT ON '+self.table('virtual_workflow_evidence')+' FOR EACH ROW EXECUTE FUNCTION '+quote(self.schema)+'.reject_fixture_evidence()')
        with self.assertRaises(Exception):record_attempt(self.db,self.plan['id'],self.scoped,self.root)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0],0)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_evidence').fetchone()[0],0)

    def test_statement_and_schema_guard(self):
        for query in ['DELETE FROM virtual_workflow_attempts', 'UPDATE users SET roles=?', 'DROP TABLE virtual_workflow_attempts', 'SELECT * FROM public.users']:
            with self.assertRaises(Exception):
                self.db.execute(query, ('bad',) if '?' in query else ())
        self.db.db.rollback()

    def test_transaction_rollback_preserves_prior_state(self):
        before=self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0]
        record_attempt(self.db, self.plan['id'], self.scoped, self.root)
        self.db.db.rollback()
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0],before)

    def test_snapshot_roundtrip_and_missing_default_preservation(self):
        record_attempt(self.db,self.plan['id'],self.scoped,self.root)
        export_progress(self.db,self.root)
        self.assertTrue(self.db.execute('SELECT next_action FROM virtual_workflow_checkpoints').fetchone()[0])
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_flow_catalog_snapshots').fetchone()[0],1)
        self.assertIsNotNone(self.db.execute('SELECT created_at FROM virtual_workflow_attempts').fetchone()[0])

    def test_native_concurrent_attempts_keep_unique_ids_and_history(self):
        self.db.db.commit()
        def record(_):
            with self.open_store() as db:
                return record_attempt(db,self.plan['id'],self.scoped,self.root)['attempt_id']
        with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
            ids=list(pool.map(record,range(2)))
        self.assertEqual(len(set(ids)),2)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_attempts').fetchone()[0],2)
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM virtual_workflow_checkpoints').fetchone()[0],1)


class ConfigurationTests(unittest.TestCase):
    def test_no_implicit_production_write_or_fixture_fallback(self):
        with patch.dict(os.environ,{},clear=True):
            with self.assertRaisesRegex(Exception,'GOVERNANCE_WORKFLOW_WRITES'):
                ProductionWorkflowStore()
        with patch.dict(os.environ,{'GOVERNANCE_WORKFLOW_WRITES':'1'},clear=True):
            with self.assertRaisesRegex(Exception,'target'):
                ProductionWorkflowStore()

# Reuse the unchanged acceptance validator cases against the native store.
for name in ('evidence', 'full_proof', 'failed_issue', 'resolution_result',
             'test_scoped_pass_records_resume_evidence_but_never_completes',
             'test_failure_requires_issue_and_preserves_exact_reproduction',
             'test_unknown_flow_supporting_guide_and_invalid_status_rejected',
             'test_blocked_and_missing_need_exact_explanation_not_review',
             'test_generic_pass_or_seven_gates_without_receipt_cannot_verify',
             'test_all_current_reviewed_criteria_and_receipts_required',
             'test_omitted_acceptance_result_rejected_even_if_rehashed',
             'test_unreviewed_criterion_and_missing_video_cannot_be_promoted',
             'test_source_change_invalidates_completion_and_preserves_history',
             'test_missing_stale_unsafe_evidence_rejected_without_partial_attempt',
             'test_successful_rerun_links_resolution_and_retains_original_failure',
             'test_unrelated_pass_unbound_receipt_and_conflicting_failure_cannot_close_issue',
             'test_recheck_reuses_original_open_issue_without_duplicate_rows_or_closure',
             'test_evidence_links_allow_web_and_application_urls_and_reject_executable_schemes'):
    setattr(NativeStoreTests, name, getattr(fixtures.ExecutionTests, name))

if __name__=='__main__':
    unittest.main()
