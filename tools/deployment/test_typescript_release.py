import copy
import json
from pathlib import Path
import tempfile
import unittest
from urllib.parse import urlsplit
from .typescript_release import FILES, STAMP, make_stamp, validate, verify_live

class TypeScriptReleaseTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(); self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name); (self.root / 'assets').mkdir()
        self.project = 'primecare-corporate'; self.commit = 'a' * 40
        self.assets = {name: ('owned ' + name).encode() for name in FILES}
        for name, value in self.assets.items(): (self.root / name).write_bytes(value)
        self.stamp = make_stamp(self.root, self.project, self.commit)
        self.stamps = [self.stamp, self.stamp]; self.requests = []
    def read(self, url):
        self.requests.append(url); name = urlsplit(url).path[1:]
        if name == 'index.html':
            from urllib.error import HTTPError
            raise HTTPError(url, 308, 'Permanent Redirect', {'Location':'/'}, None)
        if name == '': name = 'index.html'
        return json.dumps(self.stamps.pop(0)).encode() if name == STAMP else self.assets[name]
    def verify(self):
        return verify_live(self.project, self.commit, self.stamp, self.read)
    def test_exact_source_and_independently_read_assets(self):
        self.assertEqual(self.verify(), self.stamp)
        self.assertEqual([urlsplit(url).path for url in self.requests], ['/' + STAMP, '/', '/portal.json', '/assets/app.js', '/' + STAMP])
    def test_local_asset_change_changes_fingerprint(self):
        (self.root / 'assets/app.js').write_bytes(b'new build')
        self.assertNotEqual(make_stamp(self.root, self.project, self.commit), self.stamp)
    def test_other_runtime_source_and_project_rejected(self):
        for field, value in [('runtime', 'flutter'), ('commit', 'b' * 40), ('project', 'primecare-client')]:
            with self.subTest(field=field):
                altered = {**self.stamp, field: value}
                with self.assertRaises(ValueError): validate(altered, self.project, self.commit)
    def test_missing_and_additional_fields_rejected(self):
        for altered in [{**self.stamp, 'extra': True}, {k:v for k,v in self.stamp.items() if k != 'files'}, {**self.stamp, 'files': {'assets/app.js': '0' * 64}}]:
            with self.assertRaises(ValueError): validate(altered, self.project, self.commit)
    def test_tampered_assets_rejected(self):
        for name in FILES:
            with self.subTest(name=name):
                original = self.assets[name]; self.assets[name] = b'tampered'; self.stamps = [self.stamp, self.stamp]
                with self.assertRaises(ValueError): self.verify()
                self.assets[name] = original
    def test_matching_commit_with_different_build_rejected(self):
        altered = copy.deepcopy(self.stamp); altered['files']['portal.json'] = '0' * 64
        self.stamps = [altered]
        with self.assertRaises(ValueError): self.verify()
    def test_replacement_during_asset_reads_rejected(self):
        self.stamps = [self.stamp, {**self.stamp, 'runtime': 'flutter'}]
        with self.assertRaises(ValueError): self.verify()
    def test_invalid_destination_never_reaches_reader(self):
        with self.assertRaises(ValueError): verify_live('attacker.invalid/path', self.commit, reader=self.read)
        self.assertEqual(self.requests, [])
    def test_oversized_stamp_rejected(self):
        with self.assertRaises(ValueError): verify_live(self.project, self.commit, reader=lambda _: b' ' * 16385)
    def test_protected_asset_is_not_accepted(self):
        from urllib.error import HTTPError
        def denied(url): raise HTTPError(url, 403, 'Forbidden', {}, None)
        with self.assertRaises(HTTPError): verify_live(self.project, self.commit, reader=denied)

if __name__ == '__main__': unittest.main()
