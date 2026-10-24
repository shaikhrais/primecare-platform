import json
import tempfile
import unittest
from pathlib import Path

from api_documentation import document_sources, resolve, shape, source_comments, handbook, index_markdown
from export_governed_openapi import build


def row(id=1, path='/v1/example', method='POST'):
    return dict(id=id, endpoint_code='EXAMPLE', route_path=path, http_method=method,
                auth_required=1, implementation_status='registered-unimplemented',
                request_schema=None, response_schema=None, permission_key=None,
                rate_limit_key=None, service_name='example')


class DocumentationTests(unittest.TestCase):
    def test_every_exported_operation_has_comments_and_an_index_entry(self):
        spec, report = build([row(), row(2, '/v1/example/list', 'GET')], {})
        coverage = report['documentation']
        self.assertEqual(coverage['documentedOperations'], 2)
        self.assertEqual(coverage['registryOnlyOperations'], 2)
        text = handbook(spec, coverage, report['findings'])
        index = index_markdown(coverage)
        for id in [1, 2]:
            self.assertIn(f'id="api-{id}"', text)
            self.assertIn(f'ENDPOINT_REFERENCE.md#api-{id}', index)
        for operations in spec['paths'].values():
            for operation in operations.values():
                self.assertTrue(operation['x-documentation-complete'])
                self.assertIn('No exact method-and-path', operation['description'])
                self.assertEqual(operation['x-contract-status'], 'blocked')

    def test_sources_match_exact_method_and_path_and_conflicts_are_not_merged(self):
        sources = {('POST', '/v1/example'): [
            {'file': 'docs/api/one.openapi.json', 'sha256': 'a', 'components': {}, 'operation': {'summary': 'First version'}},
            {'file': 'docs/api/two.openapi.json', 'sha256': 'b', 'components': {}, 'operation': {'summary': 'Second version'}}]}
        spec, report = build([row(), row(2, method='GET')], sources)
        post, get = spec['paths']['/v1/example']['post'], spec['paths']['/v1/example']['get']
        self.assertIn('Multiple source versions', post['description'])
        self.assertIn('First version', post['description'])
        self.assertIn('Second version', post['description'])
        self.assertEqual(get['x-documentation-sources'], [])
        self.assertNotIn('requestBody', post)
        self.assertEqual(report['documentation']['multipleSourceOperations'], 1)

    def test_field_comments_omit_examples_defaults_and_enum_values(self):
        schema = {'type': 'object', 'properties': {'password': {'type': 'string', 'writeOnly': True,
                  'maxLength': 72, 'example': 'SECRET_SENTINEL', 'default': 'SECRET_SENTINEL', 'enum': ['SECRET_SENTINEL']}},
                  'required': ['password'], 'additionalProperties': False}
        comment = shape(schema, {})
        self.assertIn('password', comment)
        self.assertIn('write-only; never log', comment)
        self.assertIn('maxLength=72', comment)
        self.assertNotIn('SECRET_SENTINEL', comment)

    def test_refs_are_local_bounded_and_cycles_do_not_fetch_urls(self):
        components = {'schemas': {'A': {'$ref': '#/components/schemas/A'}}}
        self.assertIn('review', resolve({'$ref': '#/components/schemas/A'}, components)['description'])
        self.assertIn('review', resolve({'$ref': 'https://private.invalid/schema'}, components)['description'])

    def test_duplicates_are_quarantined_without_documentation_credit(self):
        spec, report = build([row(), row(2), row(3, 'invalid')], {})
        coverage = report['documentation']
        self.assertEqual(coverage['registeredRecords'], 3)
        self.assertEqual(coverage['documentedOperations'], 1)
        self.assertEqual(coverage['omittedOrQuarantinedRecords'], 2)
        text = handbook(spec, coverage, report['findings'])
        self.assertIn('Registry ID 2', text)
        self.assertIn('Registry ID 3', text)

    def test_source_loader_hashes_only_repository_documentation_locations(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            folder = root / 'docs/api'
            folder.mkdir(parents=True)
            source = {'openapi': '3.1.0', 'paths': {'/v1/example': {'post': {'summary': 'Known operation'}}}}
            (folder / 'fixture.openapi.json').write_text(json.dumps(source))
            index = document_sources(root)
            self.assertEqual(list(index), [('POST', '/v1/example')])
            self.assertEqual(len(index[('POST', '/v1/example')][0]['sha256']), 64)
            self.assertEqual(index[('POST', '/v1/example')][0]['file'], 'docs/api/fixture.openapi.json')


if __name__ == '__main__':
    unittest.main()
