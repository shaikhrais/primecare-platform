"""One exact Help Desk metadata change. Never activates or deploys a portal."""
from pathlib import Path
import json
import os
import sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools'/'workflow-verification'))
KEY=(896,6,'help_desk_dashboard','/support/help-desk-dashboard',1)
GUEST=(1,1,1,1,1)
VIEW=(1,0,0,0,0)
APPROVED='APPLY HELP DESK VIEW ONLY'

def one(rows):
    if len(rows)!=1:
        raise ValueError('expected a unique registration row')
    return tuple(rows[0])

def prepare(screen,roles,grants,endpoints):
    s=one(screen)
    if s[:5]!=KEY:
        raise ValueError('screen identity drift')
    role={r[0]:r[1] for r in roles}
    if len(roles)!=2 or set(role)!={'guest','customer_support'} or len(set(role.values()))!=2:
        raise ValueError('role identity drift')
    safe={'GOVERNED_WORKSPACE_READ','SHARED_REPORT_CATALOG','SHARED_REPORT_RUN','SHARED_REPORT_EMAIL','SHARED_REPORT_PDF'}
    if any(e[0] not in safe for e in endpoints):
        raise ValueError('domain routes detected')
    grant=one(grants)
    if s[5]!=role['guest'] or grant[1:]!=(role['guest'],*GUEST):
        raise ValueError('unexpected existing permissions')
    return role['guest'],role['customer_support'],grant[0]

def snapshot(reader):
    def all(sql,args=()):
        return reader.execute(sql,args).fetchall()
    screen=all('SELECT id,app_id,screen_code,route_path,active,role_id FROM screens WHERE id=? OR screen_code=?',(KEY[0],KEY[2]))
    roles=all("SELECT role_code,id FROM roles WHERE active=1 AND role_code IN ('guest','customer_support')")
    grants=all('SELECT id,role_id,can_view,can_create,can_edit,can_delete,can_export FROM role_screen_permissions WHERE screen_id=?',(KEY[0],))
    endpoints=all('SELECT e.endpoint_code FROM screen_api_links l JOIN api_endpoints e ON e.id=l.api_id WHERE l.screen_id=?',(KEY[0],))
    return screen,roles,grants,endpoints

def guarded_change(store, apply):
    if store.pin.get('readOnly') is not True or store.pin.get('sqliteFallback') is not False:
        raise ValueError('unexpected production authority')
    store.db.execute('LOCK TABLE '+store.table('screens')+', '+store.table('role_screen_permissions')+' IN SHARE ROW EXCLUSIVE MODE')
    old,new,gid=prepare(*snapshot(store))
    if not apply:
        return
    def all(sql,args=()):
        return store.execute(sql,args).fetchall()
    # Replace the old grant in place and narrow its abilities. No IDs, roles, API
    # permissions, existing users, data records, route, or portal are created.
    s=store.db.execute('UPDATE '+store.table('screens')+' SET role_id=%s WHERE id=%s AND app_id=%s AND screen_code=%s AND route_path=%s AND active=%s AND role_id=%s',
                       (new,*KEY,old))
    p=store.db.execute('UPDATE '+store.table('role_screen_permissions')+' SET role_id=%s,can_view=1,can_create=0,can_edit=0,can_delete=0,can_export=0 WHERE id=%s AND screen_id=%s AND role_id=%s AND can_view=1 AND can_create=1 AND can_edit=1 AND can_delete=1 AND can_export=1',
                       (new,gid,KEY[0],old))
    if (s.rowcount,p.rowcount)!=(1,1):
        raise ValueError('write count mismatch')
    now=one(all('SELECT role_id FROM screens WHERE id=?',(KEY[0],)))
    current=one(all('SELECT id,role_id,can_view,can_create,can_edit,can_delete,can_export FROM role_screen_permissions WHERE screen_id=?',(KEY[0],)))
    if now!=(new,) or current!=(gid,new,*VIEW):
        raise ValueError('in-transaction verification failed')

def main():
    mode=sys.argv[1:]
    if mode not in (['--preflight'],['--apply']):
        raise SystemExit('Explicit mode required')
    apply=mode==['--apply']
    if apply and os.environ.get('HELP_DESK_CHANGE_CONFIRMATION')!=APPROVED:
        raise SystemExit('Exact Help Desk authorization missing')
    try:
        if apply:
            from production_store import ProductionWorkflowStore
            with ProductionWorkflowStore() as store:
                guarded_change(store, True)
        else:
            from production_reader import connect
            with connect() as reader:
                prepare(*snapshot(reader))
        print(json.dumps({'screen':896,'eligible':True,'applied':apply,'portalPublished':False}))
    except Exception:
        raise SystemExit('Help Desk metadata check failed; no success claimed. Details suppressed.') from None

if __name__=='__main__':
    main()
