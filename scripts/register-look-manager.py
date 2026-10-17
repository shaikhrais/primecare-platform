"""Register visual approval workflow before implementing its UI/API. No release-readiness credits."""
import argparse,json,sqlite3,runpy
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];OUT=ROOT/'packages/shared/src/look/registry.json'
def register(db):
 runpy.run_path(str(ROOT/'scripts/register-growth-governance.py'))['register'](db)
 seed=json.loads((ROOT/'docs/appearance/look-seed.json').read_text());runpy.run_path(str(ROOT/'scripts/register-admin-hierarchy.py'))['register'](db)
 roles=dict(db.execute('SELECT role_code,id FROM roles WHERE active=1'));app=db.execute("SELECT id FROM apps WHERE app_code='go'").fetchone()[0];api_app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 db.execute('CREATE TABLE IF NOT EXISTS look_review_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL)')
 db.execute('INSERT OR REPLACE INTO look_review_policy VALUES(?,?,?)',('visual-v1',json.dumps(seed),'User: base look manager, all platforms, AI then human administrator approval, 2026-10-14'))
 db.execute("INSERT OR IGNORE INTO screens(app_id,role_id,screen_code,screen_name,route_path,actual_file_path,stage,active,implementation_tag,content_tag,api_tag,test_tag) VALUES(?,?,'look_review_manager','Look Review Manager','/appearance-review','websites/typescript/src/look-review.ts','created',1,'partial','governed_content','look_connected','test_pending')",(app,roles['central_admin']))
 screen=db.execute("SELECT id FROM screens WHERE screen_code='look_review_manager'").fetchone()[0]
 for role in seed['roles']:db.execute('INSERT OR IGNORE INTO role_screen_permissions(role_id,screen_id,can_view,can_create,can_edit) VALUES(?,?,1,1,1)',(roles[role],screen))
 seed['permissions']={code:{'view':bool(v),'create':bool(c),'edit':bool(e)} for code,v,c,e in db.execute('SELECT r.role_code,p.can_view,p.can_create,p.can_edit FROM roles r JOIN role_screen_permissions p ON p.role_id=r.id WHERE p.screen_id=? AND r.active=1',(screen,))}
 db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,'look-review','Visual evidence and decisions','form',1,'Versioned AI and human visual approval',1,'websites/typescript/src/look-review.ts','look-review','created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='look-review')",(screen,screen));sid=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='look-review'",(screen,)).fetchone()[0]
 for n,(key,kind) in enumerate(seed['controls'].items()):
  code={'input':'prime_text_field','select':'prime_dropdown_web','checkbox':'prime_checkbox_web','button':'prime_button','link':'prime_button','form':'prime_card','card':'prime_card','image':'prime_image_web'}[kind];cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1',(code,)).fetchone()[0]
  db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,?,?,'partial','governed_content','action_pending','look_connected','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(sid,screen,key,kind,key,key,seed['endpoint'],n,sid,key));eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(sid,key)).fetchone()[0]
  db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Visual review control',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,sid,eid,kind,cid,eid))
 for contract in seed['contracts']:
  method=contract['method'];route=seed['endpoint']+contract['suffix'];schema={'type':'object','additionalProperties':False}
  if method=='POST':
   props=({'screen':{'type':'string'},'platform':{'enum':seed['platforms']},'width':{'type':'integer','minimum':280,'maximum':7680},'height':{'type':'integer','minimum':240,'maximum':4320},'scale':{'type':'number','minimum':1,'maximum':4},'locale':{'enum':['en','fr','es']},'build':{'type':'string'},'theme':{'type':'string'},'layout':{'type':'string'},'image':{'type':'string','contentEncoding':'base64'},'redacted':{'const':True}} if contract['suffix']=='/reviews' else {'version':{'type':'integer','minimum':1},**({'decision':{'enum':['approve','request_changes','reject']},'evidence':{'type':'string','minLength':1,'maxLength':1500},'imageDigest':{'type':'string','pattern':'^[0-9a-f]{64}$'},'reviewed':{'const':True}} if contract['suffix'].endswith('human') else {})});schema.update(properties=props,required=list(props))
  contract['request']=schema
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,?,'governance',1,'implemented','look.active_admin_scope',?,?,'look.actor',0 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)",(api_app,'LOOK_'+method+'_'+contract['suffix'].replace('/','_'),route,method,json.dumps(schema),json.dumps({'type':'object'}),api_app,route,method));db.execute('UPDATE api_endpoints SET request_schema=? WHERE app_id=? AND route_path=? AND http_method=?',(json.dumps(schema),api_app,route,method));aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(api_app,route,method)).fetchone()[0];db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'Visual evidence only; AI cannot replace human approval'))
 for lang,entries in seed['locales'].items():
  lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(lang,)).fetchone()[0]
  for key,value in entries.items():
   db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'look','Visual review','look',1)",('look.'+key,));rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',('look.'+key,)).fetchone()[0]
   db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,'look-v1' WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,value,rid,lid))
 seed['locales']={lang:{k.removeprefix('look.'):v for k,v in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='look' AND l.language_code=?",(lang,))} for lang in seed['locales']};db.commit();return json.dumps(seed,ensure_ascii=False,indent=2)+'\n'
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args();source=sqlite3.connect(ROOT/'.agents/governance/governance.db');db=sqlite3.connect(':memory:') if a.check else source
 if a.check:source.backup(db)
 output=register(db)
 if a.check:assert OUT.read_text()==output,'Look export differs'
 else:OUT.write_text(output)
 print('Registered look manager, five APIs, six platforms, nine required variants and EN/FR/ES')
