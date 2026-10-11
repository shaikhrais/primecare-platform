"""Register requested shared reports, then reproducibly export runtime policy/contracts."""
import json, sqlite3, argparse
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
LOCALES={
'en':{'title':'Reports','pages':'Authorized page readiness','organization':'Organization account summary','report':'Report','generate':'Generate','pdf':'Download PDF','email':'Email PDF','recipient':'Recipient email','subject':'Subject','message':'Message','search':'Search pages','all':'All statuses','created':'Created','ready':'Production ready','unavailable':'Data unavailable','accepted':'Email accepted by provider; inbox delivery is not confirmed.','unknown':'Delivery outcome unknown. Do not resend automatically.','error':'Report request failed.','scope':'Scope','generated':'Generated','page':'Page','role':'Role','status':'Status','blockers':'Pending requirements','metric':'Metric','value':'Value','activeAccounts':'Active accounts','activeSessions':'Active sessions','count':'Count','language':'Language','confirm':'I checked the recipient and am authorized to share this report.','empty':'No matching records','refresh':'Refresh','readiness':'Readiness','working':'Working'},
'fr':{'title':'Rapports','pages':'État des pages autorisées','organization':'Résumé des comptes de l’organisation','report':'Rapport','generate':'Générer','pdf':'Télécharger le PDF','email':'Envoyer le PDF','recipient':'Adresse du destinataire','subject':'Objet','message':'Message','search':'Rechercher des pages','all':'Tous les états','created':'Créée','ready':'Prête pour la production','unavailable':'Données indisponibles','accepted':'Courriel accepté par le fournisseur ; réception non confirmée.','unknown':'Résultat de livraison inconnu. Ne pas renvoyer automatiquement.','error':'Échec de la demande de rapport.','scope':'Portée','generated':'Généré','page':'Page','role':'Rôle','status':'État','blockers':'Exigences en attente','metric':'Indicateur','value':'Valeur','activeAccounts':'Comptes actifs','activeSessions':'Sessions actives','count':'Nombre','language':'Langue','confirm':'J’ai vérifié le destinataire et je suis autorisé à partager ce rapport.','empty':'Aucun résultat','refresh':'Actualiser','readiness':'État de préparation','working':'En cours'},
'es':{'title':'Informes','pages':'Estado de páginas autorizadas','organization':'Resumen de cuentas de la organización','report':'Informe','generate':'Generar','pdf':'Descargar PDF','email':'Enviar PDF','recipient':'Correo del destinatario','subject':'Asunto','message':'Mensaje','search':'Buscar páginas','all':'Todos los estados','created':'Creada','ready':'Lista para producción','unavailable':'Datos no disponibles','accepted':'Correo aceptado por el proveedor; entrega en bandeja no confirmada.','unknown':'Resultado de entrega desconocido. No reenviar automáticamente.','error':'La solicitud del informe falló.','scope':'Alcance','generated':'Generado','page':'Página','role':'Rol','status':'Estado','blockers':'Requisitos pendientes','metric':'Indicador','value':'Valor','activeAccounts':'Cuentas activas','activeSessions':'Sesiones activas','count':'Cantidad','language':'Idioma','confirm':'Verifiqué el destinatario y tengo autorización para compartir este informe.','empty':'Sin resultados','refresh':'Actualizar','readiness':'Preparación','working':'Procesando'}}

