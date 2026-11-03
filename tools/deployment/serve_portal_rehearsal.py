"""Serve verified clinic release files for an isolated browser rehearsal."""
import argparse
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
import mimetypes
from urllib.parse import urlsplit
from zipfile import ZipFile

from .typescript_release import digest
from .verify_portal_archive import verify_archive

PROJECT = 'primecare-clinic'


def serve(archive, commit, api_port):
    if not 1 <= api_port <= 65535:
        raise ValueError('A valid loopback API port is required')
    stamp = verify_archive(archive, PROJECT, commit)
    with ZipFile(archive) as bundle:
        files = {name: bundle.read(f'{PROJECT}/{name}') for name in stamp['files']}
    if any(digest(body) != stamp['files'][name] for name, body in files.items()):
        raise ValueError('Archive changed while loading rehearsal files')
    api = f'http://127.0.0.1:{api_port}'
    manifest = json.loads(files['portal.json'])
    manifest['apiGateway'] = api
    files['portal.json'] = json.dumps(manifest).encode()

    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            path = urlsplit(self.path).path
            name = path.lstrip('/') or 'index.html'
            if name in ('login', 'forgot-password', 'reset-password', 'platform/administration'):
                name = 'index.html'
            if name not in files:
                self.send_error(404)
                return
            body = files[name]
            self.send_response(200)
            self.send_header('Content-Type', mimetypes.guess_type(name)[0] or 'application/octet-stream')
            self.send_header('Content-Security-Policy',
                             f"default-src 'self'; connect-src 'self' {api}; "
                             "script-src 'self'; style-src 'self' 'unsafe-inline'; "
                             "worker-src 'none'; form-action 'none'; base-uri 'none'")
            self.send_header('Cache-Control', 'no-store')
            self.send_header('Content-Length', str(len(body)))
            self.end_headers()
            self.wfile.write(body)

    with ThreadingHTTPServer(('127.0.0.1', 0), Handler) as server:
        print(f'http://127.0.0.1:{server.server_port}', flush=True)
        server.serve_forever()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('archive')
    parser.add_argument('commit')
    parser.add_argument('--api-port', type=int, required=True)
    args = parser.parse_args()
    serve(args.archive, args.commit, args.api_port)
