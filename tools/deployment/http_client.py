"""Truthfully identify PrimeCare's owned CI verifier; never impersonate browsers."""
import urllib.request

VERIFIER_USER_AGENT = (
    'PrimeCareDeploymentVerifier/1.0 '
    '(+https://github.com/shaikhrais/primecare-platform)'
)


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


def read_public_asset(url, timeout=25):
    """Read an exact public asset, failing on redirects or protection errors."""
    request = urllib.request.Request(url, headers={'User-Agent': VERIFIER_USER_AGENT})
    with urllib.request.build_opener(NoRedirect).open(request, timeout=timeout) as response:
        if response.status != 200:
            raise RuntimeError(f'Public asset returned HTTP {response.status}')
        return response.read()
