"""Bulk code structures retain exact identity and cannot activate draft workflows."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]

def load(name, filename):
    spec = importlib.util.spec_from_file_location(name, ROOT / 'scripts' / filename)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

codegen = load('bulk_codegen', 'primecare-bulk-codegen.py')
fixtures = load('plan_fixtures', 'test-workflow-contract-plan.py')

class BulkCodegenTests(unittest.TestCase):
    def setUp(self):
        self.checklist, self.manifest = fixtures.fixtures()

    def test_deterministic_outputs_preserve_inputs_and_exact_request_identity(self):
        before = copy.deepcopy((self.checklist, self.manifest))
        requests = codegen.expected_requests(self.checklist, self.manifest)
        outputs = codegen.build(self.checklist, self.manifest, requests)
        self.assertEqual(outputs, codegen.build(self.checklist, self.manifest))
        self.assertEqual(before, (self.checklist, self.manifest))
        self.assertEqual(len(outputs), 5)
        self.assertTrue(all(isinstance(v, str) for v in outputs.values()))
        self.assertTrue(all(not Path(p).is_absolute() and '..' not in Path(p).parts for p in outputs))

    def test_any_request_document_drift_refused(self):
        original = codegen.expected_requests(self.checklist, self.manifest)
        def leaves(value, path=()):
            if isinstance(value, dict):
                for key, child in value.items(): yield from leaves(child, path + (key,))
            elif isinstance(value, list):
                for index, child in enumerate(value): yield from leaves(child, path + (index,))
            else: yield path, value
        # Mutate every scalar, including exact method, path, IDs, source hashes,
        # family, placement, and any nonactivation flags.
        for path, value in leaves(original):
            changed = copy.deepcopy(original)
            parent = changed
            for key in path[:-1]: parent = parent[key]
            parent[path[-1]] = (not value if isinstance(value, bool) else
                                value + 1 if isinstance(value, int) else 'tampered')
            with self.subTest(path=path), self.assertRaises(ValueError):
                codegen.build(self.checklist, self.manifest, changed)
        changed = copy.deepcopy(original)
        changed['approval'] = 'approved'
        with self.assertRaises(ValueError): codegen.build(self.checklist, self.manifest, changed)

    def test_sources_verified_before_generation_and_symlink_escape_refused(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'source.txt').write_bytes(b'evidence')
            # The generator may also bind its own source as an input.
            (root / 'scripts').mkdir()
            for filename in ('primecare-bulk-codegen.py', 'primecare-contract-factory.py',
                             'generate-workflow-contract-plan.py'):
                (root / 'scripts' / filename).write_bytes((ROOT / 'scripts' / filename).read_bytes())
            codegen.build(self.checklist, self.manifest, validate_sources=root)
            (root / 'source.txt').write_bytes(b'changed policy')
            with self.assertRaises(ValueError):
                codegen.build(self.checklist, self.manifest, validate_sources=root)
            (root / 'source.txt').unlink()
            with tempfile.TemporaryDirectory() as outside:
                target = Path(outside) / 'source.txt'; target.write_bytes(b'evidence')
                (root / 'source.txt').symlink_to(target)
                with self.assertRaises(ValueError):
                    codegen.build(self.checklist, self.manifest, validate_sources=root)

    def test_output_safety_refuses_unknown_files_and_escape_before_writes(self):
        outputs = codegen.build(self.checklist, self.manifest)
        with tempfile.TemporaryDirectory() as directory, tempfile.TemporaryDirectory() as outside:
            root = Path(directory)
            codegen.preflight(root, outputs)
            target = root / codegen.TARGETS[0]
            target.parent.mkdir(parents=True)
            target.write_text('handwritten source must survive')
            with self.assertRaises(ValueError): codegen.preflight(root, outputs)
            self.assertEqual(target.read_text(), 'handwritten source must survive')
            target.unlink(); target.symlink_to(Path(outside) / 'target.ts')
            with self.assertRaises(ValueError): codegen.preflight(root, outputs)

    def test_typescript_runtime_guards_and_nested_immutability(self):
        outputs = codegen.build(self.checklist, self.manifest)
        with tempfile.TemporaryDirectory() as directory:
            module = Path(directory) / 'contracts.ts'
            module.write_text(outputs[codegen.TARGETS[0]])
            runner = Path(directory) / 'runtime.mjs'
            runner.write_text("""import assert from 'node:assert/strict';
import {unimplementedWorkflowContracts as rows, requireExecutableWorkflow, MissingWorkflowContractError} from './contracts.ts';
assert.equal(rows.length, 2);
assert.equal(new Set(rows.map(row => row.api)).size, 2);
assert.ok(Object.isFrozen(rows));
for (const row of rows) {
  assert.ok(Object.isFrozen(row));
  assert.ok(Object.isFrozen(row.declarationIds));
  assert.ok(Object.isFrozen(row.missingSlots));
  assert.equal(row.noActivation, true);
  assert.equal(row.readiness, false);
  assert.throws(() => {row.readiness = true;}, TypeError);
  assert.throws(() => {row.declarationIds.push(999);}, TypeError);
  assert.throws(() => {row.missingSlots.length = 0;}, TypeError);
  assert.throws(() => requireExecutableWorkflow(row.method, row.path), MissingWorkflowContractError);
}
assert.throws(() => requireExecutableWorkflow('GET', '/not-a-workflow'), /Unknown workflow/);
assert.throws(() => rows.push(rows[0]), TypeError);
""")
            result = subprocess.run(['node', '--experimental-strip-types', str(runner)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_cli_check_refuses_stale_files_without_rewriting(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'scripts').mkdir(); (root / 'docs/api').mkdir(parents=True)
            for filename in ('primecare-bulk-codegen.py', 'primecare-contract-factory.py', 'generate-workflow-contract-plan.py'):
                (root / 'scripts' / filename).write_bytes((ROOT / 'scripts' / filename).read_bytes())
            (root / 'source.txt').write_bytes(b'evidence')
            (root / 'docs/api/api-delivery-checklist.json').write_text(json.dumps(self.checklist))
            (root / 'docs/api/workflow-contract-reviews.json').write_text(json.dumps(self.manifest))
            command = [sys.executable, str(root / 'scripts/primecare-bulk-codegen.py')]
            generated = subprocess.run(command, capture_output=True, text=True)
            self.assertEqual(generated.returncode, 0, generated.stderr)
            self.assertEqual(subprocess.run(command + ['--check'], capture_output=True).returncode, 0)
            target = root / codegen.TARGETS[0]
            stale = target.read_text() + '// stale output\n'
            target.write_text(stale)
            self.assertNotEqual(subprocess.run(command + ['--check'], capture_output=True).returncode, 0)
            self.assertEqual(target.read_text(), stale)

    def test_real_bulk_coverage_is_1063_unique_operations(self):
        checklist = json.loads((ROOT/'docs/api/api-delivery-checklist.json').read_text())
        manifest = json.loads((ROOT/'docs/api/workflow-contract-reviews.json').read_text())
        requests = codegen.expected_requests(checklist, manifest, validate_sources=ROOT)
        output = codegen.build(checklist, manifest, requests, validate_sources=ROOT)
        self.assertEqual(sum(op['stage'] in ('needs_contract_and_verification', 'blocked')
                             for op in checklist['operations']), 1063)
        self.assertEqual(len(output), 5)
        # Repeated language copies never change the authoritative baseline.
        self.assertEqual(checklist['summary']['uniqueOperations'], 1415)

if __name__ == '__main__': unittest.main()
