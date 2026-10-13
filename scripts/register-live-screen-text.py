"""Register the live text contract and export governed bundled screen resources."""
import argparse
import json
from pathlib import Path
import runpy
import sqlite3
import re

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'cloudflare/workers/src/screen-text-defaults.json'


def auth_catalogs(db):
    """Reuse registered auth copy; recovery JSON seeds new governed resources."""
    expected = {'login', 'signup', 'forgot_password', 'reset_password', 'mfa', 'consent', 'success', 'auth_error', 'language'}
    routes = {row[0] for row in db.execute('SELECT route_code FROM auth_route_registry')}
    if not expected <= routes:
        raise ValueError('Shared auth route authority missing')
    auth = {}
    for locale in ['en', 'fr', 'es']:
        rows = db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.resource_key GLOB 'auth_design_*' AND l.language_code=? ORDER BY r.resource_key", (locale,))
        auth[locale] = {key.removeprefix('auth_design_'): value for key, value in rows}
    recovery = json.loads((ROOT / 'packages/primecare_ui/lib/src/localization/screens/password_recovery.json').read_text())
    if recovery.get('version') != 1 or recovery.get('screen') != 'password_recovery':
        raise ValueError('Invalid recovery screen JSON')
    result = {'auth': auth, 'password_recovery': recovery['locales']}
    validate(result)
    if not auth['en']:
        raise ValueError('Registered auth copy missing')
    return result


def dart_catalogs(catalogs):
    lines = ['// Generated from governed live screen text; do not hand edit.']
    for screen, name in [('auth', 'authScreenCatalog'), ('password_recovery', 'passwordRecoveryScreenCatalog')]:
        lines.append('const ' + name + ' = <String, Map<String,String>>{')
        for locale, entries in catalogs[screen].items():
            lines.append('  ' + json.dumps(locale) + ': {')
            for key, value in entries.items():
                lines.append('    ' + json.dumps(key) + ': ' + json.dumps(value, ensure_ascii=False).replace('$', r'\$') + ',')
            lines.append('  },')
        lines.append('};')
    return '\n'.join(lines) + '\n'


def validate(catalogs):
    for screen, locales in catalogs.items():
        if not re.fullmatch(r'[a-z][a-z0-9_]{0,79}', screen) or set(locales) != {'en', 'fr', 'es'}:
            raise ValueError('Invalid screen catalog')
        for locale, entries in locales.items():
            if set(entries) != set(locales['en']):
                raise ValueError(f'{screen}.{locale}: key parity')
            for key, text in entries.items():
                if not isinstance(text, str) or not text.strip() or len(text) > 2000:
                    raise ValueError(f'{screen}.{locale}.{key}: invalid text')
                pattern = r'\{([A-Za-z][A-Za-z0-9_]*)\}'
                if sorted(re.findall(pattern, text)) != sorted(re.findall(pattern, locales['en'][key])):
                    raise ValueError(f'{screen}.{locale}.{key}: parameters differ')


