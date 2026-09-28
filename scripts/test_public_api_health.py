"""Safe live smoke checks: health, missing docs, and credential-free auth only."""
import concurrent.futures
import json
from pathlib import Path
import urllib.request
import urllib.error

BASE = 'https://primecare-api-gateway.itpro-mohammed.workers.dev'
SERVICES = ['auth', 'client', 'provider', 'visit', 'notes', 'billing', 'scheduling',
            'notification', 'verification', 'compliance', 'governance', 'franchise-reporting']


def probe(case):
    method, path, expected = case
    request = urllib.request.Request(BASE + path, method=method,
        data=b'{}' if method == 'POST' else None,
        headers={'Content-Type': 'application/json'})
    try:
        with urllib.request.urlopen(request, timeout=20) as response:
            status = response.status
            healthy = json.load(response).get('status') == 'healthy' if path.endswith('/health') else True
        return dict(method=method, path=path, expected=expected, status=status,
                    passed=status == expected and healthy)
    except urllib.error.HTTPError as error:
        return dict(method=method, path=path, expected=expected, status=error.code, passed=error.code == expected)
    except Exception as error:
        return dict(method=method, path=path, expected=expected, passed=False, error=type(error).__name__)


if __name__ == '__main__':
    cases = [('GET', '/health', 200)] + [('GET', '/v1/' + s + '/health', 200) for s in SERVICES]
    cases += [('GET', '/v1/auth/me', 401), ('POST', '/v1/auth/login', 400),
              ('GET', '/openapi.json', 200), ('GET', '/docs', 200)]
    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as executor:
        results = list(executor.map(probe, cases))
    report = dict(mode='production smoke; no credentials or business writes',
                  total=len(results), passed=sum(r['passed'] for r in results), results=results)
    target = Path(__file__).resolve().parents[1] / 'docs/audits/public-api-smoke-tests.json'
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))
    raise SystemExit(0 if all(r['passed'] for r in results) else 1)
