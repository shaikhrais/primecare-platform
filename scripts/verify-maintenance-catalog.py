"""Read-only parity gate for the committed production-generated maintenance data."""
import json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools/governance-production'))
from production_reader import connect

def verify(db,catalog):
    if catalog['authority']['schema']!=db.pin['schema'] or catalog['authority']['manifestSha256']!=db.pin['manifestSha256']:
        raise RuntimeError('Maintenance catalog production authority mismatch')
    rows=db.execute("SELECT r.resource_key,l.language_code,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='maintenance' AND r.active=1 AND v.approved=1").fetchall()
    locales={locale:{} for locale in ['en','fr','es']}
    for key,locale,value in rows:
        if locale in locales:locales[locale][key.removeprefix('maintenance.')]=value
    if locales!=catalog['locales']:raise RuntimeError('Maintenance resources are stale; regenerate from pinned production')
    if dict(db.execute('SELECT component_code,data_cy FROM screen_components WHERE screen_id=1264'))!=catalog['controls']:
        raise RuntimeError('Maintenance control bindings are stale')
    actors=sorted(r[0] for r in db.execute('SELECT r.role_code FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=1264 AND p.can_view=1 AND r.active=1'))
    if actors!=catalog['actorRoles']:raise RuntimeError('Maintenance actor authority is stale')
    create=sorted(r[0] for r in db.execute("SELECT a.role_code FROM auth_account_creation_policy p JOIN roles a ON a.id=p.actor_role_id JOIN roles t ON t.id=p.target_role_id WHERE t.role_code='maintenance' AND p.scope='same_tenant'") if r[0] in actors)
    if create!=catalog['creationActorRoles']:raise RuntimeError('Maintenance creation authority is stale')
    for aid,method,route in zip(catalog['apiIds'],['GET','POST','POST'],[catalog['endpoints']['configuration'],catalog['endpoints']['configuration'],catalog['endpoints']['testEmail']]):
        if db.execute('SELECT http_method,route_path,service_name,auth_required,permission_key FROM api_endpoints WHERE id=?',(aid,)).fetchall()!=[(method,route,'auth',1,'role_screen_permissions')]:
            raise RuntimeError('Maintenance API contract binding is stale')
    return {'resources':len(locales['en']),'controls':len(catalog['controls']),'apis':len(catalog['apiIds']),'authority_matches':True}

if __name__=='__main__':
    if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
        if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):raise RuntimeError('Fixture mode forbidden with production credentials')
        print('Isolated historical build: no live maintenance parity claim')
    else:
        with connect() as db:result=verify(db,json.loads((ROOT/'packages/shared/src/maintenance.json').read_text()))
        print('MAINTENANCE_CATALOG_PARITY '+json.dumps(result))
