import hashlib
import importlib.util
import io
import json
from pathlib import Path
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('diagnostic', Path(__file__).resolve().parents[1] / 'diagnose_sqlite_asset.py')
d = importlib.util.module_from_spec(spec)
spec.loader.exec_module(d)


class Response(io.BytesIO):
    def __init__(self, body=b'fixture', status=200, headers=None):
        super().__init__(body)
        self.status = status
        self.headers = headers or {'Content-Type': 'application/octet-stream'}


class Tests(unittest.TestCase):
    def run_case(self, body=b'fixture', status=200, headers=None, **kwargs):
        return d.diagnose(lambda *args: Response(body, status, headers),
                          expected_size=7, expected_sha=hashlib.sha256(b'fixture').hexdigest(), **kwargs)

    def test_correct(self):
        self.assertTrue(self.run_case()['match'])

    def test_non200_matching_body_still_fails(self):
        r = self.run_case(status=504)
        self.assertFalse(r['match']); self.assertEqual(r['error'], 'http_status')
        self.assertTrue(r['complete']); self.assertEqual(r['bytes'], 7)

    def test_wrong_hash_same_length(self):
        self.assertEqual(self.run_case(b'wrong!!')['error'], 'integrity_mismatch')

    def test_wrong_length(self):
        r = d.diagnose(lambda *args: Response(), expected_size=8, expected_sha=hashlib.sha256(b'fixture').hexdigest())
        self.assertFalse(r['match'])

    def test_oversize(self):
        with patch.object(d, 'MAX_BYTES', 8):
            r = self.run_case(b'0123456789')
        self.assertEqual(r['error'], 'size_limit'); self.assertEqual(r['bytes'], 9)
        self.assertIsNone(r['sha256']); self.assertFalse(r['complete'])

    def test_timeout(self):
        def fail(*args):
            raise TimeoutError('private query')
        self.assertEqual(d.diagnose(fail)['error'], 'timeout')

    def test_elapsed_deadline(self):
        times = iter([0, 0, 31])
        self.assertEqual(self.run_case(clock=lambda: next(times))['error'], 'timeout')

    def test_redirect(self):
        calls = []
        def open_url(url, timeout):
            calls.append(url)
            return Response(status=302, headers={'Location': 'https://release-assets.githubusercontent.com/asset?secret=token'}) if len(calls) == 1 else Response()
        r = d.diagnose(open_url, expected_size=7, expected_sha=hashlib.sha256(b'fixture').hexdigest())
        self.assertTrue(r['match']); self.assertEqual(len(calls), 2)
        self.assertNotIn('token', json.dumps(r))

    def test_redirect_rejections(self):
        for target in ['http://github.com/file', 'https://evil.invalid/file', 'https://github.com.evil.invalid/file', 'https://user:secret@github.com/file', 'https://github.com:444/file', 'https://github.com/file#secret', 'https://github.com/file\nsecret']:
            with self.subTest(target=target):
                calls = []
                def open_url(*args):
                    calls.append(1)
                    return Response(status=302, headers={'Location': target})
                r = d.diagnose(open_url)
                self.assertEqual(r['error'], 'redirect_rejected'); self.assertEqual(len(calls), 1)

    def test_redirect_limit(self):
        r = self.run_case(status=302, headers={'Location': d.URL})
        self.assertEqual(r['error'], 'redirect_limit')

    def test_empty_userinfo_rejected(self):
        for url in ('https://@github.com/file', 'https://:@github.com/file'):
            with self.subTest(url=url):
                self.assertFalse(d.allowed(url))
                calls = []
                def open_url(*args):
                    calls.append(1)
                    return Response(status=302, headers={'Location': url})
                self.assertEqual(d.diagnose(open_url)['error'], 'redirect_rejected')
                self.assertEqual(len(calls), 1)

    def test_missing_redirect(self):
        self.assertEqual(self.run_case(status=302)['error'], 'redirect_missing')

    def test_sanitization(self):
        def fail(*args):
            raise ValueError('https://user:password@host/?signature=secret BODY')
        r = d.diagnose(fail)
        self.assertEqual(r['error'], 'transport_error'); self.assertNotIn('secret', json.dumps(r))
        r = self.run_case(headers={'Content-Type': 'secret\ntext/plain'})
        self.assertIsNone(r['content_type'])

    def test_no_automatic_redirect(self):
        self.assertIsNone(d.NoRedirect().redirect_request(None, None, 302, '', {}, 'https://evil.invalid'))

    def test_transport_preserves_default_proxy_handler(self):
        with patch.object(d.urllib.request, 'getproxies', return_value={'https': 'http://proxy.invalid:8080', 'no': 'github.com'}), patch.object(d.urllib.request.OpenerDirector, 'open', return_value=Response()) as opened:
            original = d.urllib.request.build_opener
            captured = []
            def build(*handlers):
                opener = original(*handlers)
                captured.append(opener)
                return opener
            with patch.object(d.urllib.request, 'build_opener', side_effect=build):
                d.transport(d.URL, 3)
            handlers = [h for h in captured[0].handlers if isinstance(h, d.urllib.request.ProxyHandler)]
            self.assertEqual(len(handlers), 1)
            self.assertEqual(handlers[0].proxies, {'https': 'http://proxy.invalid:8080', 'no': 'github.com'})
            self.assertEqual(opened.call_args.kwargs['timeout'], 3)

    def test_proxy_and_no_proxy_environment_retained(self):
        import os
        with patch.dict(os.environ, {'https_proxy': 'http://proxy.invalid:8080', 'no_proxy': 'github.com'}, clear=True):
            opener = d.urllib.request.build_opener(d.NoRedirect())
            handler = next(h for h in opener.handlers if isinstance(h, d.urllib.request.ProxyHandler))
            self.assertEqual(handler.proxies['https'], 'http://proxy.invalid:8080')
            request = d.urllib.request.Request(d.URL)
            with patch.object(request, 'set_proxy') as set_proxy:
                handler.proxy_open(request, handler.proxies['https'], 'https')
                set_proxy.assert_not_called()
            request = d.urllib.request.Request('https://release-assets.githubusercontent.com/asset')
            with patch.object(request, 'set_proxy') as set_proxy:
                handler.proxy_open(request, handler.proxies['https'], 'https')
                set_proxy.assert_called_once_with('proxy.invalid:8080', 'http')

    def test_main_exit_and_alarm(self):
        for match in [False, True]:
            with patch.object(d, 'diagnose', return_value={'match': match}), patch.object(d.signal, 'signal'), patch.object(d.signal, 'setitimer') as timer, patch('sys.stdout', new_callable=io.StringIO):
                self.assertEqual(d.main(), 0 if match else 1)
                timer.assert_called_with(d.signal.ITIMER_REAL, 0)


if __name__ == '__main__':
    unittest.main()