def register(db):
 db.executescript('''CREATE TABLE IF NOT EXISTS shared_report_definitions(report_id TEXT PRIMARY KEY,source TEXT NOT NULL,classification TEXT NOT NULL,requirement TEXT NOT NULL);
 CREATE TABLE IF NOT EXISTS shared_report_grants(report_id TEXT NOT NULL REFERENCES shared_report_definitions(report_id),role_id INTEGER NOT NULL REFERENCES roles(id),can_view INTEGER NOT NULL,can_export INTEGER NOT NULL,can_email INTEGER NOT NULL,PRIMARY KEY(report_id,role_id));''')
 for rid,source,classification,requirement in [('page_readiness','role_screen_permissions','internal','Report only pages already visible to the authenticated role; no business records.'),('organization_summary','runtime_catalog_permissions','confidential','Read tenant-scoped aggregate account/session counts with existing organization authority; never expose identifiers or clinical rows.')]:
  db.execute('INSERT OR REPLACE INTO shared_report_definitions VALUES(?,?,?,?)',(rid,source,classification,requirement))
 db.execute('''CREATE TABLE IF NOT EXISTS shared_report_surfaces(screen_id INTEGER PRIMARY KEY REFERENCES screens(id),section_code TEXT NOT NULL,controls_json TEXT NOT NULL)''')
 db.execute("INSERT OR REPLACE INTO shared_report_surfaces SELECT id,'shared_reports',? FROM screens WHERE active=1 AND (screen_code LIKE '%reports%' OR screen_code LIKE '%dashboard%')",(json.dumps([{'key':key,'component':component,'resource':'reports.'+key,'testId':'report-'+key} for key,component in [('report','PrimeDropdown'),('language','PrimeDropdown'),('search','PrimeTextField'),('readiness','PrimeDropdown'),('generate','PrimeButton'),('pdf','PrimeButton'),('recipient','PrimeTextField'),('subject','PrimeTextField'),('message','PrimeTextField'),('confirm','PrimeCheckbox'),('email','PrimeButton')]]),))
 db.execute('DELETE FROM shared_report_grants')
 db.execute("INSERT INTO shared_report_grants SELECT 'page_readiness',r.id,1,1,1 FROM roles r WHERE r.active=1 AND EXISTS(SELECT 1 FROM role_screen_permissions p WHERE p.role_id=r.id AND p.can_view=1)")
 db.execute("INSERT INTO shared_report_grants SELECT 'organization_summary',r.id,1,1,1 FROM roles r JOIN runtime_catalog_permissions p ON p.role_id=r.id WHERE r.active=1 AND p.can_view_organization=1")
 for locale,labels in LOCALES.items():
  lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(locale,)).fetchone()[0]
  for key,value in labels.items():
   resource='reports.'+key
   db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'reports','Shared admin reporting','reports',1)",(resource,))
   rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(resource,)).fetchone()[0]
   row=db.execute('SELECT translation_id FROM language_resource_values WHERE resource_id=? AND language_id=?',(rid,lid)).fetchone()
   if row: db.execute('UPDATE language_resource_values SET translated_text=?,reviewed=0,approved=0 WHERE translation_id=?',(value,row[0]))
   else: db.execute('INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) VALUES(?,?,?,0,0,1)',(rid,lid,value))
 app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
 query={'type':'object','additionalProperties':False,'properties':{'locale':{'enum':['en','fr','es']},'search':{'type':'string','maxLength':100},'readiness':{'enum':['all','created','ready']}}}
 delivery={'type':'object','additionalProperties':False,'required':['to','confirmed'],'properties':{**query['properties'],'to':{'type':'string','format':'email','maxLength':254},'confirmed':{'const':True},'subject':{'type':'string','maxLength':150},'message':{'type':'string','maxLength':1000}}}
 for method,path,code,schema in [('GET','/v1/governance/reports','CATALOG',{'type':'object','additionalProperties':False,'properties':{'locale':query['properties']['locale']}}),('GET','/v1/governance/reports/{reportId}','RUN',query),('GET','/v1/governance/reports/{reportId}/pdf','PDF',query),('POST','/v1/governance/reports/{reportId}/email','EMAIL',delivery)]:
  db.execute('''INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key)
 SELECT ?,?,?,?,'governance',1,'implemented','shared_report_grants',?,?,'reports.actor' WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)''',(app,'SHARED_REPORT_'+code,path,method,json.dumps(schema),json.dumps({'type':'object'}),app,path,method))
  aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(app,path,method)).fetchone()[0]
  for sid, in db.execute("SELECT id FROM screens WHERE active=1 AND (screen_code LIKE '%reports%' OR screen_code LIKE '%dashboard%')").fetchall():
   db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Shared authorized report '+code.lower()))
 db.commit()