def register(db, catalogs):
    runpy.run_path(str(ROOT / 'scripts/register-platform-admin-role.py'))['register'](db)
    screen = db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
    db.execute('CREATE TABLE IF NOT EXISTS live_screen_text_surfaces(screen_id INTEGER PRIMARY KEY REFERENCES screens(id),section_code TEXT NOT NULL,controls_json TEXT NOT NULL)')
    db.execute('INSERT OR REPLACE INTO live_screen_text_surfaces VALUES(?,?,?)', (screen, 'screen_text_editor', json.dumps(['screen','search','en','fr','es','save','reload','download','import','export','history','restore'])))
    app = db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
    for method, route, authenticated in [('GET','/screen-text',0),('GET','/screen-text/{screen}',0),('PUT','/screen-text/{screen}',1),('GET','/screen-text/{screen}/history',1)]:
        path='/v1/governance'+route
        code='SCREEN_TEXT_'+method+'_'+route.replace('/','_').replace('{','').replace('}','')
        schema={'type':'object','additionalProperties':False}
        if method=='PUT': schema.update(properties={'version':{'type':'integer','minimum':0},'locales':{'type':'object','required':['en','fr','es'],'additionalProperties':False,'properties':{l:{'type':'object','additionalProperties':{'type':'string','minLength':1,'maxLength':2000}} for l in ['en','fr','es']}}},required=['version','locales'])
        db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,?,'governance',?,'implemented',?,?,'{\"type\":\"object\"}',?,0 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)", (app,code,path,method,authenticated,'platform_admin.screen_text' if authenticated else 'public_interface_text',json.dumps(schema),'screen_text.actor' if method=='PUT' else None,app,path,method))
        aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(app,path,method)).fetchone()[0]
        db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'Shared plain UI text; platform administrator edits/history only, optimistic version and transaction audit'))
    for name, locales in catalogs.items():
        for key in locales['en']:
            resource='screenText.'+name+'.'+key
            db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'liveScreenText','Live screen text',?,1)", (resource,name))
            rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(resource,)).fetchone()[0]
            for locale, entries in locales.items():
                lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(locale,)).fetchone()[0]
                if not db.execute('SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?',(rid,lid)).fetchone():
                    db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) VALUES(?,?,?,0,0,'live-screen-v1')",(rid,lid,entries[key]))
    db.commit()


if __name__ == '__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--check',action='store_true');args=parser.parse_args()
    catalogs=json.loads(SOURCE.read_text());validate(catalogs)
    with sqlite3.connect('file:'+str(ROOT/'.agents/governance/governance.db')+'?mode=ro',uri=True) as source:
        db=sqlite3.connect(':memory:') if args.check else sqlite3.connect(ROOT/'.agents/governance/governance.db')
        if args.check: source.backup(db)
        try:
            catalogs.update(auth_catalogs(db))
            register(db,catalogs)
            output={}
            for name, locales in catalogs.items():
                output[name]={}
                for locale in locales:
                    rows=db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.resource_group='liveScreenText' AND r.context=? AND l.language_code=? ORDER BY r.resource_id",(name,locale))
                    output[name][locale]={key.removeprefix('screenText.'+name+'.'):value for key,value in rows}
            validate(output)
            lines=['// Generated from governed screen-text-defaults.json; do not hand edit.','const themeCenterScreenCatalog = <String, Map<String,String>>{']
            for locale,entries in output['theme_center'].items():
                lines.append('  '+json.dumps(locale)+': {')
                for key,value in entries.items():
                    encoded=json.dumps(value,ensure_ascii=False).replace('$', r'\$')
                    lines.append('    '+json.dumps(key)+': '+encoded+',')
                lines.append('  },')
            generated='\n'.join(lines+['};'])+'\n'
            dart=ROOT/'packages/flutter_core/lib/theme/theme_center_text_generated.dart'
            auth_dart=ROOT/'packages/primecare_ui/lib/src/localization/auth_screen_text_generated.dart'
            auth_generated=dart_catalogs(output)
            auth_json=ROOT/'packages/primecare_ui/lib/src/localization/screens/auth.json'
            auth_document=json.dumps({'version':1,'screen':'auth','locales':output['auth']},ensure_ascii=False,indent=2)+'\n'
            if args.check:
                if output != json.loads(SOURCE.read_text()): raise SystemExit('Live screen text differs from governance')
                if dart.read_text()!=generated: raise SystemExit('Theme Center fallback export differs from governance')
                if not auth_dart.is_file() or auth_dart.read_text()!=auth_generated: raise SystemExit('Auth fallback export differs from governance')
                if not auth_json.is_file() or auth_json.read_text()!=auth_document: raise SystemExit('Auth screen JSON differs from governance')
            else:
                SOURCE.write_text(json.dumps(output,ensure_ascii=False,indent=2)+'\n')
                dart.write_text(generated)
                auth_dart.write_text(auth_generated)
                auth_json.write_text(auth_document)
        finally: db.close()
    print(len(catalogs),'live screens registered; API/editor permissions and resource parity validated')
