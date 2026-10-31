"""Synthetic metadata model tests; never connect to or emulate production business data."""
import copy
import json
import os
from pathlib import Path
import sys
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parent))
import theme_adoption_registration as target

C = json.loads(target.FILE.read_text())


class Rows:
    def __init__(self, values): self.values = values
    def fetchall(self): return self.values
    def __iter__(self): return iter(self.values)


class Model:
    def __init__(self):
        self.pin = {'themeAdoptionWriter': target.expected_scope()}
        h = C['registrationTarget']
        self.hosts = [(91, h['route'], h['sourceFile'], 1)]
        self.grants = [(7,)]
        self.components = {code: [(1,)] for code in C['requiredExistingComponents']}
        self.languages = [('en', 1), ('fr', 2), ('es', 3)]
        self.records = {table: {} for table in target.TABLES}
        self.calls = []

    def execute(self, sql, args=()):
        if sql.startswith('SELECT id,route_path,actual_file_path,active FROM screens'): return Rows(self.hosts)
        if sql.startswith('SELECT role_id FROM role_screen_permissions'): return Rows(self.grants)
        if sql.startswith('SELECT active FROM primecare_ui_component_registry'): return Rows(self.components.get(args[0], []))
        if sql.startswith('SELECT language_code,language_id FROM languages'): return Rows(self.languages)
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
        self.environment = patch.dict(os.environ, {'GOVERNANCE_THEME_ADOPTION_WRITES': '1'})
        self.environment.start()
    def tearDown(self): self.environment.stop()

    def test_exact_optional_metadata_is_idempotent(self):
        model = Model()
        first = target.register(model)
        self.assertEqual(len(model.calls), 210)
        self.assertEqual(target.register(model), first)
        self.assertEqual(len(model.calls), 210)
        self.assertEqual(set(t for t, _, _ in model.calls), set(target.TABLES))
        self.assertEqual(first['roleGrants'], 0)
        self.assertFalse(first['runtimeActivated'])
        self.assertFalse(first['reviewApproved'])
        self.assertEqual(first['translationCount'], 120)
        for table, key, values in model.calls:
            if table == 'screen_required_elements': self.assertEqual(values['required'], 0)
            if table == 'screen_components': self.assertEqual(values['implementation_status'], 'registered-unimplemented')

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
        for mutate in [lambda m: setattr(m, 'hosts', []), lambda m: setattr(m, 'hosts', m.hosts * 2), lambda m: setattr(m, 'hosts', [(91, '/wrong', C['registrationTarget']['sourceFile'], 1)]), lambda m: setattr(m, 'hosts', [(91, C['registrationTarget']['route'], 'wrong.ts', 1)]), lambda m: setattr(m, 'hosts', [(91, C['registrationTarget']['route'], C['registrationTarget']['sourceFile'], 0)]), lambda m: setattr(m, 'grants', [])]:
            model = Model(); mutate(model)
            with self.assertRaises(target.GovernanceReadError): target.register(model)
            self.assertEqual(model.calls, [])

    def test_component_or_language_gap_stops_before_metadata_writes(self):
        for mutate in [lambda m: m.components.clear(), lambda m: m.components.update({C['requiredExistingComponents'][0]: [(0,)]}), lambda m: setattr(m, 'languages', [('en', 1)])]:
            model = Model(); mutate(model)
            with self.assertRaises(target.GovernanceReadError): target.register(model)
            self.assertEqual(model.calls, [])

    def test_exact_pin_opt_in_and_contract_are_required(self):
        model = Model(); model.pin['themeAdoptionWriter']['roleGrants'] = True
        with self.assertRaises(target.GovernanceReadError): target.register(model)
        with patch.dict(os.environ, {'GOVERNANCE_THEME_ADOPTION_WRITES': '0'}):
            with self.assertRaises(target.GovernanceReadError): target.register(Model())
        changed = copy.deepcopy(C); changed['resources']['themeWorkspace.title']['en'] = 'Unpinned'
        with self.assertRaises(target.GovernanceReadError): target.register(Model(), changed)


if __name__ == '__main__': unittest.main()