def export(db):
 db.row_factory=sqlite3.Row
 defs=[]
 for row in db.execute('SELECT * FROM shared_report_definitions ORDER BY report_id'):
  item=dict(row);item['grants']=[dict(r) for r in db.execute('SELECT r.role_code AS role,g.can_view AS view,g.can_export AS export,g.can_email AS email FROM shared_report_grants g JOIN roles r ON r.id=g.role_id WHERE g.report_id=? ORDER BY r.role_code',(row['report_id'],))];defs.append(item)
 resources={locale:{r['resource_key'].removeprefix('reports.'):r['translated_text'] for r in db.execute("SELECT l.resource_key,v.translated_text FROM language_resources l JOIN language_resource_values v ON v.resource_id=l.resource_id JOIN languages a ON a.language_id=v.language_id WHERE l.resource_group='reports' AND a.language_code=? ORDER BY l.resource_key",(locale,))} for locale in LOCALES}
 return json.dumps({'version':1,'endpoint':'/v1/governance/reports','definitions':defs,'resources':resources,'surfaces':[dict(r) for r in db.execute('SELECT s.screen_code AS screen,u.section_code,u.controls_json FROM shared_report_surfaces u JOIN screens s ON s.id=u.screen_id ORDER BY s.id')]},ensure_ascii=False,indent=2)+'\n'
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args();target=ROOT/'cloudflare/workers/src/report-registry.json'
 with sqlite3.connect(('file:'+str(ROOT/'.agents/governance/governance.db')+'?mode=ro') if a.check else ROOT/'.agents/governance/governance.db',uri=a.check) as db:
  if not a.check: register(db)
  content=export(db)
  if a.check:
   if target.read_text()!=content: raise SystemExit('Report registry differs from governance')
  else:
   target.write_text(content)
   paths={}
   for row in db.execute("SELECT route_path,http_method,request_schema,endpoint_code FROM api_endpoints WHERE endpoint_code LIKE 'SHARED_REPORT_%' ORDER BY id"):
    path,method,schema,code=row;schema=json.loads(schema)
    parameters=[]
    if '{reportId}' in path: parameters.append({'in':'path','name':'reportId','required':True,'schema':{'enum':['page_readiness','organization_summary']}})
    if method=='GET': parameters += [{'in':'query','name':k,'schema':v} for k,v in schema['properties'].items()]
    else: parameters.append({'in':'header','name':'Idempotency-Key','required':True,'schema':{'type':'string','pattern':'^[A-Za-z0-9_-]{16,100}$'}})
    operation={'operationId':code.lower(),'security':[{'bearerAuth':[]}],'parameters':parameters,'description':'Active bearer session; tenant derives from identity; shared_report_grants authorize each action. Runs and downloads require the report audit migration. Email is limited to 10 new requests per actor per hour; ambiguous sends are never retried automatically.','responses':{str(n):{'description':label} for n,label in [(200,'Report, catalog, PDF or accepted replay'),(202,'Email provider accepted; not inbox delivery'),(400,'Invalid request'),(401,'Missing or expired session'),(403,'Permission or tenant mismatch'),(404,'Unknown report'),(405,'Unsupported method'),(409,'Conflicting key or delivery still sending/unknown'),(413,'Body, rows, pages or attachment too large'),(429,'Email quota'),(503,'Data, audit or mail unavailable; delivery may be unknown')]}}
    if method=='POST': operation['requestBody']={'required':True,'content':{'application/json':{'schema':schema}}}
    if code.endswith('_PDF'): operation['responses']['200']['content']={'application/pdf':{'schema':{'type':'string','format':'binary'}}}
    else: operation['responses']['200']['content']={'application/json':{'schema':{'type':'object'}}}
    paths.setdefault(path,{})[method.lower()]=operation
   document={'openapi':'3.1.0','info':{'title':'PrimeCare shared admin reporting','version':'1.0.0'},'paths':paths,'components':{'securitySchemes':{'bearerAuth':{'type':'http','scheme':'bearer'}}}}
   (ROOT/'docs/api/admin-reports.openapi.json').write_text(json.dumps(document,indent=2)+'\n')
 print('Report registry matches governance' if a.check else 'Registered shared reporting contracts and exported policy')
