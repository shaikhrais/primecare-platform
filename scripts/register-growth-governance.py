"""Register the user-requested founder/marketing workflow before exporting its policy."""
import argparse,json,runpy,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
SEED=ROOT/'docs/marketing/growth-seed.json'
OUT=ROOT/'packages/shared/src/growth/registry.json'

def register(db):
    seed=json.loads(SEED.read_text())
    runpy.run_path(str(ROOT/'scripts/register-live-screen-text.py'))['validate']({'growth':seed['locales']})
    assert set(seed['roles'])=={'ceo','marketing','local_marketing'}|set(seed['roleDefinitions'])|set(seed.get('adminGrowthRoles',[]))
    runpy.run_path(str(ROOT/'scripts/register-admin-hierarchy.py'))['register'](db)
    db.execute("UPDATE roles SET role_name='Franchise Owner',primary_app_code='marketing',post_login_route='/growth' WHERE role_code='owner'")
    for code,name in seed['roleDefinitions'].items():
        db.execute("INSERT OR IGNORE INTO roles(role_code,role_name,role_type,active,primary_app_code,post_login_route) VALUES(?,?,'support',1,'marketing','/growth')",(code,name))
    roles={r[0]:r[1] for r in db.execute('SELECT role_code,id FROM roles WHERE active=1')}
    assert all(r in roles for r in seed['roles'])
    for code in [*seed['roleDefinitions'],*seed['preservedAccountGrants']]:
        db.execute("INSERT OR IGNORE INTO auth_account_creation_policy VALUES(?,?,'same_tenant',?)",(roles['ceo'],roles[code],'User requested dedicated marketing staff permissions, task 9, 2026-10-13'))
    app=db.execute("SELECT id FROM apps WHERE app_code='ma'").fetchone()[0]
    api_app=db.execute("SELECT id FROM apps WHERE app_code='gv'").fetchone()[0]
    db.execute('CREATE TABLE IF NOT EXISTS growth_business_policy(policy_id TEXT PRIMARY KEY,definition TEXT NOT NULL,requirement TEXT NOT NULL)')
    db.execute('INSERT OR REPLACE INTO growth_business_policy VALUES(?,?,?)',('psw-founder-v1',json.dumps(seed),'User: one-person dashboard, weak flow stages, corrective work, marketing leads from Google/Facebook/offline'))
    db.execute("INSERT OR IGNORE INTO screens(app_id,role_id,screen_code,screen_name,route_path,actual_file_path,stage,active,implementation_tag,content_tag,api_tag,test_tag) VALUES(?,?,'founder_growth_dashboard','Founder Growth Dashboard','/growth','websites/typescript/src/growth/dashboard.ts','created',1,'partial','governed_content','growth_connected','test_pending')",(app,roles['marketing']))
    screen=db.execute("SELECT id FROM screens WHERE screen_code='founder_growth_dashboard'").fetchone()[0]
    if not db.execute('SELECT 1 FROM screen_requirements WHERE screen_id=?',(screen,)).fetchone():
        db.execute('INSERT INTO screen_requirements(screen_id,business_purpose,user_story,sidebar_label,acceptance_criteria) VALUES(?,?,?,?,?)',(screen,'Track tenant/client acquisition and assign corrective actions','Founder sees targets, gaps and owners; marketing records source-attributed prospects and campaigns','Growth and marketing','Persist tenant-scoped records; protect mutations; reconcile funnels; show unconnected care/import sources; verify EN/FR/ES and responsive browser flows'))
    for role in seed['roles']:
        db.execute('INSERT OR IGNORE INTO role_screen_permissions(role_id,screen_id,can_view,can_create,can_edit) VALUES(?,?,1,1,1)',(roles[role],screen))
    grants={r[0]:{'view':r[1]==1,'create':r[2]==1,'edit':r[3]==1} for r in db.execute('SELECT r.role_code,p.can_view,p.can_create,p.can_edit FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=? AND r.active=1',(screen,)) if r[0] in seed['roles']}
    seed['permissions']=grants
    seed['roles']=[role for role in seed['roles'] if grants.get(role,{}).get('view')]
    seed['planRoles']=[role for role in seed['ownerPolicy']['roles'] if grants.get(role,{}).get('view') and grants.get(role,{}).get('edit')]
    # Website adapter for the approved PrimeDropdown control; no native class is claimed.
    db.execute("INSERT INTO primecare_ui_component_registry(component_code,component_name,component_type,html_tag_equivalent,import_path,source_file_path,purpose,allowed_element_types_json,required_props_json,event_props_json,accessibility_props_json,active) SELECT 'prime_dropdown_web','Prime Dropdown website adapter','select','select','websites/typescript/src/growth/forms.ts','websites/typescript/src/growth/forms.ts','Source, pipeline and owner selection for the requested marketing workflow','[\"select\"]','[\"label\",\"options\"]','[\"onChange\"]','[\"label\"]',1 WHERE NOT EXISTS(SELECT 1 FROM primecare_ui_component_registry WHERE component_code='prime_dropdown_web')")
    db.execute("INSERT INTO primecare_ui_component_registry(component_code,component_name,component_type,html_tag_equivalent,import_path,source_file_path,purpose,allowed_element_types_json,required_props_json,event_props_json,accessibility_props_json,active) SELECT 'prime_textarea_web','Prime Text Field multiline website adapter','textarea','textarea','websites/typescript/src/growth/briefs.ts','websites/typescript/src/growth/briefs.ts','Multiline campaign planning fields','[\"textarea\"]','[\"label\"]','[\"onChange\"]','[\"label\"]',1 WHERE NOT EXISTS(SELECT 1 FROM primecare_ui_component_registry WHERE component_code='prime_textarea_web')")
    db.execute("INSERT INTO primecare_ui_component_registry(component_code,component_name,component_type,html_tag_equivalent,source_file_path,purpose,allowed_element_types_json,required_props_json,accessibility_props_json,active) SELECT 'prime_table_web','Prime Table website adapter','table','table','websites/typescript/src/growth/reporting.ts','Accessible aggregate report table','[\"table\"]','[\"columns\",\"rows\"]','[\"caption\",\"scope\"]',1 WHERE NOT EXISTS(SELECT 1 FROM primecare_ui_component_registry WHERE component_code='prime_table_web')")
    db.execute("INSERT INTO primecare_ui_component_registry(component_code,component_name,component_type,html_tag_equivalent,source_file_path,purpose,allowed_element_types_json,required_props_json,accessibility_props_json,active) SELECT 'prime_checkbox_web','Prime Checkbox website adapter','checkbox','input','websites/typescript/src/growth/forms.ts','Explicit consent and review confirmations','[\"checkbox\"]','[\"label\"]','[\"label\"]',1 WHERE NOT EXISTS(SELECT 1 FROM primecare_ui_component_registry WHERE component_code='prime_checkbox_web')")
    visual=seed['visual']
    db.execute("INSERT OR IGNORE INTO theme_profiles(theme_code,theme_name,mode,brand_name,description,default_theme,active) VALUES(?,'Growth Daylight','light','PrimeCare','User requested a brighter growth dashboard',0,1)",(visual['themeCode'],))
    theme_id=db.execute('SELECT id FROM theme_profiles WHERE theme_code=?',(visual['themeCode'],)).fetchone()[0]
    for key,value in visual['theme'].items():
        assert key.startswith('--color-') and len(value)==7 and value.startswith('#')
        if not db.execute('SELECT 1 FROM theme_design_tokens WHERE theme_id=? AND css_variable_name=?',(theme_id,key)).fetchone():
            db.execute('INSERT INTO theme_design_tokens(theme_id,token_code,token_name,token_type,token_value,css_variable_name,description,active) VALUES(?,?,?,?,?,?,?,1)',(theme_id,key.removeprefix('--'),key,'color',value,key,'Growth daylight color'))
    seed['visual']['theme']=dict(db.execute('SELECT css_variable_name,token_value FROM theme_design_tokens WHERE theme_id=? AND active=1 ORDER BY id',(theme_id,)))
    import xml.etree.ElementTree as ET
    for markup in visual['icons'].values():
        for node in ET.fromstring('<svg>'+markup+'</svg>'):
            assert node.tag in ['path','circle','rect'] and not list(node)
            assert set(node.attrib)<=set(['d','cx','cy','r','x','y','width','height','rx'])
    for code,kind,tag in [('prime_icon_web','icon','svg'),('prime_image_web','image','img')]:
        db.execute("INSERT OR IGNORE INTO primecare_ui_component_registry(component_code,component_name,component_type,html_tag_equivalent,source_file_path,purpose,allowed_element_types_json,required_props_json,accessibility_props_json,active) VALUES(?,?,?,?,?,'Growth decorative visuals',?,?,?,1)",(code,'Prime '+kind.title()+' website adapter',kind,tag,'websites/typescript/src/growth/visuals.ts',json.dumps([kind]),json.dumps(['name' if kind=='icon' else 'src']),json.dumps(['aria-hidden' if kind=='icon' else 'alt'])))
    sections={'summary':'metrics','funnels':'chart','leads':'list','campaigns':'list','tasks':'list','operations':'content','plan':'form','team':'form','calls':'list','appointments':'list','search':'form','duplicates':'list','briefs':'form','hero':'content','intake':'form','alerts':'list','performance':'form','business':'form'}
    controls=[(k,'button') for k in ['growth-refresh','growth-lead-save','growth-campaign-save','growth-task-save','growth-plan-save','growth-prev','growth-next','growth-advance-{id}','growth-assign-{id}','growth-close-{id}','growth-campaign-update-{id}','growth-complete-{id}']]
    controls += [(k,'form') for k in ['growth-lead-form','growth-campaign-form','growth-task-form','growth-plan-form']]
    controls += [(k,'form') for k in ['growth-team-form','growth-call-form','growth-appointment-form']]
    controls += [(k,'button') for k in ['growth-team-save','growth-call-save','growth-appointment-save','growth-appointment-finish-{id}']]
    controls += [(k,'input') for k in ['growth-call-notes','growth-call-due','growth-appointment-starts_at','growth-appointment-duration','growth-appointment-notes','growth-appointment-evidence-{id}']]
    controls += [(k,'select') for k in ['growth-team-member','growth-team-specialty','growth-call-lead','growth-call-outcome','growth-appointment-lead','growth-appointment-owner','growth-appointment-status-{id}']]
    controls += [(k,'form') for k in ['growth-search-form','growth-contact-form-{id}']]
    controls += [(k,'button') for k in ['growth-filter-save','growth-filter-clear','growth-contact-save-{id}','growth-contact-open-{id}','growth-duplicate-save-{id}']]
    controls += [(k,'input') for k in ['growth-query','growth-contact-name-{id}','growth-contact-email-{id}','growth-contact-phone-{id}','growth-contact-evidence-{id}','growth-duplicate-evidence-{id}']]
    controls += [(k,'select') for k in ['growth-filter-pipeline','growth-filter-stage','growth-filter-source','growth-filter-owner','growth-duplicate-decision-{id}','growth-duplicate-canonical-{id}']]
    controls += [('growth-capacity-form-{id}','form'),('growth-capacity-slots-{id}','input'),('growth-capacity-expiry-{id}','input'),('growth-capacity-evidence-{id}','input'),('growth-capacity-save-{id}','button'),('growth-readiness-{id}','card')]
    controls += [('growth-brief-{id}','card'),('growth-brief-form-{id}','form'),('growth-brief-open-{id}','button'),('growth-brief-save-{id}','button')]
    controls += [('growth-brief-'+key+'-{id}','textarea') for key in ['audience','offer','creative']]
    controls += [('growth-brief-'+key+'-{id}','input') for key in ['landing_url','target_leads','start','end']]
    controls += [('growth-brief-'+key+'-{id}','select') for key in ['owner','pipeline']]
    controls += [('growth-review-form-{id}','form'),('growth-review-action-{id}','select'),('growth-review-evidence-{id}','textarea'),('growth-review-save-{id}','button'),('growth-review-status-{id}','card'),('growth-review-history-{id}','card')]
    controls += [('growth-task-action-form-{id}-{action}','form'),('growth-task-owner-{id}-{action}','select'),('growth-task-priority-{id}-{action}','select'),('growth-task-deadline-{id}-{action}','input'),('growth-task-action-evidence-{id}-{action}','input'),('growth-task-action-save-{id}-{action}','button'),('growth-task-action-open-{id}-{action}','button')]
    controls += [('growth-intake-form','form'),('growth-intake-name','input'),('growth-intake-pipeline','select'),('growth-intake-owner','select'),('growth-intake-campaign','select'),('growth-intake-save','button'),('growth-intake-toggle-{id}','button'),('growth-intake-link-{id}','link')]
    controls += [('growth-intake-source','select'),('growth-intake-attribution','input'),('growth-intake-qr-open-{id}','button'),('growth-intake-qr-{id}','image'),('growth-intake-qr-download-{id}','link')]
    controls += [('growth-alert-{kind}-{id}','card'),('growth-report-form','form'),('growth-report-start','input'),('growth-report-end','input'),('growth-report-run','button'),('growth-report-pdf','button'),('growth-report-email-form','form'),('growth-report-recipient','input'),('growth-report-confirm','input'),('growth-report-email','button'),('growth-report-output','card'),('growth-report-state','card')]
    controls += [('growth-report-table','table')]
    controls += [('growth-marketing-model','card'),('growth-marketing-allocation','card'),('growth-marketing-responsibilities','card')]
    controls += [('growth-marketing-statement-form','form'),('growth-marketing-statement-month','input'),('growth-marketing-statement-run','button'),('growth-marketing-statement-pdf','button'),('growth-marketing-statement-output','card'),('growth-marketing-statement-table','table')]
    controls += [('growth-business-'+k,'form') for k in ['onboarding','handoff','finance']]
    controls += [('growth-business-'+k,'input') for k in ['evidence-{kind}','identity','agreement','insurance','visit','reference','amount','date','invoice-id']]
    controls += [('growth-business-'+k,'select') for k in ['lead-{kind}','kind','finance-kind','category']]
    controls += [('growth-business-'+k,'button') for k in ['verify','link','record','revoke-{id}']]
    controls += [('growth-business-'+k,'card') for k in ['summary','ledger','care','partner-{id}']]
    controls += [('growth-report-delivery-form-{id}','form'),('growth-report-delivery-decision-{id}','select'),('growth-report-delivery-evidence-{id}','input'),('growth-report-delivery-save-{id}','button')]
    controls += [('growth-care-image','image'),('growth-marketing-image','image')]
    controls += [('growth-icon-'+key,'icon') for key in ['summary','tenant','client','leads','campaigns','tasks','team','calls','appointments','integrations','operations','plan','duplicates','metric-leads','metric-overdue','metric-spend','nav-growth','nav-back','nav-admin','refresh']]
    controls += [('growth-nav-'+item['key'],'link') for item in seed['visual']['navigation']]
    controls += [('growth-icon-nav-'+item['key'],'icon') for item in seed['visual']['navigation']]
    controls += [('growth-language','select'),('growth-back','link'),('growth-admin-link','link')]
    fields={'campaign':['name','source','reference','budget','spend'],'lead':['pipeline','name','email','phone','source','reference','contact_basis','campaign','owner','due'],'task':['description','owner','due']}
    for group,fields_in_group in fields.items():
        controls += [('growth-'+group+'-'+f,'select' if f in ['source','pipeline','contact_basis','campaign','owner'] else 'input') for f in fields_in_group]
    controls += [(k,'input') for k in ['growth-start','growth-end','growth-evidence-{id}','growth-due-{id}','growth-budget-{id}','growth-spend-{id}','growth-task-evidence-{id}']]
    controls += [('growth-owner-{id}','select')]
    controls += [('growth-target-'+p+'-'+str(i),'input') for p in seed['pipelines'] for i in range(5)]
    controls += [('growth-stage-'+p+'-'+stage,'card') for p,values in seed['pipelines'].items() for stage in values]
    controls += [('growth-funnel-'+p,'card') for p in seed['pipelines']]
    for n,(code,kind) in enumerate(sections.items()):
        key='growth-'+code
        db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,?,?,?,?,?,1,'websites/typescript/src/growth/dashboard.ts',?,'created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code=?)",(screen,key,code.title(),kind,n,'Tenant-scoped '+code,key,screen,key))
    sec=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='growth-leads'",(screen,)).fetchone()[0]
    for n,(key,kind) in enumerate(controls):
        if key in ['growth-report-confirm','growth-business-identity','growth-business-agreement','growth-business-insurance']:kind='checkbox'
        component=db.execute("SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1",({'checkbox':'prime_checkbox_web','table':'prime_table_web','form':'prime_card','card':'prime_card','input':'prime_text_field','select':'prime_dropdown_web','textarea':'prime_textarea_web','icon':'prime_icon_web','image':'prime_image_web','button':'prime_button','link':'prime_button'}[kind],)).fetchone()
        assert component,'Approved component missing'
        db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,?,?,'partial','governed_content','action_pending','growth_connected','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(sec,screen,key,kind,key,key,seed['endpoint'],n,sec,key))
        eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(sec,key)).fetchone()[0]
        db.execute('UPDATE screen_section_elements SET element_type=? WHERE id=?',(kind,eid))
        db.execute('UPDATE element_primecare_component_map SET element_type=?,primecare_component_id=? WHERE element_id=?',(kind,component[0],eid))
        db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Founder and marketing control',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,sec,eid,kind,component[0],eid))
    methods=[(c['method'],c['suffix']) for c in seed['contracts']]
    for method,suffix in methods:
        route=seed['endpoint']+suffix
        schema=next(c['request'] for c in seed['contracts'] if c['method']==method and c['suffix']==suffix)
        db.execute("INSERT INTO api_endpoints(app_id,endpoint_code,route_path,http_method,service_name,auth_required,implementation_status,permission_key,request_schema,response_schema,rate_limit_key,uses_pagination) SELECT ?,?,?,?,'governance',?,'implemented',?,?,?,'growth.actor',? WHERE NOT EXISTS(SELECT 1 FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?)",(api_app,'GROWTH_'+method+'_'+suffix.replace('/','_').replace('{','').replace('}',''),route,method,int(not next(c.get('public',False) for c in seed['contracts'] if c['method']==method and c['suffix']==suffix)),'growth.active_intake_link' if next(c.get('public',False) for c in seed['contracts'] if c['method']==method and c['suffix']==suffix) else 'growth.owner_plan' if suffix=='/plan' else 'growth.tenant_team' if suffix=='/team/{id}' else 'growth.marketing_statement' if suffix.startswith('/marketing-statement') else 'growth.tenant_role',json.dumps(schema),json.dumps(next(c.get('response',{'type':'object'}) for c in seed['contracts'] if c['method']==method and c['suffix']==suffix)),int(method=='GET'),api_app,route,method))
        db.execute('UPDATE api_endpoints SET request_schema=?,response_schema=? WHERE app_id=? AND route_path=? AND http_method=?',(json.dumps(schema),json.dumps(next(c.get('response',{'type':'object'}) for c in seed['contracts'] if c['method']==method and c['suffix']==suffix)),api_app,route,method))
        db.execute('UPDATE api_endpoints SET auth_required=? WHERE app_id=? AND route_path=? AND http_method=?',(int(not next(c.get('public',False) for c in seed['contracts'] if c['method']==method and c['suffix']==suffix)),api_app,route,method))
        permission='growth.active_intake_link' if next(c.get('public',False) for c in seed['contracts'] if c['method']==method and c['suffix']==suffix) else 'growth.intake_manager' if suffix.startswith('/intake-links') else 'growth.ceo_plan' if suffix in ['/plan','/team/{id}'] else 'growth.ceo_business' if suffix.startswith(('/onboarding','/handoffs','/finance')) else 'growth.report_manager' if suffix.startswith('/performance') else 'growth.tenant_role'
        db.execute('UPDATE api_endpoints SET permission_key=? WHERE app_id=? AND route_path=? AND http_method=?',(permission,api_app,route,method))
        if suffix=='/capacity/{id}':db.execute("UPDATE api_endpoints SET permission_key='growth.owner_capacity' WHERE app_id=? AND route_path=? AND http_method=?",(api_app,route,method))
        if suffix.startswith('/marketing-statement'):db.execute("UPDATE api_endpoints SET permission_key='growth.marketing_statement' WHERE app_id=? AND route_path=? AND http_method=?",(api_app,route,method))
        aid=db.execute('SELECT id FROM api_endpoints WHERE app_id=? AND route_path=? AND http_method=?',(api_app,route,method)).fetchone()[0]
        db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(screen,aid,'Authenticated tenant-scoped CRM; milestones are reported, not clinical proof'))
    db.execute("INSERT OR IGNORE INTO screens(app_id,screen_code,screen_name,route_path,actual_file_path,stage,active,implementation_tag,content_tag,api_tag,test_tag) VALUES(?,'growth_public_enquiry','Public Website Enquiry','/enquire/{key}','websites/typescript/src/growth/enquiry.ts','created',1,'partial','governed_content','growth_connected','test_pending')",(app,))
    public_screen=db.execute("SELECT id FROM screens WHERE screen_code='growth_public_enquiry'").fetchone()[0]
    db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,'enquiry-form','Public enquiry','form',0,'Public consent-based enquiry',1,'websites/typescript/src/growth/enquiry.ts','enquiry-form','created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='enquiry-form')",(public_screen,public_screen))
    db.execute("INSERT INTO screen_requirements(screen_id,business_purpose,user_story,sidebar_label,acceptance_criteria) SELECT ?,'Receive consent-based website enquiries','Visitor submits contact details to the configured client or partner inbox','Public enquiry','No anonymous lead reads; active link chooses tenant and owner; preserve opt-outs; validate consent and EN/FR/ES forms' WHERE NOT EXISTS(SELECT 1 FROM screen_requirements WHERE screen_id=?)",(public_screen,public_screen))
    public_section=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='enquiry-form'",(public_screen,)).fetchone()[0]
    db.execute("INSERT INTO primecare_ui_component_registry(component_code,component_name,component_type,html_tag_equivalent,source_file_path,purpose,allowed_element_types_json,required_props_json,accessibility_props_json,active) SELECT 'prime_checkbox_web','Prime Checkbox website adapter','input','input','websites/typescript/src/growth/enquiry.ts','Explicit enquiry response consent','[\"input\"]','[\"label\",\"checked\"]','[\"label\"]',1 WHERE NOT EXISTS(SELECT 1 FROM primecare_ui_component_registry WHERE component_code='prime_checkbox_web')")
    for key,component,kind in [('enquiry-name','prime_text_field','input'),('enquiry-email','prime_text_field','input'),('enquiry-phone','prime_text_field','input'),('enquiry-website','prime_text_field','input'),('enquiry-consent','prime_checkbox_web','input'),('enquiry-language','prime_dropdown_web','select'),('enquiry-submit','prime_button','button'),('enquiry-form','prime_card','form'),('enquiry-status','prime_card','card')]:
        cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1',(component,)).fetchone()[0]
        db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,?,0,'partial','governed_content','action_pending','growth_connected','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(public_section,public_screen,key,kind,key,key,seed['endpoint']+'/enquiries/{key}',public_section,key))
        eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(public_section,key)).fetchone()[0]
        db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Website enquiry control',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(public_screen,public_section,eid,kind,cid,eid))
    for aid, in db.execute("SELECT id FROM api_endpoints WHERE route_path=?",(seed['endpoint']+'/enquiries/{key}',)):
        db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(public_screen,aid,'Anonymous write-only enquiry intake; public config exposes no client data'))
    for key in seed['locales']['en']:
        resource='growth.'+key
        db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'growth','Founder growth interface','growth',1)",(resource,))
        rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(resource,)).fetchone()[0]
        for lang in seed['locales']:
            lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(lang,)).fetchone()[0]
            db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,'growth-v1' WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,seed['locales'][lang][key],rid,lid))
            if key.startswith(('readiness_','capacity_')):db.execute("UPDATE language_resource_values SET translated_text=?,reviewed=0,version='growth-capacity-v1' WHERE resource_id=? AND language_id=? AND approved=0",(seed['locales'][lang][key],rid,lid))
    seed['locales']={lang:{k.removeprefix('growth.'):v for k,v in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='growth' AND l.language_code=?",(lang,))} for lang in seed['locales']}
    db.commit()
    return seed

if __name__=='__main__':
    a=argparse.ArgumentParser();a.add_argument('--check',action='store_true');args=a.parse_args()
    source=sqlite3.connect(ROOT/'.agents/governance/governance.db')
    db=sqlite3.connect(':memory:') if args.check else source
    if args.check:source.backup(db)
    output=json.dumps(register(db),ensure_ascii=False,indent=2)+'\n'
    hierarchy_output=runpy.run_path(str(ROOT/'scripts/register-admin-hierarchy.py'))['register'](db)
    hierarchy_path=ROOT/'cloudflare/workers/src/admin-hierarchy.json'
    policy={}
    for actor,target in db.execute('SELECT a.role_code,t.role_code FROM auth_account_creation_policy p JOIN roles a ON a.id=p.actor_role_id JOIN roles t ON t.id=p.target_role_id ORDER BY a.role_code,t.role_code'):
        policy.setdefault(actor,[]).append(target)
    policy_output=json.dumps(policy,indent=2)+'\n'
    policy_path=ROOT/'cloudflare/workers/src/account-policy.json'
    # Reconcile only this module's grants and owner landing in the shared workspace export.
    workspace_path=ROOT/'cloudflare/workers/src/workspace-registry.json'
    workspace=json.loads(workspace_path.read_text())
    growth_screen=db.execute("SELECT id FROM screens WHERE screen_code='founder_growth_dashboard'").fetchone()[0]
    grants=[dict(zip(['role','view','create','edit','delete','export'],row)) for row in db.execute('SELECT r.role_code,p.can_view,p.can_create,p.can_edit,p.can_delete,p.can_export FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=? AND p.can_view=1 AND r.active=1',(growth_screen,))]
    for entry in workspace['screens']:
        if entry['code']=='founder_growth_dashboard':entry['grants']=grants
        if entry['code']=='PLATFORM_ADMINISTRATION':
            admin_screen=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
            entry['grants']=[dict(zip(['role','view','create','edit','delete','export'],row)) for row in db.execute('SELECT r.role_code,p.can_view,p.can_create,p.can_edit,p.can_delete,p.can_export FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=? AND p.can_view=1 AND r.active=1',(admin_screen,))]
    workspace['landings']['owner']=db.execute("SELECT post_login_route FROM roles WHERE role_code='owner'").fetchone()[0]
    workspace_output=json.dumps(workspace,separators=(',',':'))+'\n'
    if args.check:
        assert OUT.read_text()==output,'Growth policy export differs'
        assert workspace_path.read_text()==workspace_output,'Growth workspace grants differ'
        assert hierarchy_path.read_text()==hierarchy_output,'Hierarchy policy export differs'
        assert policy_path.read_text()==policy_output,'Staff account creation export differs'
    else:
        OUT.write_text(output)
        workspace_path.write_text(workspace_output)
        hierarchy_path.write_text(hierarchy_output)
        policy_path.write_text(policy_output)
    db.close()
    print('Registered founder/marketing workflow, scoped API contracts and EN/FR/ES resources')
