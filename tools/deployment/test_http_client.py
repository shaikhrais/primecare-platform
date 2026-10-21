import threading
import unittest
import urllib.error
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from tools.deployment.http_client import VERIFIER_USER_AGENT, read_public_asset

class Handler(BaseHTTPRequestHandler):
    requests = []
    def do_GET(self):
        self.requests.append((self.path, self.headers.get('User-Agent')))
        if self.path == '/redirect':
            self.send_response(302)
            self.send_header('Location', '/asset')
        elif self.path == '/denied':
            self.send_response(403)
        else:
            self.send_response(200)
        self.end_headers()
        self.wfile.write(b'owned-build')
    def log_message(self, *args):
        pass

class PublicAssetTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.server = ThreadingHTTPServer(('127.0.0.1', 0), Handler)
        cls.thread = threading.Thread(target=cls.server.serve_forever, daemon=True)
        cls.thread.start()
        cls.base = f'http://127.0.0.1:{cls.server.server_port}'
    @classmethod
    def tearDownClass(cls):
        cls.server.shutdown()
        cls.server.server_close()
        cls.thread.join()
    def setUp(self):
        Handler.requests.clear()
    def test_asset_has_truthful_service_identity(self):
        self.assertEqual(read_public_asset(self.base + '/asset'), b'owned-build')
        self.assertEqual(Handler.requests, [('/asset', VERIFIER_USER_AGENT)])
        self.assertNotIn('Mozilla', VERIFIER_USER_AGENT)
    def test_access_denial_is_not_accepted(self):
        with self.assertRaises(urllib.error.HTTPError) as error:
            read_public_asset(self.base + '/denied')
        self.assertEqual(error.exception.code, 403)
        self.assertEqual(len(Handler.requests), 1)
    def test_redirect_is_not_followed_to_other_content(self):
        with self.assertRaises(urllib.error.HTTPError) as error:
            read_public_asset(self.base + '/redirect')
        self.assertEqual(error.exception.code, 302)
        self.assertEqual(Handler.requests, [('/redirect', VERIFIER_USER_AGENT)])

if __name__ == '__main__':
    unittest.main()
