"""Optional extension of the source-bound synthetic live Flutter MFA journey.
Never emit codes, setup keys, passwords, tokens or browser exception details.
"""
import hashlib
import json
import re
import time
from playwright.sync_api import expect
from tools.deployment.flutter_browser import fill_flutter_field


def verify_lifecycle(page, db, *, user, tenant, password, seed, token, field, button, api, totp, must, exchange):
    def fresh_code(current_seed):
        accepted = int(db.execute('SELECT last_counter FROM auth_mfa_credentials WHERE user_id=%s', (user,)).fetchone()[0])
        while int(time.time()) // 30 <= accepted:
            page.wait_for_timeout(500)
        return totp(current_seed, int(time.time()) // 30)

    def proof(current_seed, action):
        fill_flutter_field(page, field('mfa-lifecycle-password'), password)
        fill_flutter_field(page, field('mfa-lifecycle-factor'), fresh_code(current_seed))
        with page.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/mfa/' + action) and r.request.method == 'POST') as response:
            button('mfa-lifecycle-issue' if action == 'recovery-codes' else 'mfa-lifecycle-replace').click()
        must(response.value.status == 200, 'fresh owned proof accepted for ' + action)
        result = response.value.json()
        must('token' not in result, 'management response never grants session authority')
        return result

    def rendered(identifier, values):
        control = page.locator('[aria-label="' + identifier + '"]')
        for value in values:
            expect(control).to_contain_text(value, timeout=15000)

    def transient(values):
        stored = page.evaluate('JSON.stringify(localStorage)+JSON.stringify(sessionStorage)')
        must(all(value not in stored for value in values), 'lifecycle proof material is not persisted')

    button('mfa-lifecycle-manage').click()
    field('mfa-lifecycle-password').wait_for(timeout=30000)
    issued = proof(seed, 'recovery-codes')
    codes = issued.get('recoveryCodes')
    must(issued.get('status') == 'recovery_codes_issued' and isinstance(codes, list) and len(codes) == 10 and len(set(codes)) == 10 and all(re.fullmatch('[A-Z2-7]{26}', value) for value in codes), 'ten unique saved recovery codes returned once')
    rendered('mfa-lifecycle-codes', codes)
    rows = db.execute('SELECT code_hash,consumed_at FROM auth_mfa_recovery_codes WHERE user_id=%s AND tenant_id=%s', (user, tenant)).fetchall()
    must(len(rows) == 10 and all(re.fullmatch('[a-f0-9]{64}', row[0]) and row[1] is None for row in rows) and all(value not in json.dumps(rows, default=str) for value in codes), 'saved codes persist only as unused context-bound hashes')
    transient(codes)
    button('mfa-lifecycle-saved').click()
    expect(page.locator('[aria-label^="mfa-lifecycle-codes"]')).to_have_count(0)
    page.reload(wait_until='domcontentloaded')
    field('mfa-lifecycle-password').wait_for(timeout=30000)
    must(page.locator('[aria-label^="mfa-lifecycle-codes"]').count() == 0, 'reload cannot redisplay saved codes')

    before = db.execute('SELECT envelope FROM auth_mfa_credentials WHERE user_id=%s', (user,)).fetchone()[0]
    abandoned = proof(seed, 'replacement')
    must(abandoned.get('status') == 'mfa_replacement_required', 'replacement starts with limited challenge')
    rendered('mfa-lifecycle-newkey', [abandoned['setupKey']])
    transient([abandoned['setupKey'], abandoned['challenge']])
    button('mfa-lifecycle-cancel').click()
    field('mfa-lifecycle-password').wait_for()
    must(db.execute('SELECT envelope FROM auth_mfa_credentials WHERE user_id=%s', (user,)).fetchone()[0] == before and api('/v1/auth/me', token=token)[0] == 200, 'cancel retains working factor and current server session')
    must(page.locator('[aria-label^="mfa-lifecycle-newkey"]').count() == 0, 'cancel removes replacement setup key')

    replacement = proof(seed, 'replacement')
    must(replacement['setupKey'] != abandoned['setupKey'], 'fresh replacement abandons the previous pending factor')
    must(api('/v1/auth/mfa/replacement/confirm', {'challenge': abandoned['challenge'], 'code': totp(abandoned['setupKey'], int(time.time()) // 30)})[0] == 401, 'abandoned replacement cannot grant authority')
    rendered('mfa-lifecycle-newkey', [replacement['setupKey']])
    fill_flutter_field(page, field('mfa-lifecycle-newcode'), totp(replacement['setupKey'], int(time.time()) // 30))
    with page.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/mfa/replacement/confirm') and r.request.method == 'POST') as response:
        button('mfa-lifecycle-confirm').click()
    confirmed = response.value.json()
    must(response.value.status == 200 and confirmed.get('status') == 'authenticated', 'new authenticator confirmation replaces factor')
    old_token, token, seed = token, confirmed['token'], replacement['setupKey']
    page.wait_for_function("t => JSON.parse(localStorage.getItem('flutter.auth_token')) === t", arg=token)
    must(api('/v1/auth/me', token=old_token)[0] == 401 and api('/v1/auth/me', token=token)[1].get('userId') == user, 'replacement revokes old session and confirms new owned identity')
    must(db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s', (user,)).fetchone()[0] == 1 and db.execute('SELECT COUNT(*) FROM auth_mfa_recovery_codes WHERE user_id=%s', (user,)).fetchone()[0] == 0, 'replacement leaves one hashed session and invalidates previous saved codes')
    transient(codes + [seed, replacement['challenge']])
    page.reload(wait_until='domcontentloaded')
    field('mfa-lifecycle-password').wait_for(timeout=30000)
    must(page.locator('[aria-label^="mfa-lifecycle-newkey"]').count() == 0, 'replacement reload retains authority without setup key')

    issued = proof(seed, 'recovery-codes')
    saved = issued['recoveryCodes'][0]
    rendered('mfa-lifecycle-codes', issued['recoveryCodes'])
    transient(issued['recoveryCodes'])
    # Revoke through the gateway, then open the registered login route. A
    # reload stays on /mfa, which is public and has no challenge after reload.
    must(api('/v1/auth/logout', {}, token=token)[0] == 200, 'owned session revoked before lost-factor recovery')
    from urllib.parse import urlsplit, urlunsplit
    location = urlsplit(page.url)
    page.goto(urlunsplit((location.scheme, location.netloc, '/login', location.query, '')), wait_until='domcontentloaded')
    field('login-email').wait_for(timeout=30000)
    login = exchange()
    must(login.get('purpose') == 'verify' and 'setupKey' not in login, 'lost-factor recovery begins with password-verified limited challenge')
    button('mfa-lifecycle-recovery').click()
    fill_flutter_field(page, field('mfa-lifecycle-recoverycode'), saved)
    with page.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/mfa/recovery') and r.request.method == 'POST') as response:
        button('mfa-lifecycle-recover').click()
    recovery = response.value.json()
    must(response.value.status == 200 and recovery.get('status') == 'mfa_replacement_required' and 'token' not in recovery, 'saved code grants only a new-factor challenge')
    rendered('mfa-lifecycle-newkey', [recovery['setupKey']])
    must(page.evaluate("localStorage.getItem('flutter.auth_token')") is None and db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s', (user,)).fetchone()[0] == 0, 'saved-code proof grants no browser or database session')
    must(db.execute('SELECT COUNT(*) FROM auth_mfa_recovery_codes WHERE user_id=%s AND consumed_at IS NOT NULL', (user,)).fetchone()[0] == 1, 'saved recovery code is atomically consumed once')
    must(api('/v1/auth/mfa/recovery', {'challenge': login['challenge'], 'recoveryCode': saved})[0] == 401, 'consumed password and saved-code proof cannot be replayed')
    transient([saved, recovery['setupKey'], recovery['challenge']])
    current = int(time.time()) // 30
    wrong = next(str(n).zfill(6) for n in range(10) if str(n).zfill(6) not in [totp(recovery['setupKey'], current), totp(recovery['setupKey'], current - 1)])
    def confirm(code):
        fill_flutter_field(page, field('mfa-lifecycle-newcode'), code)
        with page.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/mfa/replacement/confirm') and r.request.method == 'POST') as response:
            button('mfa-lifecycle-confirm').click()
        return response.value.status, response.value.json()
    status, _ = confirm(wrong)
    must(status == 401, 'wrong recovered authenticator code grants no authority')
    expect(field('mfa-lifecycle-newcode')).to_have_value('')
    must(db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s', (user,)).fetchone()[0] == 0, 'wrong new-factor proof creates no server session')
    status, confirmed = confirm(totp(recovery['setupKey'], int(time.time()) // 30))
    must(status == 200 and confirmed.get('status') == 'authenticated', 'lost-factor recovery requires confirmation of new authenticator')
    token = confirmed['token']
    page.wait_for_function("t => JSON.parse(localStorage.getItem('flutter.auth_token')) === t", arg=token)
    must(api('/v1/auth/me', token=token)[1].get('userId') == user and db.execute('SELECT COUNT(*) FROM auth_sessions WHERE user_id::text=%s AND token_hash=%s', (user, hashlib.sha256(token.encode()).hexdigest())).fetchone()[0] == 1, 'recovered browser authority matches owned hashed server session')
    must(db.execute('SELECT COUNT(*) FROM auth_mfa_recovery_codes WHERE user_id=%s', (user,)).fetchone()[0] == 0 and db.execute('SELECT COUNT(*) FROM auth_mfa_replacement_challenges WHERE user_id=%s', (user,)).fetchone()[0] == 0, 'confirmed recovery invalidates all saved codes and replacement challenges')
    notices = db.execute('SELECT event,locale,state FROM auth_mfa_notification_outbox WHERE user_id=%s', (user,)).fetchall()
    must(len(notices) == 5 and all(row[2] in ['pending', 'sending', 'sent'] for row in notices), 'five lifecycle security notices durably queued or acknowledged')
    page.reload(wait_until='domcontentloaded')
    button('mfa-lifecycle-manage').wait_for(timeout=30000)
    must(page.locator('[aria-label^="mfa-lifecycle-newkey"]').count() == 0, 'recovery reload preserves session without exposing setup key')
    return token, recovery['setupKey']
