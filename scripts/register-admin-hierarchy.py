"""Register the requested central/platform/tenant hierarchy before runtime implementation."""
import argparse,json,runpy,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'cloudflare/workers/src/admin-hierarchy.json'
def register(db):
 runpy.run_path(str(ROOT/'scripts/register-platform-admin-role.py'))['register'](db,True)
 screen=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
 for code,name in [('central_admin','Central Administrator'),('tenant_admin','Tenant Administrator'),('owner','Franchise Owner')]:
  db.execute("INSERT OR IGNORE INTO roles(role_code,role_name,role_type,active,primary_app_code,post_login_route) VALUES(?,?,'Infrastructure',1,'go','/platform/administration')",(code,name))
  role=db.execute('SELECT id FROM roles WHERE role_code=?',(code,)).fetchone()[0]
  db.execute('INSERT OR IGNORE INTO role_screen_permissions(role_id,screen_id,can_view,can_create,can_edit) VALUES(?,?,1,1,1)',(role,screen))
 api_app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 for method,suffix,properties in [('GET','/onboarding',{}),('POST','/onboarding/{id}/activate',{'version':{'type':'integer','minimum':1},'slug':{'type':'string','pattern':'^[a-z][a-z0-9-]{2,62}$'},'name':{'type':'string','minLength':1,'maxLength':150},'password':{'type':'string','minLength':12,'maxLength':72,'writeOnly':True}})]:
  route='/v1/governance/platform'+suffix
  request={'type':'object','additionalProperties':False,'properties':properties,'required':list(properties)}
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,?,'governance',1,'implemented','platform.onboarding_global',?,?,'platform_admin.actor',0 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)",(api_app,'PLATFORM_ONBOARDING_'+method,route,method,json.dumps(request),json.dumps({'type':'object'}),api_app,route,method))
  aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(api_app,route,method)).fetchone()[0]
  db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'Verified partner provisioning; central and platform administrators only'))
 section='platform-onboarding'
 db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,?,'Partner provisioning','form',20,'Activate reviewed business partners',1,'websites/typescript/src/platform-onboarding.ts',?,'created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code=?)",(screen,section,section,screen,section))
 sid=db.execute('SELECT id FROM screen_sections WHERE screen_id=? AND section_code=?',(screen,section)).fetchone()[0]
 for n,(key,kind,component) in enumerate([('platform-nav-onboarding','link','prime_button'),('platform-growth-link','link','prime_button'),('platform-onboarding-form-{id}','form','prime_card'),('platform-onboarding-name-{id}','input','prime_text_field'),('platform-onboarding-slug-{id}','input','prime_text_field'),('platform-onboarding-password-{id}','input','prime_text_field'),('platform-onboarding-save-{id}','button','prime_button')]):
  db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,'/v1/governance/platform/onboarding',?,'partial','governed_content','action_pending','connected','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(sid,screen,key,kind,key,key,n,sid,key))
  eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(sid,key)).fetchone()[0];cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=?',(component,)).fetchone()[0]
  db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Partner activation',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,sid,eid,kind,cid,eid))
 db.execute('CREATE TABLE IF NOT EXISTS platform_hierarchy_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL)')
 base=[r[0] for r in db.execute("SELECT t.role_code FROM auth_account_creation_policy p JOIN roles a ON a.id=p.actor_role_id JOIN roles t ON t.id=p.target_role_id WHERE a.role_code='ceo' ORDER BY t.role_code")]
 definition={'roles':{'central_admin':{'scope':'global','createTenant':True,'assignable':base+['tenant_admin','platform_admin']},'platform_admin':{'scope':'global','createTenant':True,'assignable':base+['tenant_admin']},'tenant_admin':{'scope':'tenant','createTenant':False,'assignable':[r for r in base if r not in ['ceo','owner']]}},'protected':['central_admin','platform_admin','tenant_admin'],'localProtected':['ceo','owner'],'locales':{}}
 definition['roles']['owner']={'scope':'tenant','createTenant':False,'assignable':[r for r in base if r not in ['ceo','owner']]}
 copy={'en':{'central_admin':'Central Administrator','tenant_admin':'Tenant Administrator','growth_dashboard':'Growth dashboard','onboarding':'Verified partner activation','activation_note':'Creates one active tenant and tenant administrator with the reviewed lead email. Share credentials through your approved secure channel. No clinical credentials are granted.','global_scope':'Global tenant provisioning. Central administrator peers require protected bootstrap.','tenant_scope':'Manage accounts and reference records within your active tenant.'},'fr':{'central_admin':'Administrateur central','tenant_admin':'Administrateur du locataire','growth_dashboard':'Tableau de croissance','onboarding':'Activation du partenaire vérifié','activation_note':'Crée un locataire actif et un administrateur avec le courriel vérifié. Partagez les identifiants via votre canal sécurisé approuvé. Aucune qualification clinique n’est accordée.','global_scope':'Provisionnement global des locataires. Les administrateurs centraux exigent un amorçage protégé.','tenant_scope':'Gérez les comptes et références de votre locataire actif.'},'es':{'central_admin':'Administrador central','tenant_admin':'Administrador del inquilino','growth_dashboard':'Panel de crecimiento','onboarding':'Activación de socio verificado','activation_note':'Crea un inquilino activo y administrador con el correo revisado. Comparta las credenciales por su canal seguro aprobado. No se otorgan credenciales clínicas.','global_scope':'Aprovisionamiento global de inquilinos. Los administradores centrales requieren una inicialización protegida.','tenant_scope':'Gestione cuentas y referencias de su inquilino activo.'}}
 for lang,entries in copy.items():
  entries['owner']={'en':'Franchise Owner','fr':'Propriétaire de franchise','es':'Propietario de franquicia'}[lang]
  lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(lang,)).fetchone()[0]
  for key,value in entries.items():
   resource='admin_hierarchy.'+key
   db.execute("INSERT OR IGNORE INTO language_resources(resource_key,description,resource_group,context,active) VALUES(?,?,'admin_hierarchy','admin_hierarchy',1)",(resource,copy['en'][key]))
   rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(resource,)).fetchone()[0]
   db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,'admin-v1' WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,value,rid,lid))
  definition['locales'][lang]={key.split('.',1)[1]:value for key,value in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='admin_hierarchy' AND l.language_code=?",(lang,))}
 definition['permissions']={code:{'view':bool(view),'create':bool(create),'edit':bool(edit)} for code,view,create,edit in db.execute('SELECT r.role_code,p.can_view,p.can_create,p.can_edit FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=? AND r.active=1',(screen,)) if code in definition['roles']}
 db.execute('INSERT OR REPLACE INTO platform_hierarchy_policy VALUES(?,?,?)',('founder-v1',json.dumps(definition),'User requested central, platform and tenant administrators, 2026-10-14'))
 db.commit();return json.dumps(json.loads(db.execute("SELECT definition FROM platform_hierarchy_policy WHERE id='founder-v1'").fetchone()[0]),ensure_ascii=False,indent=2)+'\n'
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args();source=sqlite3.connect(ROOT/'.agents/governance/governance.db');db=sqlite3.connect(':memory:') if a.check else source
 if a.check:source.backup(db)
 result=register(db)
 if a.check:assert OUT.read_text()==result,'Hierarchy export differs'
 else:OUT.write_text(result)
 print('Registered three administrator scopes without assigning live users')
