"""Compare browser login dispatch using unique nonexistent accounts only."""
import json
import os
import re
import secrets
import sys
import uuid
from urllib.parse import urlsplit
sys.path.insert(0, os.getcwd())
from tools.deployment.flutter_browser import fill_flutter_field, click_flutter_control
from playwright.sync_api import sync_playwright

report = {'synthetic_nonexistent_account': True, 'acceptanceCredit': False, 'email_requested': False, 'cases': []}
with sync_playwright() as pw:
    browser = pw.chromium.launch()
    try:
        for locale, width in [('en', 320), ('fr', 768), ('es', 1440)]:
            for mode in ['direct_click', 'settled_click']:
                case = {'locale': locale, 'width': width, 'mode': mode, 'events': []}
                report['cases'].append(case)
                email, password = 'qa-no-account-' + uuid.uuid4().hex + '@example.test', secrets.token_urlsafe(24)
                context = browser.new_context(viewport={'width': width, 'height': 1000}, locale=locale)
                page = context.new_page()
                def event(kind, request, status=None):
                    location = urlsplit(request.url)
                    if location.path == '/v1/auth/login':
                        case['events'].append({'kind': kind, 'method': request.method, 'status': status})
                page.on('request', lambda request: event('request', request))
                page.on('response', lambda response: event('response', response.request, response.status))
                try:
                    case['stage'] = 'select language'
                    page.goto('https://primecare-clinic.pages.dev/language?locale=' + locale + '&enable-semantics=true', wait_until='domcontentloaded')
                    page.get_by_role('button', name={'en':'English','fr':'Français','es':'Español'}[locale], exact=True).click()
                    page.goto('https://primecare-clinic.pages.dev/login?locale=' + locale + '&enable-semantics=true', wait_until='domcontentloaded')
                    case['stage'] = 'enter email'
                    email_field = page.get_by_role('textbox', name=re.compile(r'^login-email\b'))
                    fill_flutter_field(page, email_field, email)
                    case['stage'] = 'enter password'
                    password_field = page.get_by_role('textbox', name=re.compile(r'^login-password\b'))
                    fill_flutter_field(page, password_field, password)
                    case['input_lengths'] = [len(email_field.input_value()), len(password_field.input_value())]
                    control = page.locator('[aria-label="login-submit"][role="button"], [aria-label="login-submit"] [role="button"]')
                    case['stage'] = 'submit login'
                    with page.expect_response(lambda response: urlsplit(response.url).path == '/v1/auth/login' and response.request.method == 'POST') as response:
                        if mode == 'settled_click':
                            click_flutter_control(control)
                        else:
                            control.click()
                    case['status'] = response.value.status
                    case['rejected_nonexistent_account'] = response.value.status == 401
                    case['stage'] = 'complete'
                except Exception as error:
                    case['failureKind'] = type(error).__name__ if type(error).__name__ in ['AssertionError','TimeoutError','Error'] else 'diagnostic_error'
                    case['path'] = urlsplit(page.url).path
                finally:
                    context.close()
    finally:
        browser.close()
print('LOGIN_UI_DIAGNOSIS ' + json.dumps(report))
