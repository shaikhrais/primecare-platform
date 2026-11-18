"""Only verify or create the single approved PrimeCare Cloudflare forward."""
import datetime
import json
import os
import re
import sys
import urllib.error
import urllib.request

DOMAIN = '15minutes-email.com'
ADDRESS = 'primecare-qa@' + DOMAIN
DESTINATION = 'itpro.mohammed@gmail.com'
NAME = 'PrimeCare QA mailbox forwarding'
APPROVAL = f'CREATE {ADDRESS} TO {DESTINATION}'
API = 'https://api.cloudflare.com/client/v4'
ID = re.compile('[0-9a-f]{32}')
RULE = {
    'name': NAME, 'enabled': True,
    'matchers': [{'type': 'literal', 'field': 'to', 'value': ADDRESS}],
    'actions': [{'type': 'forward', 'value': [DESTINATION]}],
}


class Blocked(Exception):
    pass


def require(condition, message):
    if not condition:
        raise Blocked(message)


class NoRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, *args, **kwargs):
        return None


class Client:
    def __init__(self, token, create_path, writes=False):
        self.token = token
        self.create_path = create_path
        self.writes = writes
        self.opener = urllib.request.build_opener(NoRedirect())

    def __call__(self, path, method='GET', body=None):
        if method != 'GET':
            require(self.writes and method == 'POST' and path == self.create_path
                    and body == RULE, 'Unexpected Cloudflare mutation refused')
        else:
            require(body is None, 'Unexpected read body refused')
        require(path.startswith(('/zones/', '/accounts/', '/zones?')), 'Unexpected API path')
        request = urllib.request.Request(API + path, method=method,
            data=None if body is None else json.dumps(body).encode(),
            headers={'Authorization': f'Bearer {self.token}', 'Content-Type': 'application/json',
                     'Accept': 'application/json'})
        try:
            with self.opener.open(request, timeout=20) as reply:
                payload = json.loads(reply.read(2_000_001))
        except (urllib.error.URLError, TimeoutError, OSError, ValueError, UnicodeError):
            raise Blocked('Cloudflare request failed; no API body was logged') from None
        require(isinstance(payload, dict) and payload.get('success') is True
                and not payload.get('errors') and 'result' in payload, 'Cloudflare rejected the requested operation or returned an invalid reply')
        return payload


def obj(client, path):
    result = client(path)['result']
    require(isinstance(result, dict), 'Cloudflare object shape unexpectedly changed')
    return result


def object_id(row):
    value = row.get('id')
    legacy = row.get('tag')
    if value is None:
        value = legacy
    require(isinstance(value, str) and ID.fullmatch(value)
            and (legacy is None or legacy == value), 'Missing or ambiguous resource identifier')
    return value


def pages(client, path):
    rows = []
    seen = set()
    baseline = None
    for p in range(1, 101):
        separator = '&' if '?' in path else '?'
        reply = client(f'{path}{separator}page={p}&per_page=50')
        result, info = reply.get('result'), reply.get('result_info')
        require(isinstance(result, list) and isinstance(info, dict) and info.get('page') == p,
                'Cloudflare pagination metadata missing or inconsistent')
        total, per_page = info.get('total_count'), info.get('per_page')
        require(type(total) is int and total >= 0 and type(per_page) is int and 1 <= per_page <= 50
                and len(result) == min(per_page, max(0, total - (p - 1) * per_page)),
                'Cloudflare result count changed or cannot be verified')
        if baseline is None:
            baseline = (total, per_page)
        require(baseline == (total, per_page), 'Cloudflare page listing changed during read')
        total_pages = (total + per_page - 1) // per_page
        require(total_pages <= 100 and info.get('total_pages', total_pages) in
                ({0, 1} if not total else {total_pages}), 'Cloudflare pagination boundary mismatch')
        for row in result:
            require(isinstance(row, dict), 'Unexpected resource shape in paginated list')
            identifier = object_id(row)
            require(identifier not in seen, 'Duplicate identifier in Cloudflare pagination')
            seen.add(identifier)
            rows.append(row)
        if len(rows) == total:
            return rows
    raise Blocked('Cloudflare list exceeded safe pagination bound')


def normalized(value):
    return value.casefold().strip() if isinstance(value, str) else ''


def verified(row):
    try:
        ts = datetime.datetime.fromisoformat(row.get('verified', '').replace('Z', '+00:00'))
        return ts.tzinfo is not None and ts <= datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(minutes=2)
    except (AttributeError, TypeError, ValueError, OverflowError):
        return False


def exact(rule):
    m, a = rule.get('matchers'), rule.get('actions')
    return (rule.get('enabled') is True and isinstance(m, list) and len(m) == 1
            and isinstance(m[0], dict) and m[0].get('type') == 'literal'
            and m[0].get('field') == 'to' and normalized(m[0].get('value')) == ADDRESS
            and isinstance(a, list) and len(a) == 1 and isinstance(a[0], dict)
            and a[0].get('type') == 'forward' and a[0].get('value') == [DESTINATION])


