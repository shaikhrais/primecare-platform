"""Offline connection configuration coverage, with no SQL or network access."""
import importlib.util
import json
import os
from pathlib import Path
import sys
import tempfile
import types
import unittest
from unittest.mock import Mock, patch

ROOT = Path(__file__).resolve().parents[2]
URL = 'postgres://fixture:configuration-only@pooled.db.prisma.io/postgres'


class GovernanceReadError(RuntimeError):
    pass


class ConnectionReached(RuntimeError):
    pass


def load_module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class ProductionUrlConfiguration(unittest.TestCase):
    def setUp(self):
        # SQL compiler and driver are intentionally out of scope. A sentinel
        # stops both constructors at connect(), before any SQL can run.
        reader = types.ModuleType('production_reader')
        reader.Connection = object
        reader.GovernanceReadError = GovernanceReadError
        self.connect = Mock(side_effect=ConnectionReached('offline driver sentinel'))
        driver = types.ModuleType('psycopg')
        driver.connect = self.connect
        self.modules = patch.dict(sys.modules, {'production_reader': reader, 'psycopg': driver})
        self.modules.start()
        self.addCleanup(self.modules.stop)
        original_path = list(sys.path)
        self.addCleanup(lambda: sys.path.__setitem__(slice(None), original_path))
        self.workflow = load_module('production_store', ROOT / 'tools/workflow-verification/production_store.py')
        workflow_module = patch.dict(sys.modules, {'production_store': self.workflow})
        workflow_module.start()
        self.addCleanup(workflow_module.stop)
        self.metadata = load_module('metadata_store', ROOT / 'tools/governance-production/metadata_store.py')
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.expected = {'tables': ['language_resources'], 'optInVariable': 'TEST_METADATA_OPT_IN',
                         'schemaChanges': False, 'businessDataWrites': False,
                         'roleGrants': False, 'runtimeActivation': False}
        self.pin = Path(self.temp.name) / 'pin.json'
        self.pin.write_text(json.dumps({'testScope': self.expected}))
        self.metadata.PIN = self.pin
        self.ca = Path(self.temp.name) / 'fixture-ca.pem'
        self.ca.write_text('Offline test: not used for a connection.')

    def invoke(self, consumer, env):
        with patch.dict(os.environ, {'GOVERNANCE_WORKFLOW_WRITES': '1',
                                    'TEST_METADATA_OPT_IN': '1', **env}, clear=True), \
                patch('ssl.get_default_verify_paths', return_value=types.SimpleNamespace(cafile=str(self.ca))):
            if consumer == 'metadata':
                self.metadata.MetadataStore('testScope', self.expected)
            else:
                self.workflow.ProductionWorkflowStore()

    def test_missing_alias_only_conflicts_and_invalid_targets_fail_before_connect(self):
        cases = [
            {}, {'GOVERNANCE_DATABASE_URL': URL},
            {'PRODUCTION_DATABASE_URL': URL, 'GOVERNANCE_DATABASE_URL': URL + '?other=1'},
            {'PRODUCTION_DATABASE_URL': 'not a URL'},
            {'PRODUCTION_DATABASE_URL': URL.replace('pooled.db.prisma.io', '127.0.0.1')},
            {'PRODUCTION_DATABASE_URL': URL.replace('/postgres', '/other')},
            {'PRODUCTION_DATABASE_URL': URL.replace('postgres:', 'https:')},
            {'PRODUCTION_DATABASE_URL': URL, 'GOVERNANCE_ALLOW_SQLITE_FIXTURES': '1'},
        ]
        for consumer in ['metadata', 'workflow']:
            for env in cases:
                with self.subTest(consumer=consumer, names=list(env)):
                    self.connect.reset_mock()
                    with self.assertRaises(GovernanceReadError):
                        self.invoke(consumer, env)
                    self.connect.assert_not_called()

    def test_canonical_and_identical_leftover_alias_keep_pinned_tls_parameters(self):
        for consumer in ['metadata', 'workflow']:
            for env in [{'PRODUCTION_DATABASE_URL': URL},
                        {'PRODUCTION_DATABASE_URL': URL, 'GOVERNANCE_DATABASE_URL': URL}]:
                with self.subTest(consumer=consumer, names=list(env)):
                    self.connect.reset_mock()
                    with self.assertRaises(ConnectionReached):
                        self.invoke(consumer, env)
                    self.connect.assert_called_once_with(
                        host='pooled.db.prisma.io', port=5432, dbname='postgres',
                        user='fixture', password='configuration-only', sslmode='verify-full',
                        sslrootcert=str(self.ca), connect_timeout=10, prepare_threshold=None)

    def test_fixture_guards_still_reject_both_production_variable_names(self):
        fixture = load_module('fixture', ROOT / 'tools/governance-production/prepare-ci-fixture.py')
        connection = load_module('connection', ROOT / 'tools/governance-production/connection.py')
        target = Path(self.temp.name) / 'must-not-exist.db'
        for name in ['PRODUCTION_DATABASE_URL', 'GOVERNANCE_DATABASE_URL']:
            with self.subTest(name=name), patch.dict(
                    os.environ, {'CI': 'true', 'GOVERNANCE_ALLOW_SQLITE_FIXTURES': '1', name: URL}, clear=True):
                with self.assertRaises(RuntimeError):
                    fixture.prepare()
                with self.assertRaises(RuntimeError):
                    connection.connect(target)
                self.assertFalse(target.exists())


if __name__ == '__main__':
    unittest.main()
