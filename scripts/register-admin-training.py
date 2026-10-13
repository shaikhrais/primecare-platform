"""Register non-sensitive self-study content and controls before UI generation.

Training progress is device-local self-assessment; grants never add domain authority.
"""
import argparse,json,runpy,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
SEED=ROOT/'docs/training/admin-course-seed.json'
OUTPUT=ROOT/'websites/typescript/src/training/admin-course.json'

def register(db):
    seed=json.loads(SEED.read_text());locales=seed['locales']
    validate=runpy.run_path(str(ROOT/'scripts/register-live-screen-text.py'))['validate']
    validate({'admin_training':locales})
    assert len(json.dumps(locales,ensure_ascii=False).encode())<48000
    ids=[m['id'] for m in seed['modules']]
    assert len(ids)==len(set(ids))==8
    assert all(m['correct'] in range(3) and all(k in locales['en'] for k in [m['keys']['title'],m['keys']['procedure'],m['keys']['practice'],m['keys']['question'],*m['keys']['options']]) for m in seed['modules'])
    runpy.run_path(str(ROOT/'scripts/register-platform-admin-role.py'))['register'](db)
    screen=db.execute("SELECT id FROM screens WHERE screen_code='PLATFORM_ADMINISTRATION'").fetchone()[0]
    db.execute('CREATE TABLE IF NOT EXISTS admin_training_courses(course_id TEXT PRIMARY KEY,version TEXT NOT NULL,modules_json TEXT NOT NULL,progress_scope TEXT NOT NULL,requirement TEXT NOT NULL)')
    db.execute('INSERT OR REPLACE INTO admin_training_courses VALUES(?,?,?,?,?)',(seed['course'],seed['version'],json.dumps(seed['modules']),'device_account_self_assessment','User request: admin duties, management reporting and in-system training; no certification or domain authority'))
    db.execute('CREATE TABLE IF NOT EXISTS admin_training_learning_grants(role_id INTEGER PRIMARY KEY REFERENCES roles(id),course_id TEXT NOT NULL REFERENCES admin_training_courses(course_id),can_read INTEGER NOT NULL)')
    db.execute('INSERT OR REPLACE INTO admin_training_learning_grants SELECT id,?,1 FROM roles WHERE active=1',(seed['course'],))
    db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status,implementation_tag,content_tag,api_tag,test_tag) SELECT ?,'admin_training','Administrator training','content',80,'Self-paced procedures and knowledge checks; local progress and supervisor review',1,'websites/typescript/src/admin-training.ts','screen-admin-training','implemented','implemented','implemented','not_required','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='admin_training')",(screen,screen))
    section=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='admin_training'",(screen,)).fetchone()[0]
    controls=[*[('training-language-'+l,'button') for l in ['en','fr','es']],('training-submit','button'),('training-export','button'),('training-reset','button'),('training-close','button'),('workspace-training','button'),('platform-nav-training','button')]+[('training-lesson-'+id,'button') for id in ids]+[('training-answer-'+str(i),'button') for i in range(3)]
    for order,(key,kind) in enumerate(controls):
        db.execute('INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,api_usage,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,1,?,?,\'implemented\',\'implemented\',\'implemented\',\'not_required\',\'test_pending\' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)',(section,screen,key,kind,key,key,'Device-local self-assessment; no new API; authenticated parent authority unchanged',order,section,key))
        element=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(section,key)).fetchone()[0]
        component=db.execute("SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1",('prime_button' if kind=='button' else 'prime_text_field',)).fetchone()
        assert component, 'Approved component missing'
        db.execute('INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?,?,?,1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)',(screen,section,element,kind,component[0],'html-accessible','Shared training presentation control',element))
    for key in locales['en']:
        resource='screenText.admin_training.'+key
        db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'liveScreenText','Administrator training','admin_training',1)",(resource,))
        rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(resource,)).fetchone()[0]
        for language in locales:
            lid=db.execute('SELECT language_id FROM languages WHERE language_code=?',(language,)).fetchone()[0]
            db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,? WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,locales[language][key],seed['version'],rid,lid))
    governed={}
    for language in locales:
        governed[language]={key.removeprefix('screenText.admin_training.'):value for key,value in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='admin_training' AND l.language_code=?",(language,))}
    assert governed==locales,'Training seed differs from governed text; review the change before export'
    seed['locales']=governed
    db.commit();return seed

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');args=p.parse_args()
    with sqlite3.connect('file:'+str(ROOT/'.agents/governance/governance.db')+'?mode=ro',uri=True) as source:
        db=sqlite3.connect(':memory:') if args.check else sqlite3.connect(ROOT/'.agents/governance/governance.db')
        if args.check:source.backup(db)
        data=register(db);encoded=json.dumps(data,ensure_ascii=False,indent=2)+'\n'
        if args.check:assert OUTPUT.read_text()==encoded,'Training export differs from governance'
        else:OUTPUT.write_text(encoded)
        db.close()
    print('Registered eight training lessons, authenticated learning grants and EN/FR/ES resources; local progress only')
