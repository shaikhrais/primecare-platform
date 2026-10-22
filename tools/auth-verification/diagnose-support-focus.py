"""Synthetic focus diagnostics only; never auth acceptance or review evidence."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import secrets
import sys
import time
import uuid
import bcrypt
import psycopg
from playwright.sync_api import sync_playwright

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
spec = importlib.util.spec_from_file_location('live_mfa', Path(__file__).with_name('test-live-flutter-mfa.py'))
live = importlib.util.module_from_spec(spec)
spec.loader.exec_module(live)
OUT = Path('test-results/support-focus')
IDS = ['mfa-lifecycle-password', 'mfa-lifecycle-factor', 'mfa-elevation-password', 'mfa-elevation-factor', 'mfa-elevation-reason']


def main():
    assert os.environ.get('DIAGNOSE_SUPPORT_FOCUS') == '1'
    OUT.mkdir(parents=True, exist_ok=True)
    report = {'source': os.environ['GITHUB_SHA'], 'synthetic': True, 'acceptanceCredit': False, 'ownerAccountTouched': False, 'cleanup': False, 'cases': []}
    tenant, user = str(uuid.uuid4()), str(uuid.uuid4())
    email, password = 'focus-' + user + '@example.invalid', secrets.token_urlsafe(30)
    slug = 'focus-' + tenant
    db = psycopg.connect(os.environ['PRODUCTION_DATABASE_URL'], autocommit=True, connect_timeout=15)
    created = False
    try:
        with db.transaction():
            db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary focus QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)", (tenant, slug))
            db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,'code_admin',%s,'mfa_pending',NOW())", (user, email, tenant, bcrypt.hashpw(password.encode(), bcrypt.gensalt(12)).decode()))
        created = True
        status, challenge = live.api('/v1/auth/login', {'email': email, 'password': password})
        assert status == 200 and challenge.get('purpose') == 'enroll'
        status, signed = live.api('/v1/auth/mfa', {'challenge': challenge['challenge'], 'code': live.totp(challenge['setupKey'], int(time.time()) // 30)})
        assert status == 200 and signed.get('userId') == user
        token = signed['token']
        assert live.api('/v1/auth/me', token=token)[1].get('userId') == user
        with sync_playwright() as pw:
            browser = pw.chromium.launch()
            try:
                for mode in ['click_helper', 'dom_focus', 'keyboard_tab']:
                    case = {'mode': mode}
                    report['cases'].append(case)
                    context = browser.new_context(viewport={'width': 320, 'height': 1000}, locale='en')
                    context.add_init_script("localStorage.setItem('flutter.auth_token'," + json.dumps(json.dumps(token)) + ");")
                    context.add_init_script('''window.focusTrace=[];for(const kind of ['focusin','focusout'])document.addEventListener(kind,e=>{
                      const name=e.target.getAttribute?.('aria-label')||'';
                      const id=['mfa-lifecycle-password','mfa-lifecycle-factor','mfa-elevation-password','mfa-elevation-factor','mfa-elevation-reason'].find(id=>name.startsWith(id))||'other';
                      if(window.focusTrace.length<100)window.focusTrace.push({kind,id,tag:e.target.tagName,type:e.target.type||'',length:typeof e.target.value==='string'?e.target.value.length:null});
                    },true)''')
                    page = context.new_page()
                    target = page.get_by_role('textbox', name=re.compile(r'^mfa-elevation-password\b'))
                    try:
                        page.goto(live.SITE + '/language?locale=en&enable-semantics=true', wait_until='domcontentloaded')
                        page.get_by_role('button', name='English', exact=True).click()
                        page.goto(live.SITE + '/success?locale=en&enable-semantics=true', wait_until='domcontentloaded')
                        page.locator('[aria-label="mfa-lifecycle-manage"][role="button"], [aria-label="mfa-lifecycle-manage"] [role="button"]').click()
                        target.wait_for()
                        if mode == 'click_helper':
                            live.fill_flutter_field(page, target, password)
                        elif mode == 'dom_focus':
                            target.focus()
                            page.wait_for_timeout(300)
                            target.press_sequentially(password, delay=10)
                        else:
                            for _ in range(30):
                                if target.evaluate("e=>e.matches(':focus')"):
                                    break
                                page.keyboard.press('Tab')
                            page.keyboard.type(password, delay=10)
                        page.wait_for_timeout(300)
                        case['matches'] = target.input_value() == password
                    except Exception as error:
                        case['failureKind'] = type(error).__name__ if type(error).__name__ in ['AssertionError', 'TimeoutError', 'Error'] else 'diagnostic_error'
                    finally:
                        case['inputs'] = page.locator('input').evaluate_all('''els=>els.map(e=>({name:(e.getAttribute('aria-label')||'').split(' ')[0],length:e.value.length,focused:e.matches(':focus'),disabled:e.disabled,top:Math.round(e.getBoundingClientRect().top)})).filter(e=>['mfa-lifecycle-password','mfa-lifecycle-factor','mfa-elevation-password','mfa-elevation-factor','mfa-elevation-reason'].includes(e.name))''')
                        case['focusTrace'] = page.evaluate('window.focusTrace||[]')
                        context.close()
            finally:
                browser.close()
    finally:
        if created:
            with db.transaction():
                assert db.execute('SELECT email,tenant_id::text FROM users WHERE id::text=%s', (user,)).fetchall() == [(email, tenant)]
                assert db.execute('SELECT slug FROM tenants WHERE id::text=%s', (tenant,)).fetchall() == [(slug,)]
                for table in ['auth_sessions', 'auth_mfa_challenges', 'auth_mfa_credentials', 'auth_mfa_audit']:
                    db.execute('DELETE FROM ' + table + ' WHERE user_id::text=%s', (user,))
                db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s', (hashlib.sha256(('login:' + email).encode()).hexdigest(),))
                db.execute('DELETE FROM users WHERE id::text=%s AND email=%s AND tenant_id::text=%s', (user, email, tenant))
                db.execute('DELETE FROM tenants WHERE id::text=%s AND slug=%s', (tenant, slug))
            report['cleanup'] = True
        db.close()
        (OUT / 'diagnostic.json').write_text(json.dumps(report, indent=2))
    print('Synthetic support focus diagnostic saved; no acceptance credit.')


if __name__ == '__main__':
    try:
        main()
    except Exception:
        raise RuntimeError('Synthetic support focus diagnostic failed; inspect sanitized artifact') from None
