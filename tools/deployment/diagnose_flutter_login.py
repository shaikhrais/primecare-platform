"""Probe the existing login UI with a unique, deliberately nonexistent account."""
import os
import sys
sys.path.insert(0,os.getcwd())
from tools.deployment.flutter_browser import fill_flutter_field
import json
import secrets
import uuid
from urllib.parse import urlsplit
from playwright.sync_api import sync_playwright

report = {'synthetic_nonexistent_account': True, 'email_requested': False, 'events': []}
email = 'qa-no-account-' + uuid.uuid4().hex + '@example.test'
password = secrets.token_urlsafe(24)
def safe(error):
    return str(error).replace(email, '[synthetic-email]').replace(password, '[synthetic-password]')[:600]
def event(kind, request, status=None):
    url = urlsplit(request.url)
    if '/auth/' in url.path or request.resource_type in ('fetch', 'xhr'):
        report['events'].append({'kind': kind, 'host': url.hostname, 'path': url.path, 'method': request.method, 'status': status})
with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page(viewport={'width': 320, 'height': 1000}, locale='en')
    page.on('request', lambda r: event('request', r))
    page.on('response', lambda r: event('response', r.request, r.status))
    page.on('requestfailed', lambda r: event('request_failed', r))
    page.on('pageerror', lambda e: report.setdefault('page_errors', []).append(safe(e)))
    try:
        page.goto('https://primecare-clinic.pages.dev/login?enable-semantics=true', wait_until='domcontentloaded')
        field_email = page.get_by_role('textbox', name=__import__('re').compile(r'^login-email\b'))
        field_password = page.get_by_role('textbox', name=__import__('re').compile(r'^login-password\b'))
        fill_flutter_field(page, field_email, email)
        fill_flutter_field(page, field_password, password)
        report['input_lengths'] = [len(field_email.input_value()), len(field_password.input_value())]
        report['button_semantics'] = page.locator('[role="button"]').evaluate_all('(els)=>els.map(e=>({label:e.getAttribute("aria-label"),text:e.textContent,disabled:e.getAttribute("aria-disabled")}))')
        submit = page.locator('[aria-label="login-submit"][role="button"], [aria-label="login-submit"] [role="button"]')
        report['matching_buttons'] = submit.count()
        submit.click()
        page.wait_for_timeout(5000)
        report['after_click_notices'] = [s for s in ['Please enter both credentials.', 'Authentication failed. Please verify your credentials.', 'A connection error occurred. Please try again.'] if page.get_by_text(s, exact=True).count()]
        report['click_events'] = len(report['events'])
        if not report['events']:
            field_password.press('Enter')
            page.wait_for_timeout(5000)
            report['after_enter_notices'] = [s for s in ['Please enter both credentials.', 'Authentication failed. Please verify your credentials.', 'A connection error occurred. Please try again.'] if page.get_by_text(s, exact=True).count()]
        report['final_path'] = urlsplit(page.url).path
    except Exception as e:
        report['error'] = safe(e)
    finally:
        browser.close()
print('LOGIN_UI_DIAGNOSIS ' + json.dumps(report))
