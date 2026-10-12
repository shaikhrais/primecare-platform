"""Register a distinct platform role; do not assign it to existing users."""
import sqlite3,json
from pathlib import Path
def register(db, apis=False):
    db.execute("INSERT OR IGNORE INTO roles(role_code,role_name,role_type,active,primary_app_code,post_login_route) VALUES('platform_admin','Platform Administrator','Infrastructure',1,'go','/platform/administration')")
    db.execute("UPDATE roles SET role_name='Platform Administrator',primary_app_code='go',post_login_route='/platform/administration' WHERE role_code='platform_admin'")
    role=db.execute("SELECT id FROM roles WHERE role_code='platform_admin'").fetchone()[0]
    app=db.execute("SELECT id FROM apps WHERE app_code='go'").fetchone()
    db.execute("INSERT OR IGNORE INTO screens(app_id,role_id,screen_code,screen_name,route_path,actual_file_path,stage,active,implementation_tag,content_tag,api_tag,test_tag) VALUES(?,?,'PLATFORM_ADMINISTRATION','Platform Administration','/platform/administration','websites/typescript/src/platform-admin.ts','implemented',1,'implemented','implemented','implemented','test_pending')",(app[0] if app else None,role))
    screen=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
    db.execute("INSERT OR IGNORE INTO role_screen_permissions(role_id,screen_id,can_view,can_create,can_edit) VALUES(?,?,1,1,1)",(role,screen))

    if not apis: return
    api_app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
    routes=[('GET',''),('GET','/tenants'),('POST','/tenants'),('GET','/tenants/{tenantId}'),('GET','/tenants/{tenantId}/accounts'),('POST','/tenants/{tenantId}/accounts'),('PATCH','/tenants/{tenantId}/accounts/{userId}'),('GET','/tenants/{tenantId}/masters'),('POST','/tenants/{tenantId}/masters'),('PATCH','/tenants/{tenantId}/masters/{recordId}'),('GET','/tenants/{tenantId}/audit')]
    for method,suffix in routes:
        path='/v1/governance/platform'+suffix
        code='PLATFORM_ADMIN_'+method+'_'+suffix.replace('/','_').replace('{','').replace('}','').upper()
        if method=='GET': properties={};required=[]
        elif suffix=='/tenants':properties={'slug':{'type':'string','pattern':'^[a-z][a-z0-9-]{2,62}$'},'name':{'type':'string','minLength':1,'maxLength':150}};required=list(properties)
        elif 'accounts' in suffix:
            properties={'role':{'type':'string'},**({'status':{'enum':['active','inactive']}} if method=='PATCH' else {'email':{'type':'string','format':'email','maxLength':254},'password':{'type':'string','minLength':12,'maxLength':72,'writeOnly':True}})};required=list(properties)
        else:
            properties={'label':{'type':'string','minLength':1,'maxLength':150},**({'status':{'enum':['active','inactive']},'version':{'type':'integer','minimum':1}} if method=='PATCH' else {'type':{'enum':['location','department','service_category']},'code':{'type':'string','pattern':'^[a-z][a-z0-9_-]{1,63}$'}})};required=list(properties)
        request={'type':'object','properties':properties,'required':required,'additionalProperties':False}
        db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,?,'governance',1,'implemented','platform_administration_policy',?,?,'platform_admin.actor',0 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)",(api_app,code,path,method,json.dumps(request),json.dumps({'type':'object'}),api_app,path,method))
        aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(api_app,path,method)).fetchone()[0]
        db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'Platform administrator only; tenant provisioning and scoped reference records'))

if __name__=='__main__':
    with sqlite3.connect(Path(__file__).resolve().parents[1]/'.agents/governance/governance.db') as db: register(db)
