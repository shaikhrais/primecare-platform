"""Regression coverage for bulk drafting without changing runtime API readiness."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

HERE = Path(__file__).resolve().parent


def load(name, filename):
    spec = importlib.util.spec_from_file_location(name, HERE / filename)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


factory = load('contract_factory', 'primecare-contract-factory.py')
plan_tests = load('contract_plan_fixtures', 'test-workflow-contract-plan.py')


class FactoryTests(unittest.TestCase):
    def setUp(self):
        self.checklist, self.manifest = plan_tests.fixtures()

    def test_generates_exact_unresolved_coverage_without_mutating_input(self):
        before = copy.deepcopy((self.checklist, self.manifest))
        output = factory.build(self.checklist, self.manifest)
        self.assertEqual(set(output), {
            'bundle.json', 'openapi-drafts.json',
            'decision-index.json', 'execution-summary.json',
        })
        self.assertEqual((self.checklist, self.manifest), before)
        self.assertEqual(output, factory.build(self.checklist, self.manifest))

    def draft(self):
        return copy.deepcopy(factory.build(self.checklist, self.manifest)['bundle.json']['contracts'][0])

    def explicit_contract(self):
        contract = self.draft()
        reference = {'path': 'source.txt', 'sha256': self.manifest['sourceHashes']['source.txt'], 'locator': 'approved test fixture policy section'}
        for name in factory.SLOTS:
            contract['slots'][name] = {'value': 'fixture policy', 'sourceReferences': [copy.deepcopy(reference)]}
        contract['slots']['request']['value'] = {'parameters': [], 'body': {'mode': 'none'}}
        contract['slots']['response']['value'] = {'200': {'description': 'Fixture result', 'schema': {'type': 'object'}}}
        contract['slots']['authorization']['value'] = {
            'actor': 'fixture actor', 'tenant': 'fixture tenant',
            'ownership': 'fixture ownership', 'delegation': 'fixture delegation',
            'state': 'fixture state',
        }
        values = {
            'validation': {'unknownFields': 'reject', 'bounds': 'fixture approved bounds'},
            'authentication': {'mechanism': 'fixture token', 'principal': 'fixture user'},
            'permission': {'governanceKey': 'fixture.read', 'scope': 'fixture owner'},
            'rateLimits': {'scope': 'principal', 'limit': 5, 'window': 'minute', 'rejection': '429'},
            'audit': {'events': 'fixture.read', 'actorAttribution': 'principal', 'retention': 'fixture policy', 'redaction': 'fixture policy'},
            'errors': {'statusCodes': [401, 403], 'disclosure': 'fixture non-disclosure'},
            'version': {'identifier': 'v1', 'compatibility': 'fixture policy'},
            'workflow': {'preconditions': 'fixture active', 'transitions': 'fixture no transition', 'sideEffects': 'fixture read audit'},
            'persistence': {'mappings': 'fixture table', 'transaction': 'fixture snapshot', 'invariants': 'fixture tenant'},
            'idempotency': {'duplicate': 'fixture same read', 'retry': 'fixture safe', 'concurrency': 'fixture snapshot', 'replay': 'fixture read'},
            'tests': {'positive': 'owner', 'negative': 'non-owner', 'tenantIsolation': 'other tenant', 'ownership': 'other owner', 'state': 'inactive'},
            'clientBinding': {'callers': ['fixture caller'], 'method': contract['api'].split(' ', 1)[0], 'route': contract['api'].split(' ', 1)[1], 'responseMapping': 'fixture DTO'},
            'examples': {'request': 'fixture bodyless request', 'response': 'fixture object'},
        }
        for name, value in values.items():
            contract['slots'][name]['value'] = value
        return contract

    def explicit_input(self, contract):
        return {'version': 1, 'noActivation': True, 'contracts': [contract]}

    def test_every_unresolved_identity_is_preserved_and_unknown_policy_stays_unknown(self):
        output = factory.build(self.checklist, self.manifest)
        contracts = output['bundle.json']['contracts']
        expected = {o['api']: o for o in self.checklist['operations'] if o['stage'] in ('blocked', 'needs_contract_and_verification')}
        self.assertEqual(len(contracts), len(expected))
        self.assertEqual({c['api'] for c in contracts}, set(expected))
        for contract in contracts:
            self.assertEqual(contract['declarationIds'], expected[contract['api']]['declarationIds'])
            self.assertEqual(contract['stage'], expected[contract['api']]['stage'])
            self.assertIs(contract['activationEligible'], False)
            self.assertIs(contract['noActivation'], True)
            self.assertEqual(contract['implementationCredits'], 0)
            self.assertEqual(contract['retirementCredits'], 0)
            self.assertEqual(set(contract['slots']), set(factory.SLOTS))
            self.assertTrue(all(s['value'] is None and s['sourceReferences'] == [] for s in contract['slots'].values()))
        summary = output['execution-summary.json']
        self.assertEqual(summary['baselineStages'], self.checklist['summary']['stages'])
        for field in ('implementationCredits', 'retirementCredits', 'runtimeHandlersGenerated', 'databaseWrites', 'explicitStructuresCompiled'):
            self.assertEqual(summary[field], 0)
        self.assertEqual(summary['decisionSlotsRemaining'], len(expected) * len(factory.SLOTS))
        decision_keys = {(d['api'], d['slot']) for d in output['decision-index.json']['decisions']}
        self.assertEqual(decision_keys, {(api, slot) for api in expected for slot in factory.SLOTS})

    def test_explicit_complete_structure_compiles_but_earns_no_api_credit(self):
        contract = self.explicit_contract()
        output = factory.build(self.checklist, self.manifest, self.explicit_input(contract))
        summary = output['execution-summary.json']
        self.assertEqual(summary['explicitStructuresCompiled'], 1)
        self.assertEqual(summary['implementationCredits'], 0)
        self.assertEqual(summary['runtimeHandlersGenerated'], 0)
        compiled = next(c for c in output['bundle.json']['contracts'] if c['api'] == contract['api'])
        self.assertEqual(compiled['structureStatus'], 'explicit_structure_compiled_unimplemented')
        self.assertIs(compiled['activationEligible'], False)
        method, route = contract['api'].split(' ', 1)
        operation = output['openapi-drafts.json']['paths'][route][method.lower()]
        self.assertEqual(operation['responses']['200']['content']['application/json']['schema'], {'type': 'object'})
        self.assertNotIn('requestBody', operation)
        self.assertEqual(compiled['slots'], contract['slots'])

    def test_incomplete_authority_unsafe_credits_and_unknown_operations_are_rejected(self):
        mutations = [
            lambda c: c.update(api='GET /unknown'),
            lambda c: c.update(api='DELETE /v1/client/b'),
            lambda c: c.update(declarationIds=[999]),
            lambda c: c.update(activationEligible=True),
            lambda c: c.update(noActivation=False),
            lambda c: c.update(implementationCredits=1),
            lambda c: c.update(retirementCredits=1),
            lambda c: c.update(approved=True),
            lambda c: c.update(implemented=True),
            lambda c: c.update(productionReady=True),
            lambda c: c.update(deployed=True),
            lambda c: c['slots']['clientBinding']['value'].update(method='DELETE'),
            lambda c: c['slots']['clientBinding']['value'].update(route='/unknown'),
            lambda c: c['slots']['rateLimits']['value'].update(limit=True),
            lambda c: c['slots']['rateLimits']['value'].update(limit=0),
            lambda c: c['slots'].pop('permission'),
            lambda c: c['slots']['authorization'].update(value={'actor': 'any role'}),
            lambda c: c['slots']['permission'].update(value=None),
            lambda c: c['slots']['permission'].update(sourceReferences=[]),
            lambda c: c['slots']['permission']['sourceReferences'][0].update(path='unknown.txt'),
            lambda c: c['slots']['permission']['sourceReferences'][0].update(sha256='0' * 64),
            lambda c: c['slots']['permission']['sourceReferences'][0].update(locator=''),
            lambda c: c['slots']['request'].update(value={'parameters': [], 'body': {'mode': 'implicit'}}),
            lambda c: c['slots']['response'].update(value={'200': {'description': 'No schema'}}),
        ]
        for mutate in mutations:
            contract = self.explicit_contract()
            mutate(contract)
            with self.subTest(mutation=mutate), self.assertRaises(ValueError):
                factory.build(self.checklist, self.manifest, self.explicit_input(contract))

    def test_invalid_parameters_and_schema_cannot_compile_into_openapi(self):
        invalid_requests = [
            {'parameters': [{'name': 'item', 'in': 'path', 'required': False, 'schema': {'type': 'string'}}], 'body': {'mode': 'none'}},
            {'parameters': [{'name': 'q', 'in': 'query', 'required': False, 'schema': {'type': 'string'}}] * 2, 'body': {'mode': 'none'}},
            {'parameters': [{'name': 'q', 'in': 'query', 'required': False, 'schema': {'type': 'string', 'minLenght': 1}}], 'body': {'mode': 'none'}},
            {'parameters': [], 'body': {'mode': 'json', 'required': True, 'schema': {'$ref': '#/$defs/missing'}}},
            {'parameters': [], 'body': {'mode': 'json', 'required': True, 'schema': {'type': 'string', 'minLength': 5, 'maxLength': 1}}},
            {'parameters': [], 'body': {'mode': 'json', 'required': True, 'schema': {'type': 'number', 'minimum': 'zero'}}},
        ]
        for request in invalid_requests:
            contract = self.explicit_contract()
            contract['slots']['request']['value'] = request
            with self.subTest(request=request), self.assertRaises(ValueError):
                factory.build(self.checklist, self.manifest, self.explicit_input(contract))

    def test_explicit_input_cannot_claim_approval_or_credit(self):
        for field, value in [('approved', True), ('implementationCredits', 1), ('retirementCredits', 1), ('activationEligible', True)]:
            explicit = self.explicit_input(self.explicit_contract())
            explicit[field] = value
            with self.subTest(field=field), self.assertRaises(ValueError):
                factory.build(self.checklist, self.manifest, explicit)

    def test_normalized_openapi_paths_refuse_collisions_without_retiring_identities(self):
        checklist, manifest = copy.deepcopy(self.checklist), copy.deepcopy(self.manifest)
        replacements = {'POST /v1/client/a': 'GET /v1/client/:id', 'GET /v1/client/b': 'GET /v1/client/{id}'}
        for operation in checklist['operations']:
            if operation['api'] in replacements:
                operation['api'] = replacements[operation['api']]
                operation['method'], operation['route'] = operation['api'].split(' ', 1)
        for review in manifest['reviews']:
            for operation in review['operations']:
                operation['api'] = replacements.get(operation['api'], operation['api'])
        for record in manifest['provenance']:
            record['api'] = replacements.get(record['api'], record['api'])
        with self.assertRaisesRegex(ValueError, 'collision'):
            factory.build(checklist, manifest)

    def test_duplicate_explicit_contract_does_not_inflate_compilation_count(self):
        contract = self.explicit_contract()
        explicit = self.explicit_input(contract)
        explicit['contracts'].append(copy.deepcopy(contract))
        with self.assertRaises(ValueError):
            factory.build(self.checklist, self.manifest, explicit)

    def test_review_order_does_not_change_bulk_artifacts(self):
        first = factory.build(self.checklist, self.manifest)
        reordered = copy.deepcopy(self.manifest)
        reordered['reviews'].reverse()
        second = factory.build(self.checklist, reordered)
        first_hashes = first['bundle.json'].pop('inputHashes')
        second_hashes = second['bundle.json'].pop('inputHashes')
        self.assertNotEqual(first_hashes['reviews'], second_hashes['reviews'])
        self.assertEqual(first_hashes['checklist'], second_hashes['checklist'])
        for artifact in ('execution-summary.json', 'decision-index.json'):
            self.assertEqual(first[artifact].pop('inputHashes'), first_hashes)
            self.assertEqual(second[artifact].pop('inputHashes'), second_hashes)
        self.assertEqual(first, second)

    def test_source_hash_validation_rejects_missing_changed_and_escaping_evidence(self):
        with tempfile.TemporaryDirectory() as directory, tempfile.TemporaryDirectory() as outside:
            root = Path(directory)
            source = root / 'source.txt'
            source.write_bytes(b'evidence')
            factory.build(self.checklist, self.manifest, validate_sources=root)
            source.write_bytes(b'drift')
            with self.assertRaises(ValueError):
                factory.build(self.checklist, self.manifest, validate_sources=root)
            source.unlink()
            with self.assertRaises(ValueError):
                factory.build(self.checklist, self.manifest, validate_sources=root)
            target = Path(outside) / 'source.txt'
            target.write_bytes(b'evidence')
            source.symlink_to(target)
            with self.assertRaises(ValueError):
                factory.build(self.checklist, self.manifest, validate_sources=root)

    def test_source_identity_and_authority_drift_are_rejected(self):
        mutations = [
            lambda c, m: c['operations'][0].update(method='GET'),
            lambda c, m: c['operations'][1].update(declarationIds=[1]),
            lambda c, m: m['reviews'][0]['operations'][0].update(api='POST /unknown'),
            lambda c, m: m['reviews'][0]['operations'][0].update(declarationIds=[999]),
            lambda c, m: m['reviews'][0].update(activationEligible=True),
            lambda c, m: m['reviews'][0].update(authorityDisposition='authorized'),
            lambda c, m: m['reviews'][0].update(implementationCredits=1),
            lambda c, m: m.update(noActivation=False),
            lambda c, m: m['sourceHashes'].update({'../secret': '0' * 64}),
            lambda c, m: m['sourceHashes'].update({'source.txt': 'not-a-hash'}),
        ]
        for mutate in mutations:
            c, m = copy.deepcopy(self.checklist), copy.deepcopy(self.manifest)
            mutate(c, m)
            with self.subTest(mutation=mutate), self.assertRaises(ValueError):
                factory.build(c, m)

    def make_cli_repository(self, root):
        (root / 'scripts').mkdir()
        (root / 'docs/api').mkdir(parents=True)
        for filename in ('primecare-contract-factory.py', 'generate-workflow-contract-plan.py'):
            (root / 'scripts' / filename).write_bytes((HERE / filename).read_bytes())
        (root / 'source.txt').write_bytes(b'evidence')
        (root / 'docs/api/api-delivery-checklist.json').write_text(json.dumps(self.checklist))
        (root / 'docs/api/workflow-contract-reviews.json').write_text(json.dumps(self.manifest))
        return root / 'scripts/primecare-contract-factory.py'

    def run_cli(self, script, *arguments):
        return subprocess.run([sys.executable, str(script), *arguments],
                              capture_output=True, text=True, timeout=30)

    def test_check_refuses_stale_and_missing_outputs_without_writing(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            script = self.make_cli_repository(root)
            result = self.run_cli(script)
            self.assertEqual(result.returncode, 0, result.stderr)
            out = root / 'docs/api/contract-factory'
            pristine = {p.name: p.read_bytes() for p in out.glob('*.json')}
            self.assertEqual(len(pristine), 4)
            result = self.run_cli(script, '--check')
            self.assertEqual(result.returncode, 0, result.stderr)
            bundle = out / 'bundle.json'
            bundle.write_text('stale')
            self.assertNotEqual(self.run_cli(script, '--check').returncode, 0)
            self.assertEqual(bundle.read_text(), 'stale')
            for name, content in pristine.items():
                if name != 'bundle.json':
                    self.assertEqual((out / name).read_bytes(), content)
            bundle.unlink()
            self.assertNotEqual(self.run_cli(script, '--check').returncode, 0)
            self.assertFalse(bundle.exists())

    def test_cli_rejects_source_drift_without_rewriting_existing_outputs(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            script = self.make_cli_repository(root)
            result = self.run_cli(script)
            self.assertEqual(result.returncode, 0, result.stderr)
            out = root / 'docs/api/contract-factory'
            pristine = {p.name: p.read_bytes() for p in out.glob('*.json')}
            (root / 'source.txt').write_bytes(b'changed after review')
            for arguments in ((), ('--check',)):
                self.assertNotEqual(self.run_cli(script, *arguments).returncode, 0)
                self.assertEqual({p.name: p.read_bytes() for p in out.glob('*.json')}, pristine)

    def test_cli_rejects_symlink_file_targets_without_touching_outside_file(self):
        with tempfile.TemporaryDirectory() as directory, tempfile.TemporaryDirectory() as outside:
            root = Path(directory)
            script = self.make_cli_repository(root)
            out = root / 'docs/api/contract-factory'
            out.mkdir()
            target = Path(outside) / 'protected.json'
            target.write_text('protected original')
            (out / 'bundle.json').symlink_to(target)
            self.assertNotEqual(self.run_cli(script).returncode, 0)
            self.assertEqual(target.read_text(), 'protected original')

    def test_cli_rejects_paths_outside_repo_before_writing(self):
        with tempfile.TemporaryDirectory() as directory, tempfile.TemporaryDirectory() as outside:
            root = Path(directory)
            script = self.make_cli_repository(root)
            (root / 'escape').symlink_to(outside, target_is_directory=True)
            for output in ('../outside', outside, 'escape/new'):
                with self.subTest(output=output):
                    result = self.run_cli(script, '--output-dir', output)
                    self.assertNotEqual(result.returncode, 0)
            self.assertEqual(list(Path(outside).iterdir()), [])


if __name__ == '__main__':
    unittest.main()
