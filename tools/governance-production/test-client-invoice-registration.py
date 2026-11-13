"""Synthetic metadata model tests; never connect to or emulate production business data."""
import copy
import json
import os
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parent))
import client_invoice_registration as target

C = json.loads(target.FILE.read_text())


class Rows:
    def __init__(self, values): self.values = values
    def fetchall(self): return self.values
    def __iter__(self): return iter(self.values)


class Model:
    def __init__(self):
        self.pin = {'clientInvoicesWriter': target.expected_scope()}
        h = C['registrationTarget']
        self.hosts = [(665, h['route'], h['sourceFile'], 1)]
        self.grants = [(13,)]
        self.components = {code: [(1,)] for code in C['requiredExistingComponents']}
        self.languages = [('en', 1), ('fr', 2), ('es', 3)]
        self.records = {table: {} for table in target.TABLES}
        self.calls = []
        self.api_present=True
        self.workflow_present=True

    def execute(self, sql, args=()):
        if sql.startswith('SELECT id,service_name,auth_required,permission_key FROM api_endpoints'):
            spec=next((s for s in C['requiredExistingApis'] if (s['path'],s['method'])==args),None)
            if spec is None:return Rows([])
            return Rows([(16432,spec['service'],1,spec['permission'])] if self.api_present else [])
        if sql.startswith('SELECT id FROM screen_api_links'): return Rows([(4330,)] if self.workflow_present else [])
        if sql.startswith('SELECT id,route_path,actual_file_path,active FROM screens'): return Rows(self.hosts)
        if sql.startswith('SELECT role_id FROM role_screen_permissions'): return Rows(self.grants)
        if sql.startswith('SELECT active FROM primecare_ui_component_registry'): return Rows(self.components.get(args[0], []))
        if sql.startswith('SELECT language_code,language_id FROM languages'): return Rows(self.languages)
        if sql.startswith('SELECT implementation_status FROM screen_components'):
            return Rows([(row['implementation_status'],) for row in self.records['screen_components'].values() if row['screen_id'] == args[0] and row['component_code'] == args[1]])
        if sql.startswith('SELECT translated_text,reviewed,approved FROM language_resource_values'):
            rows = [row for row in self.records['language_resource_values'].values() if row['resource_id'] == args[0] and row['language_id'] == args[1]]
            return Rows([(r['translated_text'], r['reviewed'], r['approved']) for r in rows])
        raise AssertionError('Unexpected test-model read: ' + sql)


    def ensure(self, table, key, values):
        if table not in target.TABLES: raise AssertionError('Unscoped write')
        identity = tuple(sorted(key.items()))
        old = self.records[table].get(identity)
        if old:
            if any(old[k] != v for k, v in values.items()): raise target.GovernanceReadError('Metadata differs')
            return old['model_id']
        self.calls.append((table, copy.deepcopy(key), copy.deepcopy(values)))
        row = {**key, **values, 'model_id': len(self.records[table]) + 1}
        self.records[table][identity] = row
        return row['model_id']


class RegistrationTests(unittest.TestCase):
    def setUp(self):
        self.environment = patch.dict(os.environ, {'GOVERNANCE_CLIENT_INVOICES_WRITES': '1'})
        self.environment.start()
    def tearDown(self): self.environment.stop()

    def test_exact_optional_metadata_is_idempotent(self):
        model = Model()
        first = target.register(model)
        self.assertEqual(len(model.calls), 2*len(C['controls'])+4*len(C['resources'])+len(C['newComponents']))
        self.assertEqual(target.register(model), first)
        self.assertEqual(len(model.calls), 2*len(C['controls'])+4*len(C['resources'])+len(C['newComponents']))
        self.assertEqual(set(t for t, _, _ in model.calls), set(target.TABLES)-{'primecare_ui_component_registry'})
        self.assertEqual(first['roleGrants'], 0)
        self.assertFalse(first['runtimeActivated'])
        self.assertFalse(first['reviewApproved'])
        self.assertEqual(first['translationCount'], len(C['resources'])*3)
        for table, key, values in model.calls:
            if table == 'screen_required_elements': self.assertEqual(values['required'], 0)
            if table == 'screen_components': self.assertEqual(values['implementation_status'], 'registered-unimplemented')


    def test_registration_preserves_implemented_progress_and_rejects_unknown_status(self):
        model = Model(); target.register(model)
        row = next(iter(model.records['screen_components'].values()))
        row['implementation_status'] = 'implemented-unverified'
        result = target.register(model)
        self.assertEqual(result['implementationStatuses'][row['data_cy']], 'implemented-unverified')
        row['implementation_status'] = 'production-ready'
        with self.assertRaises(target.GovernanceReadError): target.register(model)

    def test_conflicting_reviewed_translation_is_never_overwritten(self):
        model = Model(); target.register(model)
        row = next(iter(model.records['language_resource_values'].values()))
        row.update(translated_text='Reviewed pre-existing text', reviewed=1, approved=1)
        before = copy.deepcopy(row)
        with self.assertRaises(target.GovernanceReadError): target.register(model)
        self.assertEqual(row, before)

    def test_matching_review_flags_are_preserved(self):
        model = Model(); first = target.register(model)
        row = next(iter(model.records['language_resource_values'].values()))
        row.update(reviewed=1, approved=1)
        self.assertEqual(target.register(model), first)
        self.assertEqual((row['reviewed'], row['approved']), (1, 1))

    def test_host_route_source_identity_and_view_grants_are_required(self):
        for mutate in [lambda m: setattr(m, 'hosts', []), lambda m: setattr(m, 'hosts', m.hosts * 2), lambda m: setattr(m, 'hosts', [(665, '/wrong', C['registrationTarget']['sourceFile'], 1)]), lambda m: setattr(m, 'hosts', [(665, C['registrationTarget']['route'], 'wrong.ts', 1)]), lambda m: setattr(m, 'hosts', [(665, C['registrationTarget']['route'], C['registrationTarget']['sourceFile'], 0)]), lambda m: setattr(m, 'grants', [])]:
            model = Model(); mutate(model)
            with self.assertRaises(target.GovernanceReadError): target.register(model)
            self.assertEqual(model.calls, [])

    def test_component_or_language_gap_stops_before_metadata_writes(self):
        for mutate in [lambda m: m.components.clear(), lambda m: m.components.update({C['requiredExistingComponents'][0]: [(0,)]}), lambda m: setattr(m, 'languages', [('en', 1)])]:
            model = Model(); mutate(model)
            with self.assertRaises(target.GovernanceReadError): target.register(model)
            self.assertEqual(model.calls, [])

    def test_existing_api_and_workflow_are_required_before_any_write(self):
        for field in ['api_present','workflow_present']:
            model=Model();setattr(model,field,False)
            with self.assertRaises(target.GovernanceReadError):target.register(model)
            self.assertEqual(model.calls,[])

    def test_exact_pin_opt_in_and_contract_are_required(self):
        model = Model(); model.pin['clientInvoicesWriter']['roleGrants'] = True
        with self.assertRaises(target.GovernanceReadError): target.register(model)
        with patch.dict(os.environ, {'GOVERNANCE_CLIENT_INVOICES_WRITES': '0'}):
            with self.assertRaises(target.GovernanceReadError): target.register(Model())
        changed = copy.deepcopy(C); changed['resources']['clientInvoices.title']['en'] = 'Unpinned'
        with self.assertRaises(target.GovernanceReadError): target.register(Model(), changed)


if __name__ == '__main__': unittest.main()
