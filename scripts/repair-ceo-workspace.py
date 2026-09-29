import json,sqlite3,re
from pathlib import Path
root=Path(__file__).resolve().parents[1]
db=sqlite3.connect(root/'.agents/governance/governance.db')
copy={
'en':{'title':'CEO workspace','pending':'Business dashboard data is not available yet.','account':'My account'},
'fr':{'title':'Espace du PDG','pending':'Les données du tableau de bord ne sont pas encore disponibles.','account':'Mon compte'},
'es':{'title':'Espacio del director ejecutivo','pending':'Los datos del panel de gestión aún no están disponibles.','account':'Mi cuenta'},
'ar':{'title':'مساحة الرئيس التنفيذي','pending':'بيانات لوحة الأعمال غير متاحة بعد.','account':'حسابي'}}
with db:
 app=db.execute("SELECT id FROM apps WHERE app_name='Primecare Corporate'").fetchone()[0]
 role=db.execute("SELECT id FROM roles WHERE role_code='ceo'").fetchone()[0]
 db.execute("UPDATE screens SET app_id=?,role_id=?,actual_file_path='packages/primecare_ui/lib/src/features/generated_screens/ceo_dashboard.dart',stage='partial',runtime_verified=0,cypress_verified=0,production_ready=0,completeness_score=0,implementation_tag='partial',content_tag='partial',api_tag='api_missing',test_tag='not_tested',review_tag='pending' WHERE screen_code='ceo_dashboard'",(app,role))
 sid=db.execute("SELECT id FROM screens WHERE screen_code='ceo_dashboard'").fetchone()[0]
 db.execute("UPDATE screen_requirements SET business_purpose='Provide the authenticated CEO with account access and honest business-dashboard availability.',user_story='As the CEO, I can access my account and distinguish available capabilities from unfinished dashboard features.',acceptance_criteria='CEO route requires authentication and CEO authorization; account access uses the existing protected account route; missing business data never displays fake success or production-ready claims.' WHERE screen_id=?",(sid,))
 for language,items in copy.items():
  lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(language,)).fetchone()[0]
  for key,value in items.items():
   resource='ceo_workspace_'+key
   db.execute("INSERT INTO language_resources(resource_key,resource_group,description,context,active) VALUES (?,'ceo_workspace','CEO workspace availability','ceo_dashboard',1) ON CONFLICT(resource_key) DO UPDATE SET active=1",(resource,))
   rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(resource,)).fetchone()[0]
   db.execute('DELETE FROM language_resource_values WHERE resource_id=? AND language_id=?',(rid,lid))
   db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) VALUES (?,?,?,0,0,'ceo-workspace-v1')",(rid,lid,value))
for p in (root/'apps').glob('*/assets/translations/*.json'):
 if p.stem not in copy:continue
 original=p.read_text();data=json.loads(original)
 data.update({'ceo_workspace_'+k:v for k,v in copy[p.stem].items()})
 match=re.search(r'\n( +)"',original); indent=len(match[1]) if match else 2
 p.write_text(json.dumps(data,ensure_ascii=False,indent=indent)+'\n')
print('CEO ownership, honest completion tags, and four-language resources reconciled.')
