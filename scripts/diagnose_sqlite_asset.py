"""Bounded delivery metadata only. Never save/load native bytes or weaken checks."""
import hashlib
import json
import signal
import socket
import time
import urllib.error
import urllib.parse
import urllib.request

URL = 'https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-3.5.2/libsqlite3.x64.linux.so'
EXPECTED_SHA256 = 'b17729184e5a2818055ecbddd5ed6642521bfe6e56aafa472330e483c0e2e0d2'
EXPECTED_SIZE = 1801592
MAX_BYTES = 2 * 1024 * 1024
MAX_SECONDS = 30
HOSTS = frozenset(('github.com', 'release-assets.githubusercontent.com', 'objects.githubusercontent.com'))


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


def allowed(url):
    try:
        p = urllib.parse.urlsplit(url)
        return (p.scheme == 'https' and p.hostname in HOSTS
                and p.port in (None, 443) and p.username is None and p.password is None
                and not p.fragment and not any(ord(c) < 33 or ord(c) > 126 for c in url))
    except ValueError:
        return False


def transport(url, timeout):
    # Keep standard proxy/NO_PROXY handling. Never log proxy values or errors.
    # No cookies, custom auth handlers or caller-supplied URLs are added.
    opener = urllib.request.build_opener(NoRedirect())
    request = urllib.request.Request(url, headers={'User-Agent': 'PrimeCare-asset-diagnostic/1', 'Accept-Encoding': 'identity'})
    try:
        return opener.open(request, timeout=timeout)
    except urllib.error.HTTPError as response:
        return response


def diagnose(open_url=transport, clock=time.monotonic, expected_size=EXPECTED_SIZE,
             expected_sha=EXPECTED_SHA256):
    result = dict(status=None, content_type=None, bytes=0, sha256=None,
                  complete=False, match=False, redirects=0, error=None)
    start = clock()
    url = URL
    try:
        for redirect in range(4):
            if not allowed(url):
                result['error'] = 'redirect_rejected'
                return result
            remaining = MAX_SECONDS - (clock() - start)
            if remaining <= 0:
                raise TimeoutError()
            with open_url(url, min(5, remaining)) as response:
                status = int(response.status)
                result['status'] = status
                if status in (301, 302, 303, 307, 308):
                    if redirect == 3:
                        result['error'] = 'redirect_limit'
                        return result
                    location = response.headers.get('Location')
                    if not location:
                        result['error'] = 'redirect_missing'
                        return result
                    if any(ord(c) < 33 or ord(c) > 126 for c in location):
                        result['error'] = 'redirect_rejected'
                        return result
                    url = urllib.parse.urljoin(url, location)
                    result['redirects'] += 1
                    continue
                content_type = response.headers.get('Content-Type', '').split(';', 1)[0].strip().lower()
                if content_type in ('application/octet-stream', 'application/x-sharedlib', 'text/html', 'text/plain'):
                    result['content_type'] = content_type
                digest = hashlib.sha256()
                while True:
                    if clock() - start >= MAX_SECONDS:
                        raise TimeoutError()
                    # Read at most one byte beyond the cap to detect oversize.
                    chunk = response.read(min(65536, MAX_BYTES + 1 - result['bytes']))
                    if not chunk:
                        break
                    result['bytes'] += len(chunk)
                    if result['bytes'] > MAX_BYTES:
                        result['error'] = 'size_limit'
                        return result
                    digest.update(chunk)
                    del chunk
                result['complete'] = True
                result['sha256'] = digest.hexdigest()
                result['match'] = (status == 200 and result['bytes'] == expected_size
                                   and result['sha256'] == expected_sha)
                result['error'] = (None if result['match'] else
                                   'http_status' if status != 200 else 'integrity_mismatch')
                return result
    except (TimeoutError, socket.timeout):
        result['error'] = 'timeout'
    except Exception:
        # Exception strings can contain signed redirects, credentials or bodies.
        result['error'] = 'transport_error'
    return result


def main():
    def deadline(signum, frame):
        raise TimeoutError()
    # Linux CI wall deadline also bounds DNS and slow-trickle responses.
    signal.signal(signal.SIGALRM, deadline)
    signal.setitimer(signal.ITIMER_REAL, MAX_SECONDS)
    try:
        result = diagnose()
    finally:
        signal.setitimer(signal.ITIMER_REAL, 0)
    print(json.dumps(result, sort_keys=True))
    return 0 if result['match'] else 1


if __name__ == '__main__':
    raise SystemExit(main())
