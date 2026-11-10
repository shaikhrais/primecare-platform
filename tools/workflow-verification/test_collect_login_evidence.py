"""Offline collector security fixtures; execute exclusively in GitHub Actions."""
import contextlib
import io
import json
from pathlib import Path
import stat
import tempfile
import unittest
from unittest.mock import patch
import urllib.request
import warnings
import zipfile

import collect_login_evidence as collector


class CollectorTests(unittest.TestCase):
    def archive(self, entries):
        output = io.BytesIO()
        with warnings.catch_warnings():
            warnings.simplefilter('ignore', UserWarning)
            with zipfile.ZipFile(output, 'w') as archive:
                for name, body in entries:
                    archive.writestr(name, body)
        return output.getvalue()

    def extract(self, payload):
        with tempfile.TemporaryDirectory() as tmp:
            collector.extract_zip(payload, Path(tmp) / 'artifact')

    def test_rejects_traversal_absolute_windows_and_duplicate_paths(self):
        for name in ('../outside', '/absolute', 'nested/../../outside', 'C:/outside', 'a\\b', './file'):
            with self.subTest(name=name), self.assertRaises(collector.EvidenceError):
                self.extract(self.archive([(name, b'data')]))
        with self.assertRaisesRegex(collector.EvidenceError, 'Duplicate'):
            self.extract(self.archive([('same', b'one'), ('same', b'two')]))

    def test_rejects_symlinks_special_files_oversize_and_many_files(self):
        for mode in (stat.S_IFLNK, stat.S_IFIFO):
            entry = zipfile.ZipInfo('unsafe')
            entry.create_system = 3
            entry.external_attr = (mode | 0o777) << 16
            with self.assertRaises(collector.EvidenceError):
                self.extract(self.archive([(entry, b'../target')]))
        with patch.object(collector, 'MAX_BYTES', 3), self.assertRaisesRegex(collector.EvidenceError, 'size'):
            self.extract(self.archive([('one', b'1234')]))
        with patch.object(collector, 'MAX_FILES', 1), self.assertRaisesRegex(collector.EvidenceError, 'too many'):
            self.extract(self.archive([('one', b'1'), ('two', b'2')]))

    def test_zip_regular_files_preserve_original_bytes(self):
        content = b'{"passed":false}\n'
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / 'artifact'
            collector.extract_zip(self.archive([('nested/results.json', content)]), target)
            self.assertEqual((target / 'nested/results.json').read_bytes(), content)

    def test_redirect_never_forwards_token_outside_github_api(self):
        request = urllib.request.Request('https://api.github.com/repos/a/b',
                                         headers={'Authorization': 'Bearer fixture-token'})
        redirect = collector.SafeRedirect()
        for destination in ('https://storage.example/download', 'https://api.github.com.evil.example/file',
                            'https://api.github.com:444/file'):
            with self.subTest(destination=destination):
                forwarded = redirect.redirect_request(request, None, 302, 'Found', {}, destination)
                self.assertNotIn('Authorization', forwarded.headers)
                self.assertNotIn('Authorization', forwarded.unredirected_hdrs)
        same = redirect.redirect_request(request, None, 302, 'Found', {}, 'https://api.github.com/other')
        self.assertEqual(same.get_header('Authorization'), 'Bearer fixture-token')
        for destination in ('http://storage.example/file', 'https://user:password@storage.example/file'):
            with self.assertRaises(collector.EvidenceError):
                redirect.redirect_request(request, None, 302, 'Found', {}, destination)

    def workflow(self, entries):
        return json.dumps({'jobs': {'login-race': {'strategy': {'matrix': {'include': entries}}}}}).encode()

    def entry(self, **overrides):
        return {'label': 'candidate', 'source': 'a' * 40, 'baseline': '0', **overrides}

    def test_matrix_requires_unique_safe_labels_and_immutable_sources(self):
        entries, _ = collector.matrix_entries(self.workflow([self.entry()]))
        self.assertEqual(entries[0]['source'], 'a' * 40)
        bad = [[self.entry(), self.entry()], [self.entry(label='../escape')],
               [self.entry(source='main')], [self.entry(source='a' * 39)],
               [self.entry(baseline='yes')], []]
        for entries in bad:
            with self.subTest(entries=entries), self.assertRaises(collector.EvidenceError):
                collector.matrix_entries(self.workflow(entries))

    def test_timestamp_requires_timezone_and_preserves_original_instant(self):
        self.assertEqual(collector.timestamp('2026-11-09T10:00:00Z'),
                         collector.timestamp('2026-11-09T12:00:00+02:00'))
        for invalid in ('2026-11-09T10:00:00', 'bad', None):
            with self.assertRaises(collector.EvidenceError):
                collector.timestamp(invalid)

    def test_original_patch_reconstructed_without_executing_code(self):
        script = b'throw new Error("must never execute");\n'
        modified = b'throw new Error("still never execute");\n'
        diff = (f'diff --git a/{collector.SCRIPT} b/{collector.SCRIPT}\n'
                f'--- a/{collector.SCRIPT}\n+++ b/{collector.SCRIPT}\n'
                '@@ -1 +1 @@\n-throw new Error("must never execute");\n'
                '+throw new Error("still never execute");\n').encode()
        def source(root, commit, path):
            self.assertEqual(commit, 'a' * 40)
            return script if path == collector.SCRIPT else diff
        with patch.object(collector, 'git_file', side_effect=source):
            self.assertEqual(collector.patched_script(Path('/unused'), 'a' * 40), modified)
        with patch.object(collector, 'git_file', side_effect=lambda root, commit, path:
                          script if path == collector.SCRIPT else diff.replace(collector.SCRIPT.encode(), b'evil.sh')):
            with self.assertRaisesRegex(collector.EvidenceError, 'unexpected'):
                collector.patched_script(Path('/unused'), 'a' * 40)

    def test_packet_blocks_mismatched_sources_and_preserves_receipt(self):
        head, commit = 'a' * 40, 'b' * 40
        start, finish = '2026-11-09T10:00:00Z', '2026-11-09T10:01:00Z'
        repository = {'id': 123, 'full_name': collector.REPO}
        run = {'id': 42, 'run_attempt': 1, 'path': collector.WORKFLOW, 'head_branch': 'main',
               'event': 'push', 'head_sha': head, 'repository': repository,
               'head_repository': repository, 'status': 'completed'}
        job = {'id': 420, 'run_id': 42, 'run_attempt': 1, 'head_sha': head,
               'name': 'login-race (candidate)', 'status': 'completed',
               'started_at': start, 'completed_at': finish}
        receipt = {'workflow_id': 'auth.credential-login', 'commit': commit,
                   'workflow_run_sha': head, 'started_at': start, 'finished_at': finish,
                   'source_bindings': {collector.SCRIPT: '0' * 64}, 'passed': True}
        raw = json.dumps(receipt, separators=(',', ':')).encode()
        archive = self.archive([('results.json', raw)])
        artifact = {'id': 7, 'name': 'login-session-race-candidate', 'created_at': finish,
                    'expired': False, 'workflow_run': {'id': 42, 'head_sha': head,
                    'repository_id': 123, 'head_repository_id': 123}}
        class FakeGitHub:
            def __init__(self, token):
                pass
            def json(self, path):
                return repository if path.endswith(collector.REPO + '/') else run
            def pages(self, path, key):
                return [job] if key == 'jobs' else [artifact]
            def read(self, path):
                return archive
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            fake_file = root / 'tools/workflow-verification/collect_login_evidence.py'
            workflow = self.workflow([self.entry(source=commit)])
            with patch.object(collector, '__file__', str(fake_file)), \
                 patch.object(collector, 'GitHub', FakeGitHub), \
                 patch.object(collector, 'git_file', side_effect=lambda root, sha, path:
                              workflow if path == collector.WORKFLOW else b'original'), \
                 patch.object(collector, 'patched_script', return_value=b'reconstructed'), \
                 patch.dict('os.environ', {'GH_TOKEN': 'fixture-token'}), \
                 patch('sys.argv', ['collector', '--run-id', '42']), \
                 contextlib.redirect_stdout(io.StringIO()):
                collector.main()
            packet = json.loads((root / 'test-results/login-tracking/42-1/packet.json').read_text())
            result = packet['jobs'][0]
            self.assertIn('Restored source hash mismatch: ' + collector.SCRIPT, result['validation_errors'])
            self.assertEqual((root / result['receipt_path']).read_bytes(), raw)
            self.assertEqual(result['receipt_sha256'], collector.digest(raw))
            self.assertEqual(result['receipt'], receipt)
            self.assertTrue(result['source_bindings'])
            for item in result['evidence']:
                self.assertEqual(item['sha256'], collector.digest((root / item['path']).read_bytes()))


if __name__ == '__main__':
    unittest.main()