def inspect(client, zone_id, account_id):
    require(all(isinstance(v, str) and ID.fullmatch(v) for v in (zone_id, account_id)),
            'Expected configured Cloudflare zone and account IDs are required')
    zone_path = '/zones/' + zone_id
    routing = zone_path + '/email/routing'
    zone = obj(client, zone_path)
    owner = zone.get('account')
    require(zone.get('id') == zone_id and zone.get('name') == DOMAIN and zone.get('status') == 'active'
            and isinstance(owner, dict) and owner.get('id') == account_id, 'Exact active zone/account binding not verified')
    settings = obj(client, routing)
    require(settings.get('name') == DOMAIN and settings.get('enabled') is True
            and settings.get('status') == 'ready', 'Email Routing is not enabled and ready on the exact zone')
    targets = [row for row in pages(client, '/accounts/' + account_id + '/email/routing/addresses')
               if normalized(row.get('email')) == DESTINATION]
    require(len(targets) == 1 and verified(targets[0]), 'Exact destination is not uniquely already verified')
    catchall = obj(client, routing + '/rules/catch_all')
    require(type(catchall.get('enabled')) is bool, 'Catch-all status not verified')
    if catchall['enabled']:
        actions = catchall.get('actions')
        require(isinstance(actions, list) and len(actions) == 1 and isinstance(actions[0], dict)
                and actions[0].get('type') == 'drop' and actions[0].get('value') in (None, []),
                'Active catch-all forwards or invokes a Worker; refusing to override its existing delivery')
    existing = []
    for rule in pages(client, routing + '/rules'):
        matchers = rule.get('matchers')
        require(isinstance(matchers, list) and bool(matchers) and all(isinstance(m, dict) for m in matchers),
                'Invalid routing pattern prevents exact conflict check')
        if any(normalized(m.get('value')) == ADDRESS for m in matchers):
            existing.append(rule)
        elif any(m.get('type') == 'all' for m in matchers):
            raise Blocked('Broad routing rule ordering makes exact forwarding ambiguous')
        elif any(re.fullmatch(r'primecare-qa\+[^@]+@15minutes-email\.com',
                              normalized(m.get('value'))) for m in matchers):
            raise Blocked('Existing plus-address rule could overlap the fixed QA address')
        elif rule.get('name') == NAME:
            raise Blocked('Existing rule name is bound to a different address')
        elif any(m.get('type') not in ('literal', 'all') for m in matchers):
            raise Blocked('Unexpected routing matcher prevents conflict check')
    require(len(existing) <= 1, 'Duplicate exact-address routing rules require review')
    if existing:
        require(exact(existing[0]), 'Existing exact-address rule conflicts or is disabled; no update attempted')
        return object_id(existing[0])
    return None


def select_zone(client, configured, account):
    require(isinstance(account, str) and ID.fullmatch(account),
            'Expected configured Cloudflare account ID is required')
    if configured:
        require(isinstance(configured, str) and ID.fullmatch(configured), 'Invalid configured zone ID')
        return configured
    matches = [row for row in pages(client, '/zones?name=' + DOMAIN)
               if row.get('name') == DOMAIN and row.get('status') == 'active'
               and isinstance(row.get('account'), dict) and row['account'].get('id') == account]
    require(len(matches) == 1, 'Unique exact active zone in the approved account was not found')
    return object_id(matches[0])


def validate_mode(mode, confirmation):
    require((mode == 'verify-only' and confirmation == '') or
            (mode == 'apply' and confirmation == APPROVAL), 'Invalid mode or exact confirmation')


def run(client, mode, confirmation, zone, account):
    validate_mode(mode, confirmation)
    known = inspect(client, zone, account)
    if known:
        return 'Already configured: exact verified forward; no change.'
    if mode == 'verify-only':
        return 'Ready to create the exact forward; no change.'
    # Recheck immediately before the one permitted mutation; no replay/retry of POST.
    known = inspect(client, zone, account)
    if known:
        return 'Already configured: exact verified forward; no change.'
    route = f'/zones/{zone}/email/routing/rules'
    try:
        created = client(route, 'POST', RULE)['result']
        require(isinstance(created, dict) and exact(created), 'Create response did not match authorized rule')
        new_id = object_id(created)
        require(exact(obj(client, route + '/' + new_id)), 'Exact created rule readback failed')
        require(inspect(client, zone, account) == new_id, 'List readback disagrees or has conflicting rule')
    except (Blocked, KeyError, TypeError):
        raise Blocked('Create or readback unconfirmed; run verify-only and do not retry blindly') from None
    return 'Created and verified the exact forward; delivery was not tested.'


def main(env=os.environ):
    try:
        require((env.get('GITHUB_ACTIONS'), env.get('GITHUB_REPOSITORY'), env.get('GITHUB_REF'),
                 env.get('GITHUB_EVENT_NAME')) ==
                ('true', 'shaikhrais/primecare-platform', 'refs/heads/main', 'workflow_dispatch'),
                'Protected manual main workflow required')
        mode, confirmation = env.get('QA_EMAIL_MODE', ''), env.get('QA_EMAIL_CONFIRM', '')
        validate_mode(mode, confirmation)
        zone, account = env.get('QA_EMAIL_ZONE_ID', ''), env.get('CLOUDFLARE_ACCOUNT_ID', '')
        token = env.get('CLOUDFLARE_EMAIL_ROUTING_TOKEN', '')
        if not token and env.get('QA_EMAIL_ALLOW_API_FALLBACK') == 'true':
            token = env.get('CLOUDFLARE_API_TOKEN', '')
        require(bool(token), 'No approved Cloudflare Email Routing token available')
        zone = select_zone(Client(token, None), zone, account)
        status = run(Client(token, f'/zones/{zone}/email/routing/rules', writes=mode == 'apply'),
                     mode, confirmation, zone, account)
        print(status)
    except Blocked as error:
        print(f'Email routing stopped: {error}', file=sys.stderr)
        return 1
    except Exception:
        print('Email routing stopped: unexpected response; no provider payload was logged', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
