"""Read only known Worker binding metadata; never values, mailbox contents or messages."""
import json
import os
from pathlib import Path
import urllib.error
import urllib.request

SCRIPTS = ('primecare-auth-api', 'primecare-governance-api',
           'primecare-api-gateway', 'primecare-email-inbox')

def summarize(script, payload, status):
    result = payload.get('result') if isinstance(payload, dict) else None
    bindings = result.get('bindings', []) if isinstance(result, dict) else []
    safe = []
    for binding in bindings if isinstance(bindings, list) else []:
        if not isinstance(binding, dict):
            continue
        # No plain-text/JSON values, secret values, account IDs or object keys.
        if not all(isinstance(binding.get(key), str) for key in ('name', 'type')):
            continue
        row = {'name': binding['name'], 'type': binding['type']}
        if binding['type'] == 'service' and isinstance(binding.get('service'), str):
            row['service'] = binding['service']
        safe.append(row)
    return {'script': script, 'httpStatus': status,
            'settingsRead': status == 200 and isinstance(payload, dict) and payload.get('success') is True,
            'bindings': sorted(safe, key=lambda row: row['name']),
            'nativeEmailBinding': any(row['name'] == 'EMAIL' and row['type'] == 'send_email' for row in safe),
            'r2BindingNames': [row['name'] for row in safe if row['type'] == 'r2_bucket'],
            'mediaOrScannerNameHints': [row['name'] for row in safe if any(
                term in row['name'].upper() for term in ('TURN', 'SCANNER', 'PICTURE', 'MEDIA', 'SIGNAL', 'COMMUNICATION'))]}

def inventory(account, token, fetch):
    report = {'sourceCommit': os.environ.get('GITHUB_SHA'), 'writesAttempted': False,
              'readsMessages': False, 'credentialsConfigured': bool(account and token),
              'liveCommunicationVerified': False, 'workers': []}
    if account and token:
        for script in SCRIPTS:
            status, payload = fetch('/accounts/' + account + '/workers/scripts/' + script + '/settings', token)
            report['workers'].append(summarize(script, payload, status))
    return report

def fetch(path, token):
    request = urllib.request.Request('https://api.cloudflare.com/client/v4' + path,
        headers={'Authorization': 'Bearer ' + token, 'Content-Type': 'application/json'}, method='GET')
    try:
        with urllib.request.urlopen(request, timeout=20) as response:
            return response.status, json.load(response)
    except urllib.error.HTTPError as error:
        return error.code, {}
    except (OSError, ValueError):
        return None, {}

if __name__ == '__main__':
    report = inventory(os.environ.get('CLOUDFLARE_ACCOUNT_ID'), os.environ.get('CLOUDFLARE_API_TOKEN'), fetch)
    target = Path('test-results/business-communications')
    target.mkdir(parents=True, exist_ok=True)
    (target/'provider-bindings.json').write_text(json.dumps(report, indent=2) + '\n')
    print('COMMUNICATION_PROVIDER_METADATA ' + json.dumps(report))
