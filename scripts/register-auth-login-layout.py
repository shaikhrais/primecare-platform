"""Register the existing web login and its shared-layout requirement.

The native login metadata and all role/API authority remain unchanged.
This records a specification, not a successful test or release approval.
"""
import argparse
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = 'websites/typescript/src/auth-screen.ts'
SHELL = 'websites/typescript/src/shell.ts'
CONTROLS = [
    ('login-form', 'form', 'prime_card', 0),
    ('login-email', 'input', 'prime_text_field', 0),
    ('login-password', 'input', 'prime_text_field', 0),
    ('login-submit', 'button', 'prime_button', 1),
    ('api-status', 'card', 'prime_card', 0),
    ('login-forgot', 'link', 'prime_button', 1),
]
CRITERIA = [
    'The existing /login route renders through renderShell from ' + SHELL + '.',
    'Exactly one app-shell contains one main content region with screen-auth-login.',
    'app-sidebar and app-topbar exist in the shared shell and remain hidden on public login.',
    'Existing login controls retain their governed stable test identifiers and EN/FR/ES labels.',
    'Credential login uses the existing API, stores a hashed server session, and permits an authorized care read.',
    'Rejected credentials and unavailable authentication never create a successful UI session.',
]


def register(db):
    route = db.execute("SELECT route_path FROM auth_route_registry WHERE route_code='login'").fetchall()
    app = db.execute("SELECT id FROM apps WHERE app_code='ui' AND active=1").fetchall()
    layout = db.execute("SELECT id,default_theme_id FROM app_layout_templates WHERE layout_code='public_auth' AND active=1").fetchall()
    if len(route) != 1 or route[0][0] != '/login' or len(app) != 1 or len(layout) != 1:
        raise ValueError('Existing shared login route, UI application or public-auth layout is missing or ambiguous')
    endpoints = []
    for method, path in [('POST', '/v1/auth/login'), ('GET', '/v1/auth/me'), ('POST', '/v1/auth/logout')]:
        rows = db.execute('SELECT id FROM api_endpoints WHERE http_method=? AND route_path=?', (method, path)).fetchall()
        if len(rows) != 1:
            raise ValueError('Missing or ambiguous existing API: ' + method + ' ' + path)
        endpoints.append(rows[0][0])
    source = (ROOT / SOURCE).read_text()
    components = {}
    for key, _, code, _ in CONTROLS:
        if 'data-cy="' + key + '"' not in source:
            raise ValueError('Existing login control not found: ' + key)
        rows = db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1', (code,)).fetchall()
        if len(rows) != 1:
            raise ValueError('Existing governed component missing or ambiguous: ' + code)
        components[code] = rows[0][0]
    if not (ROOT / SHELL).is_file():
        raise ValueError('Existing shared shell is missing')

    existing = db.execute("SELECT id,app_id,route_path,actual_file_path FROM screens WHERE screen_code='auth_login_web'").fetchall()
    if existing and (len(existing) != 1 or existing[0][1:] != (app[0][0], route[0][0], SOURCE)):
        raise ValueError('Web login registration drift; review before changing metadata')
    if not existing:
        db.execute("""INSERT INTO screens(app_id,screen_code,screen_name,route_path,actual_file_path,stage,active,
            runtime_verified,cypress_verified,production_ready,implementation_tag,content_tag,api_tag,test_tag,review_tag)
            VALUES(?,'auth_login_web','Shared web login',?,?,'created',1,0,0,0,'partial','governed_content','auth_connected','test_pending','not_reviewed')""", (app[0][0], route[0][0], SOURCE))
    sid = db.execute("SELECT id FROM screens WHERE screen_code='auth_login_web'").fetchone()[0]
    purpose = 'User 2026-10-18: every page renders through shared sidebar, topbar and content layout; public login may hide layout chrome.'
    if not db.execute('SELECT 1 FROM screen_requirements WHERE screen_id=? AND business_purpose=?', (sid, purpose)).fetchone():
        db.execute('INSERT INTO screen_requirements(screen_id,business_purpose,user_story,acceptance_criteria) VALUES(?,?,?,?)',
                   (sid, purpose, 'As a user, I sign in using the existing shared credential flow within the same shared layout as operational pages.', json.dumps(CRITERIA)))
    db.execute("""INSERT INTO screen_layout_registry(screen_id,layout_type,has_sidebar,has_topbar,has_footer,content_width,responsive_behavior)
        VALUES(?,'public_auth',1,1,0,'responsive','shared shell; sidebar/topbar rendered hidden; one main content region')
        ON CONFLICT(screen_id) DO NOTHING""", (sid,))
    db.execute("""INSERT INTO screen_layout_assignment(screen_id,layout_template_id,app_shell_id,responsive_profile,theme_id,active)
        VALUES(?,?,?,'public_auth_hidden_chrome',?,1) ON CONFLICT(screen_id) DO NOTHING""", (sid, layout[0][0], SHELL, layout[0][1]))
    section = db.execute("SELECT id,file_path FROM screen_sections WHERE screen_id=? AND section_code='auth-login'", (sid,)).fetchall()
    if section and (len(section) != 1 or section[0][1] != SOURCE):
        raise ValueError('Existing web login section drift')
    if not section:
        db.execute("""INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,file_path,test_id,status,implementation_tag,content_tag,api_tag,test_tag)
            VALUES(?,'auth-login','Credential login','form',1,'Existing credential login inside shared content region',?,'screen-auth-login','planned','partial','governed_content','auth_connected','test_pending')""", (sid, SOURCE))
    section_id = db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='auth-login'", (sid,)).fetchone()[0]
    for order, (key, kind, component, action) in enumerate(CONTROLS, 1):
        rows = db.execute('SELECT id,test_id,element_type FROM screen_section_elements WHERE screen_id=? AND section_id=? AND element_key=?', (sid, section_id, key)).fetchall()
        if rows and (len(rows) != 1 or rows[0][1:] != (key, kind)):
            raise ValueError('Existing login control registration drift: ' + key)
        if not rows:
            db.execute("""INSERT INTO screen_section_elements(screen_id,section_id,element_key,element_type,test_id,required,action_required,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag)
                VALUES(?,?,?,?,?,1,?,?,'partial','governed_content',?,'auth_connected','test_pending')""", (sid, section_id, key, kind, key, action, order, 'existing_authentication' if key == 'login-submit' else 'navigation' if key == 'login-forgot' else 'presentation'))
        eid = db.execute('SELECT id FROM screen_section_elements WHERE screen_id=? AND section_id=? AND element_key=?', (sid, section_id, key)).fetchone()[0]
        db.execute("""INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required)
            VALUES(?,?,?,?,?,'html-accessible','Existing source-derived shared login presentation',1) ON CONFLICT(element_id) DO NOTHING""", (sid, section_id, eid, kind, components[component]))
    for aid in endpoints:
        db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)', (sid, aid, 'Existing credential login and self-session validation; no authority change'))
    test_code = 'auth_login_shared_layout'
    if not db.execute('SELECT 1 FROM screen_test_definitions WHERE screen_id=? AND test_code=?', (sid, test_code)).fetchone():
        db.execute("""INSERT INTO screen_test_definitions(screen_id,test_code,test_name,test_type,requires_auth,route_path,expected_layout,required_elements_json,acceptance_criteria_json)
            VALUES(?,?,'Shared web login layout and credential journey','e2e',0,?,'shared-content-only',?,?)""", (sid, test_code, route[0][0], json.dumps(['app-shell', 'app-sidebar', 'app-topbar', 'screen-auth-login'] + [c[0] for c in CONTROLS]), json.dumps(CRITERIA)))
    return sid


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--database', type=Path, default=ROOT / '.agents/governance/governance.db')
    parser.add_argument('--check', action='store_true', help='Validate registration against an in-memory copy without writing the database')
    args = parser.parse_args()
    source = sqlite3.connect('file:' + str(args.database.resolve()) + '?mode=ro' if args.check else args.database, uri=args.check)
    db = sqlite3.connect(':memory:') if args.check else source
    if args.check:
        source.backup(db)
    try:
        with db:
            sid = register(db)
        print(json.dumps({'screenId': sid, 'screenCode': 'auth_login_web', 'checkOnly': args.check, 'verificationStatus': 'unverified', 'permissionsChanged': False}))
    finally:
        db.close()
        if db is not source:
            source.close()


if __name__ == '__main__':
    main()
