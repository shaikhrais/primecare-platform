"""Synthetic deployed Flutter temporary-support proof; no clinical access.
Evidence contains check names only, never passwords, session tokens or factors.
"""
import bcrypt
import hashlib
import json
from pathlib import Path
import re
import secrets
import time
import uuid
from playwright.sync_api import expect
from tools.deployment.flutter_browser import fill_flutter_field, click_flutter_control


def verify_privileged(page, db, *, user, tenant, password, seed, token, locale, field, button, api, totp, must, checkpoint):
    target, admin, member = [str(uuid.uuid4()) for _ in range(3)]
    slug = 'flutter-support-' + target
    email, admin_password = 'flutter-support-' + admin + '@example.invalid', secrets.token_urlsafe(30)
    created = False
    context = page.context.browser.new_context(viewport=page.viewport_size, locale=locale)
    approval = context.new_page()

    def admin_field(name):
        return approval.get_by_role('textbox', name=re.compile('^' + re.escape(name) + r'\b'))

    def admin_button(name):
        return approval.locator('[aria-label="' + name + '"][role="button"], [aria-label="' + name + '"] [role="button"]')

    def response_click(surface, control, suffix, method='POST'):
        expect(control).to_be_enabled(timeout=15000)
        checkpoint('support request ' + suffix)
        with surface.expect_response(lambda r: r.url.split('?')[0].endswith('/v1/auth/' + suffix) and r.request.method == method) as response:
            click_flutter_control(control)
        checkpoint('support response ' + suffix, response.value.status)
        return response.value.status, response.value.json()

    try:
        with db.transaction():
            db.execute("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES(%s,'Temporary Flutter support QA',%s,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)", (target, slug))
            hashed = bcrypt.hashpw(admin_password.encode(), bcrypt.gensalt(12)).decode()
            for actor, address, role in [(admin, email, 'tenant_admin'), (member, 'flutter-support-' + member + '@example.invalid', 'client')]:
                db.execute("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES(%s,%s,%s,%s,%s,'active',NOW())", (actor, address, target, role, hashed))
        created = True
        accepted = int(db.execute('SELECT last_counter FROM auth_mfa_credentials WHERE user_id=%s', (user,)).fetchone()[0])
        while int(time.time()) // 30 <= accepted:
            page.wait_for_timeout(500)
        checkpoint('open support management')
        click_flutter_control(button('mfa-lifecycle-manage'))
        checkpoint('enter support password')
        fill_flutter_field(page, field('mfa-elevation-password'), password)
        checkpoint('enter support factor')
        fill_flutter_field(page, field('mfa-elevation-factor'), totp(seed, int(time.time()) // 30))
        checkpoint('enter support reason')
        fill_flutter_field(page, field('mfa-elevation-reason'), 'Investigate synthetic tenant sign-in counts')
        status, elevated = response_click(page, button('mfa-elevation-elevate'), 'mfa/elevation')
        must(status == 200 and elevated.get('status') == 'elevated' and elevated.get('scope') == ['tenant_security_summary'] and 'token' not in elevated, 'fresh factor creates only scoped temporary elevation')
        fill_flutter_field(page, field('mfa-elevation-tenant'), target)
        fill_flutter_field(page, field('mfa-elevation-ticket'), 'SYNTHETIC-SUPPORT')
        status, request = response_click(page, button('mfa-elevation-request'), 'mfa/support/request')
        must(status == 200 and request.get('state') == 'pending' and request.get('tenantId') == target, 'support request requires explicit target approval')
        request_id = request['requestId']
        status, denied = response_click(page, button('mfa-elevation-summary'), 'mfa/support/summary')
        must(status == 403 and 'activeAccounts' not in denied, 'unapproved support reveals no aggregate')
        expect(page.locator('[aria-label="mfa-elevation-summaryvalues"]')).to_have_count(0)

        site = 'https://primecare-clinic.pages.dev'
        approval.goto(site + '/language?locale=' + locale + '&enable-semantics=true', wait_until='domcontentloaded')
        click_flutter_control(approval.get_by_role('button', name={'en':'English','fr':'Français','es':'Español'}[locale], exact=True))
        approval.goto(site + '/login?locale=' + locale + '&enable-semantics=true', wait_until='domcontentloaded')
        fill_flutter_field(approval, admin_field('login-email'), email)
        fill_flutter_field(approval, admin_field('login-password'), admin_password)
        status, logged = response_click(approval, admin_button('login-submit'), 'login')
        must(status == 200 and logged.get('role') == 'tenant_admin' and logged.get('userId') == admin, 'target tenant administrator signs in through deployed Flutter')
        admin_token = logged['token']
        checkpoint('confirm tenant administrator session')
        approval.wait_for_function("t => JSON.parse(localStorage.getItem('flutter.auth_token')) === t", arg=admin_token)
        must(api('/v1/auth/me', token=admin_token)[1].get('userId') == admin, 'tenant administrator browser session matches current server identity')
        # Tenant admins land on their governed role dashboard. Approval lives on
        # the registered account page, so visit it after confirmed sign-in.
        checkpoint('open tenant account approval controls')
        approval.goto(site + '/success?locale=' + locale + '&enable-semantics=true', wait_until='domcontentloaded')
        approve_id = 'mfa-elevation-approve-' + request_id
        status, listed = response_click(approval, admin_button('mfa-elevation-refresh'), 'mfa/support/requests', method='GET')
        must(status == 200 and [r.get('requestId') for r in listed.get('requests',[])] == [request_id], 'tenant refresh lists only the exact scoped pending request')
        admin_button(approve_id).wait_for(timeout=30000)
        fill_flutter_field(approval, admin_field('mfa-elevation-approvalpassword'), 'deliberately-wrong')
        status, _ = response_click(approval, admin_button(approve_id), 'mfa/support/approve')
        must(status == 401 and api('/v1/auth/me', token=admin_token)[0] == 200, 'wrong approval password denies grant while preserving valid administrator session')
        expect(admin_field('mfa-elevation-approvalpassword')).to_have_value('')
        fill_flutter_field(approval, admin_field('mfa-elevation-approvalpassword'), admin_password)
        status, granted = response_click(approval, admin_button(approve_id), 'mfa/support/approve')
        must(status == 200 and granted.get('status') == 'approved', 'fresh tenant password explicitly approves support')
        status, summary = response_click(page, button('mfa-elevation-summary'), 'mfa/support/summary')
        must(status == 200 and summary == {'tenantId':target,'activeAccounts':2,'activeSessions':1,'enrolledAuthenticators':0}, 'approved support returns only exact synthetic tenant security counts')
        values = page.locator('[aria-label="mfa-elevation-summaryvalues"]')
        values.wait_for(timeout=15000)
        copy = json.loads(Path('packages/shared/src/auth-elevation.json').read_text())['locales'][locale]
        for key, count in [('activeAccounts',2),('activeSessions',1),('enrolledAuthenticators',0)]:
            expect(values).to_contain_text(copy[key].replace('{count}',str(count)))
        must(True, 'localized aggregate values render in Flutter semantics')
        must(db.execute("SELECT COUNT(*) FROM auth_privileged_access_audit WHERE actor_user_id=%s AND target_tenant_id=%s AND action='security_summary_read'", (user, target)).fetchone()[0] == 1, 'support read has committed actor and target audit')
        stored = db.execute('SELECT session_hash,expires_at<=created_at+INTERVAL \'15 minutes\' FROM auth_privilege_elevations WHERE id=%s', (elevated['elevationId'],)).fetchone()
        must(stored == (hashlib.sha256(token.encode()).hexdigest(), True), 'temporary elevation is hashed-session bound and at most fifteen minutes')
        must(api('/v1/auth/me', token=token)[1].get('roles') == 'code_admin', 'support never changes active actor role')
        fill_flutter_field(approval, admin_field('mfa-elevation-approvalpassword'), admin_password)
        status, revoked = response_click(approval, admin_button('mfa-elevation-reject-' + request_id), 'mfa/support/revoke')
        must(status == 200 and revoked.get('status') == 'revoked', 'tenant administrator can revoke approved support')
        status, denied = response_click(page, button('mfa-elevation-summary'), 'mfa/support/summary')
        must(status == 403 and 'activeAccounts' not in denied, 'revoked support cannot reveal a later aggregate')
        expect(page.locator('[aria-label="mfa-elevation-summaryvalues"]')).to_have_count(0)
        status, ended = response_click(page, button('mfa-elevation-revoke'), 'mfa/elevation/revoke')
        must(status == 200 and ended.get('status') == 'revoked', 'requester explicitly ends temporary elevation')
        must(api('/v1/auth/mfa/support/summary', {'requestId':request_id}, token=token)[0] == 403, 'ended elevation has no remaining support authority')
        page.reload(wait_until='domcontentloaded')
        field('mfa-elevation-password').wait_for(timeout=30000)
        must(page.locator('[aria-label="mfa-elevation-summaryvalues"]').count() == 0 and page.locator('[aria-label="mfa-elevation-summary"]').count() == 0, 'reload retains account session without temporary support state')
        must(api('/v1/auth/logout', {}, token=admin_token)[0] == 200, 'synthetic tenant administrator session is revoked')
        # Parent journey expects the registered account sign-out control.
        page.goto(site + '/success?locale=' + locale + '&enable-semantics=true', wait_until='domcontentloaded')
    finally:
        context.close()
        if created:
            with db.transaction():
                must(db.execute('SELECT slug FROM tenants WHERE id::text=%s', (target,)).fetchall() == [(slug,)] and set(db.execute('SELECT id::text FROM users WHERE tenant_id::text=%s', (target,)).fetchall()) == {(admin,), (member,)}, 'support cleanup exact fixture identity guard')
                db.execute('DELETE FROM auth_privileged_access_audit WHERE target_tenant_id=%s OR actor_user_id IN (%s,%s)', (target, admin, member))
                db.execute('DELETE FROM auth_tenant_support_requests WHERE target_tenant_id=%s AND requester_user_id=%s', (target, user))
                for actor in [admin, member]:
                    for table in ['auth_sessions','auth_mfa_audit','auth_password_resets','auth_password_audit']:
                        db.execute('DELETE FROM ' + table + ' WHERE user_id::text=%s', (actor,))
                    for subject in ['login:' + ('flutter-support-' + actor + '@example.invalid'), 'mfa-lifecycle:' + actor, 'privileged-read:' + actor]:
                        db.execute('DELETE FROM auth_rate_limits WHERE subject_hash=%s', (hashlib.sha256(subject.encode()).hexdigest(),))
                db.execute('DELETE FROM users WHERE tenant_id::text=%s AND id::text IN (%s,%s)', (target, admin, member))
                db.execute('DELETE FROM tenants WHERE id::text=%s AND slug=%s', (target, slug))
            must(True, 'temporary tenant support fixtures removed')
