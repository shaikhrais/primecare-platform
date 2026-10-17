"""Register requested allocation board, policy, source geography and resources before export.
GIS build dependency: shapely==2.2.0; no runtime GIS dependency in browser/API.
"""
import argparse,json,sqlite3,runpy
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def register(db):
 # A clean checkout must install the approved admin screen and web adapters too.
 runpy.run_path(str(ROOT/'scripts/register-growth-governance.py'))['register'](db)
 seed=json.loads((ROOT/'docs/territories/seed.json').read_text());geo=json.loads((ROOT/'docs/territories/catalog-source.geojson').read_text());context=json.loads((ROOT/'docs/territories/basemap-source.json').read_text())
 catalog=[f['properties'] for f in geo['features']];sale=[c for c in catalog if not c['is_reserve']];postal=[fsa for c in catalog for fsa in c['fsas']]
 assert len(catalog)==30 and len(sale)==24 and len({c['id'] for c in catalog})==30
 assert len(postal)==len(set(postal))==226,'Every selected postal area must belong to exactly one territory'
 assert all(50000<=c['seniors65']<=55000 for c in sale) and sum(c['seniors65'] for c in sale)==1246300
 assert sum(c['seniors65'] for c in catalog if c['is_reserve'])==32335
 assert all(set(v)==set(seed['locales']['en']) for v in seed['locales'].values())
 db.execute('CREATE TABLE IF NOT EXISTS territory_allocation_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL,geography TEXT NOT NULL,basemap TEXT NOT NULL,requirement TEXT NOT NULL)')
 db.execute('INSERT OR REPLACE INTO territory_allocation_policy VALUES(?,?,?,?,?)',('regional-v1',json.dumps(seed),json.dumps(geo),json.dumps(context),'User: numbered selectable territories, tenant PSW/home-care assignment, red sold locked, green pending, senior totals; 2026-10-15'))
 screen=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
 key='platform-territories'
 db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,?,'Territory sales board','dashboard',25,'Numbered tenant allocations with senior counts',1,'websites/typescript/src/territories/panel.ts',?,'created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code=?)",(screen,key,key,screen,key))
 sid=db.execute('SELECT id FROM screen_sections WHERE screen_id=? AND section_code=?',(screen,key)).fetchone()[0]
 controls=[('platform-nav-territories','link','prime_button'),('territory-board','card','prime_card'),('territory-map','image','prime_image_web'),('territory-city-{id}','image','prime_image_web'),('territory-label-metrics','image','prime_image_web'),('territory-number-{id}','image','prime_image_web'),('territory-summary','card','prime_card'),('territory-list','table','prime_table_web'),('territory-details','card','prime_card'),('territory-form','form','prime_card')]+[('territory-'+k,'button','prime_button') for k in ['overview','zoom','refresh','save','piece-{id}','detail-{id}']]+[('territory-'+k,'input','prime_checkbox_web') for k in ['psw','home_care','confirm']]+[('territory-picker','select','prime_dropdown_web'),('territory-tenant','select','prime_dropdown_web'),('territory-reference','input','prime_text_field'),('territory-notice','card','prime_card')]
 for n,(key,kind,component) in enumerate(controls):
  db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,?,?,'partial','governed_content','action_pending','test_pending','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(sid,screen,key,kind,key,key,seed['endpoint'],n,sid,key))
  eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(sid,key)).fetchone()[0];cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1',(component,)).fetchone()[0]
  db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Territory allocation',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,sid,eid,kind,cid,eid))
 app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 for c in seed['contracts']:
  path=seed['endpoint']+c['suffix'];method=c['method']
  db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,?,'governance',1,'partial','territory_allocation_policy',?,?,'platform_admin.actor',0 WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)",(app,'TERRITORY_'+method,path,method,json.dumps(c['request']),json.dumps(c['response']),app,path,method))
  db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE app_id=? AND route_path=? AND http_method=?',(json.dumps(c['request']),json.dumps(c['response']),app,path,method))
  aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(app,path,method)).fetchone()[0];db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'Global admins allocate once; tenant admins read own only'))
 for lang,values in seed['locales'].items():
  lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(lang,)).fetchone()[0]
  for k,v in values.items():
   key='territories.'+k;db.execute("INSERT OR IGNORE INTO language_resources(resource_key,description,resource_group,context,active) VALUES(?,?,'territories','territories',1)",(key,seed['locales']['en'][k]));rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(key,)).fetchone()[0]
   db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,'territory-v1' WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,v,rid,lid))
 for k,v in seed['theme'].items():
  code='territory_'+k;db.execute("INSERT INTO theme_design_tokens(theme_id,token_code,token_name,token_type,token_value,css_variable_name,description,active) SELECT 1,?,?,'color',?,?,?,1 WHERE NOT EXISTS(SELECT 1 FROM theme_design_tokens WHERE theme_id=1 AND token_code=?)",(code,code,v,'--territory-'+k,'Territory board semantic color',code))
 db.commit()
 # Export exclusively from persisted governance rows.
 definition,geography,basemap=db.execute("SELECT definition,geography,basemap FROM territory_allocation_policy WHERE id='regional-v1'").fetchone();seed=json.loads(definition);geo=json.loads(geography);context=json.loads(basemap)
 seed['locales']={l:{k.split('.',1)[1]:v for k,v in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='territories' AND l.language_code=?",(l,))} for l in seed['locales']}
 seed['theme']={k:db.execute('SELECT token_value FROM theme_design_tokens WHERE theme_id=1 AND token_code=?',('territory_'+k,)).fetchone()[0] for k in seed['theme']}
 return seed,geo,context

def exports(seed,geo,context):
 from shapely.geometry import shape,box
 from shapely.ops import transform
 frame=box(-80.55,42.8,-78.55,44.18)
 def project(x,y,z=None):return ((x+80.55)*600,(44.18-y)*600/.73)
 def paths(geom):
  g=transform(project,geom.intersection(frame).simplify(.00012,preserve_topology=True));rings=[]
  def visit(g):
   if g.is_empty:return
   if g.geom_type=='Polygon':rings.extend([list(g.exterior.coords),*[list(r.coords) for r in g.interiors]])
   elif g.geom_type in ['LineString','LinearRing']:rings.append(list(g.coords))
   elif hasattr(g,'geoms'):
    for v in g.geoms:visit(v)
  visit(g)
  return ' '.join('M'+' L'.join(f'{x:.2f},{y:.2f}' for x,y in r)+(' Z' if r[0]==r[-1] else '') for r in rings)
 catalog=[];pieces=[]
 for f in geo['features']:
  p=f['properties'];catalog.append({k:p[k] for k in ['id','order','code','name','fsas','seniors65','population','is_reserve']});g=shape(f['geometry']);parts=[g] if g.geom_type=='Polygon' else list(g.geoms);point=max(parts,key=lambda v:v.area).representative_point();x,y=project(point.x,point.y);b=transform(project,g).bounds;pieces.append({'id':p['id'],'path':paths(g),'x':round(x,2),'y':round(y,2),'bounds':[round(v,2) for v in b]})
 seed['catalog']=catalog
 major={'Guelph','Cambridge','Hamilton','Burlington','Oakville','Brampton','Mississauga','Toronto','Markham','Newmarket','Oshawa','Whitby','Ajax','Pickering','St. Catharines','Niagara Falls','Welland','Fort Erie'}
 cities=[{'name':c['name'],'x':round(project(c['lon'],c['lat'])[0],2),'y':round(project(c['lon'],c['lat'])[1],2)} for c in context['cities'] if c['name'] in major and frame.contains(shape({'type':'Point','coordinates':[c['lon'],c['lat']]}))]
 mapdata={'viewBox':[0,0,1200,1134.25],'pieces':pieces,'roads':[paths(shape(g)) for g in context['roads']],'lakes':[paths(shape(g)) for g in context['lakes']],'cities':cities}
 spec={'openapi':'3.1.0','info':{'title':'PrimeCare Territory Allocation','version':'1.0.0'},'components':{'securitySchemes':{'bearer':{'type':'http','scheme':'bearer'}}},'security':[{'bearer':[]}],'paths':{}}
 for c in seed['contracts']:
  method=c['method'];operation={'summary':'Read scoped territory board' if method=='GET' else 'Record one confirmed tenant allocation and lock territory','x-authorization':seed['roles'],'x-rate-limit':'30 authenticated mutation attempts per actor per minute','parameters':[], 'responses':{str(200 if method=='GET' else 201):{'description':'Success','content':{'application/json':{'schema':c['response']}}},**{str(code):{'description':message} for code,message in [(400,'Invalid or unknown fields / tenant override'),(401,'Missing or inactive session'),(403,'Role has no permission'),(404,'Unknown territory or route'),(405,'Unsupported method'),(409,'Sold, reserve, unavailable tenant or key conflict'),(429,'Mutation rate limit'),(503,'Database unavailable, incomplete catalog or rolled back audit')]}}}
  if method=='POST':
   operation['parameters']=[{'name':'id','in':'path','required':True,'schema':{'type':'string','pattern':'^PC-REG-[TR][0-9]{4}$'}},{'name':'Idempotency-Key','in':'header','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9_-]{16,100}$'}}];operation['requestBody']={'required':True,'content':{'application/json':{'schema':c['request'],'example':{'version':0,'tenantId':'example-active-tenant','services':['psw','home_care'],'reference':'Approved agreement reference','confirmed':True}}}}
  spec['paths'][seed['endpoint']+c['suffix']]={method.lower():operation}
 return {'docs/territories/openapi.json':json.dumps(spec,ensure_ascii=False,indent=2)+'\n','packages/shared/src/territories/registry.json':json.dumps(seed,ensure_ascii=False,indent=2)+'\n','packages/shared/src/territories/map.json':json.dumps(mapdata,separators=(',',':'))+'\n','packages/database/migrations/20261015_territory_catalog.sql':"-- Generated from governance territory_allocation_policy. Do not edit.\nINSERT INTO platform_territory_catalog(id,number,code,name,fsas,seniors65,population,is_reserve) VALUES\n"+',\n'.join('('+','.join(["'"+str(p[k]).replace("'","''")+"'" if k in ['id','code','name'] else "'"+json.dumps(p[k])+"'::jsonb" if k=='fsas' else str(p[k]).lower() for k in ['id','order','code','name','fsas','seniors65','population','is_reserve']])+')' for p in catalog)+'\nON CONFLICT(id) DO NOTHING;\n'}
if __name__=='__main__':
 a=argparse.ArgumentParser();a.add_argument('--check',action='store_true');a.add_argument('--database',type=Path,default=ROOT/'.agents/governance/governance.db');args=a.parse_args();source=sqlite3.connect(args.database);db=sqlite3.connect(':memory:') if args.check else source
 if args.check:source.backup(db)
 for path,value in exports(*register(db)).items():
  target=ROOT/path
  if args.check:assert target.read_text()==value,path+' differs from governance'
  else:target.write_text(value)
 print('Registered and exported 30 map pieces, 24 sale territories, 2 APIs and EN/FR/ES resources')
