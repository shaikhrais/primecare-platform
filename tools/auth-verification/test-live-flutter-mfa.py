"""Verify deployed Flutter MFA with exact synthetic fixtures and redacted evidence."""
import base64
import hashlib
import hmac
import json
import os
from pathlib import Path
import re
import secrets
import struct
import sys
import time
import urllib.error
import urllib.request
import uuid

import bcrypt
import psycopg
from playwright.sync_api import sync_playwright, expect

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
from tools.deployment.flutter_browser import fill_flutter_field
from tools.deployment.http_client import read_public_asset, VERIFIER_USER_AGENT

SITE = 'https://primecare-clinic.pages.dev'
GATEWAY = 'https://primecare-api-gateway.itpro-mohammed.workers.dev'
OUT = Path('test-results/live-flutter-mfa')


def totp(seed, counter):
    digest = hmac.new(base64.b32decode(seed), struct.pack('>Q', counter), hashlib.sha1).digest()
    offset = digest[-1] & 15
    return str((struct.unpack('>I', digest[offset:offset + 4])[0] & 0x7fffffff) % 1000000).zfill(6)


def api(path, body=None, token=None):
    headers = {'Content-Type': 'application/json', 'Origin': SITE, 'User-Agent': VERIFIER_USER_AGENT}
    if token:
        headers['Authorization'] = 'Bearer ' + token
    req = urllib.request.Request(GATEWAY + path, headers=headers,
        data=None if body is None else json.dumps(body).encode(), method='GET' if body is None else 'POST')
    try:
        response = urllib.request.urlopen(req, timeout=30)
    except urllib.error.HTTPError as error:
        response = error
    with response:
        return response.code, json.loads(response.read())


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    expected = json.loads(Path('test-results/flutter-build/primecare-build.json').read_text())
    assert expected['commit'] == os.environ['GITHUB_SHA'] and expected['runtime'] == 'flutter'
    assert expected['project'] == 'primecare-clinic'
    report = {'source': expected['commit'], 'bundleSha256': expected['sha256'], 'synthetic': True,
        'ownerAccountTouched': False, 'independentApprovals': False, 'results': []}

    def build():
        suffix = '?enable-semantics=true&deployment=' + expected['commit']
        assert json.loads(read_public_asset(SITE + '/primecare-build.json' + suffix)) == expected
        assert hashlib.sha256(read_public_asset(SITE + '/main.dart.js' + suffix)).hexdigest() == expected['sha256']

    build()
    db = psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'], autocommit=True, connect_timeout=15)
    catalog = Path('packages/primecare_ui/lib/src/localization/auth_screen_text_generated.dart').read_text()
    catalog = catalog.split('const authScreenCatalog =', 1)[1].split(';', 1)[0].strip()
    catalog = catalog[catalog.index('{'):]
    labels = json.loads(re.sub(r',\s*([}\]])', r'\1', catalog))
    try:
        with sync_playwright() as pw:
            browser = pw.chromium.launch()
            try:
                for locale, width in [('en', 320), ('fr', 768), ('es', 1440)]:
                    tenant, user = str(uuid.uuid4()), str(uuid.uuid4())
                    email, password = 'flutter-mfa-' + user + '@example.invalid', secrets.token_urlsafe(30)
                    slug = 'flutter-mfa-' + tenant
                    result = {'locale': locale, 'width': width, 'checks': [], 'cleanup': False}
                    report['results'].append(result)
                    context = browser.new_context(viewport={'width': width, 'height': 1000}, locale=locale)
                    page = context.new_page()
                    created = False
                    result['identityStatuses'] = []
                    page.on('response', lambda r: result['identityStatuses'].append(r.status) if r.url.split('?')[0].endswith('/v1/auth/me') else None)
                    step = 'create isolated fixture'

                    def must(condition, label):
                        if not condition:
                            raise AssertionError(label)
                        result['checks'].append(label)

                    def field(name):
                        return page.get_by_role('textbox', name=re.compile('^' + re.escape(name) + r'\b'))

                    def button(name):
                        return page.locator('[aria-label="' + name + '"][role="button"], [aria-label="' + name + '"] [role="button"]')

                    def visit(path):
                        page.goto(SITE + path + '?locale=' + locale + '&enable-semantics=true',
                            wait_until='domcontentloaded', timeout=60000)

                    def exchange():
                        fill_flutter_field(page, field('login-email'), email)
                        fill_flutter_field(page, field('login-password'), password)
                        with page.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/login') and r.request.method == 'POST') as response:
                            button('login-submit').click()
                        must(response.value.status == 200, 'password exchange accepted')
                        challenge = response.value.json()
                        must(challenge.get('status') == 'mfa_required' and 'token' not in challenge, 'password exchange issues challenge only')
                        field('mfa-code').wait_for(timeout=30000)
                        must(page.evaluate("localStorage.getItem('flutter.auth_token')") is None, 'no browser authority before factor')
                        must(db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s', (user,)).fetchone()[0] == 0, 'no database session before factor')
                        return challenge

                    def factor(code):
                        fill_flutter_field(page, field('mfa-code'), code)
                        with page.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/mfa') and r.request.method == 'POST') as response:
                            button('mfa-submit').click()
                        return response.value.status, response.value.json()

                    try:
                        with db.transaction():
                            db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary Flutter MFA QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)", (tenant, slug))
                            db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,'code_admin',%s,'mfa_pending',NOW())", (user, email, tenant, bcrypt.hashpw(password.encode(), bcrypt.gensalt(12)).decode()))
                        created = True
                        step = 'select locale and cancel enrollment'
                        visit('/language')
                        page.get_by_role('button', name={'en': 'English', 'fr': 'Français', 'es': 'Español'}[locale], exact=True).click()
                        visit('/login')
                        abandoned = exchange()
                        must(abandoned['purpose'] == 'enroll', 'new account requires enrollment')
                        button('mfa-cancel').click()
                        field('login-email').wait_for()
                        expect(field('login-password')).to_have_value('')
                        must(page.locator('[aria-label^="mfa-seed"]').count() == 0, 'cancel removes displayed setup key')
                        step = 'fresh enrollment and wrong code'
                        challenge = exchange()
                        seed = challenge['setupKey']
                        must(bool(re.fullmatch('[A-Z2-7]{32}', seed)) and seed != abandoned['setupKey'], 'fresh password replaces abandoned setup key')
                        must(api('/v1/auth/mfa', {'challenge': abandoned['challenge'], 'code': totp(abandoned['setupKey'], int(time.time()) // 30)})[0] == 401, 'abandoned challenge rejected after fresh exchange')
                        step = 'render setup key semantics'
                        visible = page.locator('[aria-label^="mfa-seed"]')
                        visible.wait_for()
                        # Locator assertions pierce Flutter's semantics shadow
                        # root and wait for its next accessibility frame.
                        try:
                            expect(visible).to_contain_text(seed, timeout=15000)
                            rendered = True
                        except Exception:
                            rendered = False
                        if not rendered:
                            # Diagnostic structure only; scrub the synthetic setup
                            # key and credentials before writing any evidence.
                            diagnostic = page.locator('[aria-label]').evaluate_all("nodes => nodes.map(n => ({tag:n.tagName,role:n.getAttribute('role'),label:n.getAttribute('aria-label'),owns:n.getAttribute('aria-owns'),value:n.getAttribute('aria-valuetext')}))")
                            safe = json.dumps(diagnostic).replace(seed, '[setup-key]').replace(email, '[synthetic-email]').replace(password, '[synthetic-password]')
                            result['diagnosticSemantics'] = json.loads(safe)
                        must(rendered, 'setup key is rendered in Flutter semantics')
                        # Rejection must clear the actual accessible editing input.
                        step = 'deny wrong code'
                        counter = int(time.time()) // 30
                        wrong = next(str(n).zfill(6) for n in range(10) if str(n).zfill(6) not in [totp(seed, counter), totp(seed, counter - 1)])
                        status, data = factor(wrong)
                        must(status == 401 and 'token' not in data, 'wrong factor denied without authority')
                        expect(field('mfa-code')).to_have_value('')
                        must(db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s', (user,)).fetchone()[0] == 0, 'wrong factor creates no database session')
                        step = 'enroll and confirm identity'
                        status, data = factor(totp(seed, int(time.time()) // 30))
                        must(status == 200 and data.get('status') == 'authenticated', 'valid factor accepted')
                        token = data['token']
                        page.wait_for_url(lambda u: '/success' == __import__('urllib.parse', fromlist=['urlsplit']).urlsplit(u).path, timeout=30000)
                        page.wait_for_function("t => JSON.parse(localStorage.getItem('flutter.auth_token')) === t", arg=token)
                        record = db.execute('SELECT u.status,c.enabled,c.envelope FROM users u JOIN auth_mfa_credentials c ON c.user_id=u.id::text WHERE u.id::text=%s', (user,)).fetchone()
                        must(record[0] == 'active' and record[1] and seed not in json.dumps(record[2]), 'activation and encrypted credential persisted')
                        must(api('/v1/auth/me', token=token)[1].get('userId') == user, 'gateway identity matches synthetic account')
                        must(db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s AND token_hash=%s', (user, hashlib.sha256(token.encode()).hexdigest())).fetchone()[0] == 1, 'browser session matches hashed database record')
                        must(db.execute("SELECT COUNT(*) FROM auth_mfa_audit WHERE user_id=%s AND action='mfa_enrolled'", (user,)).fetchone()[0] == 1, 'enrollment audit committed')
                        must(seed not in page.evaluate('JSON.stringify(localStorage)') and challenge['challenge'] not in page.evaluate('JSON.stringify(localStorage)'), 'challenge and setup key are not persisted')
                        step = 'reload logout and enrolled verification'
                        page.reload(wait_until='domcontentloaded')
                        signout = page.get_by_role('button', name=labels[locale]['signout'], exact=True)
                        signout.wait_for(timeout=30000)
                        must(page.locator('[aria-label^="mfa-seed"]').count() == 0, 'reload retains session without displaying seed')
                        with page.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/logout') and r.request.method == 'POST') as ended:
                            signout.click()
                        must(ended.value.status == 200, 'server acknowledged initial signout')
                        field('login-email').wait_for()
                        must(api('/v1/auth/me', token=token)[0] == 401, 'logout revokes server session')
                        enrolled = exchange()
                        must(enrolled['purpose'] == 'verify' and 'setupKey' not in enrolled, 'enrolled login never returns setup key')
                        must(page.locator('[aria-label^="mfa-seed"]').count() == 0, 'enrolled prompt never renders setup key')
                        accepted = db.execute('SELECT last_counter FROM auth_mfa_credentials WHERE user_id=%s', (user,)).fetchone()[0]
                        status, _ = factor(totp(seed, int(accepted)))
                        must(status == 401, 'consumed factor replay denied')
                        expect(field('mfa-code')).to_have_value('')
                        while int(time.time()) // 30 <= int(accepted):
                            page.wait_for_timeout(1000)
                        step = 'fresh enrolled factor submission'
                        status, data = factor(totp(seed, int(time.time()) // 30))
                        must(status == 200, 'fresh enrolled factor accepted')
                        step = 'fresh enrolled browser identity confirmation'
                        page.wait_for_url(lambda u: '/success' == __import__('urllib.parse', fromlist=['urlsplit']).urlsplit(u).path, timeout=30000)
                        page.wait_for_function("t => JSON.parse(localStorage.getItem('flutter.auth_token')) === t", arg=data['token'])
                        must(api('/v1/auth/me', token=data['token'])[1].get('userId') == user, 'fresh enrolled session identity matches account')
                        token = data['token']
                        if os.environ.get('VERIFY_MFA_LIFECYCLE') == '1':
                            from flutter_mfa_lifecycle import verify_lifecycle
                            step = 'MFA management replacement and lost-factor recovery'
                            token, seed = verify_lifecycle(page, db, user=user, tenant=tenant, password=password,
                                seed=seed, token=token, field=field, button=button, api=api, totp=totp,
                                must=must, exchange=exchange)
                            from flutter_privileged_access import verify_privileged
                            step = 'temporary elevation and explicit tenant support approval'
                            verify_privileged(page, db, user=user, tenant=tenant, password=password, seed=seed,
                                token=token, locale=locale, field=field, button=button, api=api, totp=totp, must=must)
                        step = 'acknowledged final logout and signed-out reload'
                        page.get_by_role('button', name=labels[locale]['signout'], exact=True).wait_for(timeout=30000)
                        with page.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/logout') and r.request.method == 'POST') as ended:
                            page.get_by_role('button', name=labels[locale]['signout'], exact=True).click()
                        must(ended.value.status == 200, 'server acknowledged final signout')
                        field('login-email').wait_for()
                        page.reload(wait_until='domcontentloaded')
                        field('login-email').wait_for()
                        must(api('/v1/auth/me', token=token)[0] == 401 and page.evaluate("localStorage.getItem('flutter.auth_token')") is None, 'signed-out reload has no local or server authority')
                        build()
                        result.pop('identityStatuses', None)
                        result['passed'] = True
                    except Exception:
                        result['failedStep'] = step
                        result['browserState'] = {
                            'path': __import__('urllib.parse', fromlist=['urlsplit']).urlsplit(page.url).path,
                            'hasStoredAuthority': page.evaluate("localStorage.getItem('flutter.auth_token') !== null"),
                            'factorPending': field('mfa-code').count() > 0,
                            'loginVisible': field('login-email').count() > 0,
                            'serverSessions': db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s', (user,)).fetchone()[0],
                        }
                        # Upstream browser exceptions may include input values.
                        raise RuntimeError('Live Flutter MFA failed at: ' + step) from None
                    finally:
                        context.close()
                        if created:
                            with db.transaction():
                                must(db.execute('SELECT email,tenant_id::text FROM users WHERE id::text=%s', (user,)).fetchall() == [(email, tenant)], 'cleanup identity guard')
                                must(db.execute('SELECT slug FROM tenants WHERE id::text=%s', (tenant,)).fetchall() == [(slug,)], 'cleanup tenant guard')
                                db.execute('DELETE FROM auth_privileged_access_audit WHERE actor_user_id=%s', (user,))
                                db.execute('DELETE FROM auth_tenant_support_requests WHERE requester_user_id=%s', (user,))
                                db.execute('DELETE FROM auth_privilege_elevations WHERE user_id=%s', (user,))
                                for table in ['auth_mfa_notification_outbox', 'auth_mfa_lifecycle_audit', 'auth_mfa_recovery_codes', 'auth_mfa_replacement_challenges', 'auth_sessions', 'auth_mfa_challenges', 'auth_mfa_credentials', 'auth_mfa_audit', 'auth_password_resets', 'auth_password_audit']:
                                    db.execute('DELETE FROM ' + table + ' WHERE user_id::text=%s', (user,))
                                db.execute('DELETE FROM auth_rate_limits WHERE subject_hash IN (%s,%s,%s)', (hashlib.sha256(('login:' + email).encode()).hexdigest(), hashlib.sha256(('mfa-lifecycle:' + user).encode()).hexdigest(), hashlib.sha256(('privileged-read:' + user).encode()).hexdigest()))
                                db.execute('DELETE FROM users WHERE id::text=%s AND email=%s AND tenant_id::text=%s', (user, email, tenant))
                                db.execute('DELETE FROM tenants WHERE id::text=%s AND slug=%s', (tenant, slug))
                            result['cleanup'] = True
                        (OUT / 'receipt.json').write_text(json.dumps(report, indent=2))
            finally:
                browser.close()
        report['passed'] = all(r.get('passed') and r['cleanup'] for r in report['results']) and len(report['results']) == 3
        assert report['passed']
        print('LIVE_FLUTTER_MFA ' + json.dumps(report))
    finally:
        db.close()
        (OUT / 'receipt.json').write_text(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
