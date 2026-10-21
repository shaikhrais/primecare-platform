"""Read-only Pages access diagnosis. Never print tokens or full project config."""
import json
import os
import re
import urllib.error
import urllib.request
from pathlib import Path

PROJECT = 'primecare-clinic'
PUBLIC_URL = f'https://{PROJECT}.pages.dev/primecare-build.json?enable-semantics=true'
SAFE_HEADERS = ('server', 'content-type', 'cf-ray', 'cf-mitigated')


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None


def fetch(url, token=None):
    headers = {'User-Agent': 'PrimeCareDeploymentVerifier/1.0 (+https://github.com/shaikhrais/primecare-platform)'}
    if token:
        headers['Authorization'] = 'Bearer ' + token
    request = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.build_opener(NoRedirect).open(request, timeout=25) as response:
            return response.status, response.read(2_000_000), response.headers
    except urllib.error.HTTPError as error:
        return error.code, error.read(2_000_000), error.headers


def classify(status, body, headers):
    text = body.decode('utf-8', 'replace')
    code = re.search(r'error\s+code:\s*(\d{4})', text, re.I)
    location = headers.get('location', '')
    return {
        'status': status,
        'headers': {key: headers.get(key) for key in SAFE_HEADERS if headers.get(key)},
        'cloudflare_error_code': code.group(1) if code else None,
        'access_login_redirect': '/cdn-cgi/access/login' in location or '.cloudflareaccess.com' in location,
        'challenge': headers.get('cf-mitigated') == 'challenge',
        'body_bytes': len(body),
        # Never emit arbitrary error HTML, cookies, redirects or response config.
    }


def main():
    token = os.environ['CLOUDFLARE_API_TOKEN']
    account = os.environ['CLOUDFLARE_ACCOUNT_ID']
    api = f'https://api.cloudflare.com/client/v4/accounts/{account}'
    report = {'project': PROJECT, 'read_only': True, 'protection_changed': False}
    status, body, _ = fetch(api + '/pages/projects/' + PROJECT, token)
    report['pages_api_status'] = status
    if status == 200:
        payload = json.loads(body)
        project = payload.get('result') or {}
        deployment = project.get('canonical_deployment') or {}
        metadata = (deployment.get('deployment_trigger') or {}).get('metadata') or {}
        report['pages'] = {
            'name': project.get('name'), 'subdomain': project.get('subdomain'),
            'production_branch': project.get('production_branch'),
            'deployment_id': deployment.get('id'), 'environment': deployment.get('environment'),
            'stage': deployment.get('latest_stage'), 'commit': metadata.get('commit_hash'),
            'has_custom_domains': bool(project.get('domains')),
        }
    status, body, headers = fetch(PUBLIC_URL)
    report['public_probe'] = classify(status, body, headers)
    if status == 200:
        try:
            stamp = json.loads(body)
            report['public_stamp'] = {key: stamp.get(key) for key in ('runtime', 'commit', 'project', 'sha256')}
        except ValueError:
            report['public_stamp_invalid'] = True
    # Read Access policy metadata only if the existing scoped token permits it.
    status, body, _ = fetch(api + '/access/apps?per_page=1000', token)
    report['access_apps_api_status'] = status
    if status == 200:
        apps = json.loads(body).get('result') or []
        matches = [app for app in apps if PROJECT + '.pages.dev' in str(app.get('domain', ''))]
        report['matching_access_apps'] = [{'id': app.get('id'), 'domain': app.get('domain'), 'type': app.get('type')} for app in matches]
        report['access_inventory_complete'] = len(apps) < 1000
    Path('test-results').mkdir(exist_ok=True)
    Path('test-results/pages-access-diagnosis.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))
    if status not in (200, 403):
        print('Access configuration read unavailable; no policy inference made.')


if __name__ == '__main__':
    main()
