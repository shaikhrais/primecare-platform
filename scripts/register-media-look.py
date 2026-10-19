"""Register the inherited media presentation contract before generating its browser catalog."""
import argparse, json, sqlite3, runpy
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'packages/shared/src/media/registry.json'

def register(db):
    # Media mappings reference the approved visual-review screen and web adapters.
    runpy.run_path(str(ROOT / 'scripts/register-look-manager.py'))['register'](db)
    seed = json.loads((ROOT / 'docs/appearance/media/media-seed.json').read_text())
    db.execute('CREATE TABLE IF NOT EXISTS media_look_policy(id TEXT PRIMARY KEY, definition TEXT NOT NULL, requirement TEXT NOT NULL)')
    db.execute('INSERT OR REPLACE INTO media_look_policy VALUES(?,?,?)', (seed['version'], json.dumps(seed), seed['requirement']))
    # Register shared presentation tokens for each theme, preserving later theme customizations.
    for (theme,) in db.execute('SELECT DISTINCT theme_id FROM theme_design_tokens').fetchall():
        for name, value in seed['tokens'].items():
            code = 'media.' + name
            if not db.execute('SELECT 1 FROM theme_design_tokens WHERE theme_id=? AND token_code=?', (theme, code)).fetchone():
                db.execute('INSERT INTO theme_design_tokens(theme_id,token_code,token_name,token_type,token_value,css_variable_name,description,active) VALUES(?,?,?,?,?,?,?,1)', (theme, code, code, 'media', value, '--media-' + name.replace('_', '-'), 'Inherited media presentation'))
    for locale, entries in seed['locales'].items():
        lid = db.execute('SELECT language_id FROM languages WHERE language_code=?', (locale,)).fetchone()[0]
        for key, text in entries.items():
            resource = 'media.' + key
            db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'media','Inherited visual presentation','media',1)", (resource,))
            rid = db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?', (resource,)).fetchone()[0]
            if not db.execute('SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?', (rid, lid)).fetchone():
                db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) VALUES(?,?,?,0,0,'media-v1')", (rid, lid, text))
        seed['locales'][locale] = {k.removeprefix('media.'): v for k,v in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='media' AND r.active=1 AND l.language_code=?", (locale,))}
    screen = db.execute("SELECT id FROM screens WHERE screen_code='login'").fetchone()[0]
    db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,'media-entry','Shared media entry','card',0,'Inherited care illustration, brand and orientation',1,'websites/typescript/src/media-look.ts','media-entry','created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='media-entry')", (screen,screen))
    section = db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='media-entry'", (screen,)).fetchone()[0]
    for n,(key,kind,component) in enumerate([('media-entry','card','prime_card'),('media-care-image','image','prime_image_web'),('media-brand','icon','prime_icon_web'),('media-entry-topics','card','prime_card'),('media-login-mail','icon','prime_icon_web'),('media-login-key','icon','prime_icon_web'),('media-login-arrow','icon','prime_icon_web')]):
        cid = db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=? AND active=1', (component,)).fetchone()[0]
        db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,0,?,'partial','governed_content','not_required','not_required','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)", (section,screen,key,kind,key,key,n,section,key))
        eid = db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(section,key)).fetchone()[0]
        db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Shared inherited media',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)", (screen,section,eid,kind,cid,eid))
    # Native HTML meter is a presentation adapter; scores remain supplied by the review API.
    columns=[r[1] for r in db.execute('PRAGMA table_info(primecare_ui_component_registry)') if r[1]!='id']
    template=dict(zip(columns,db.execute('SELECT '+','.join(columns)+" FROM primecare_ui_component_registry WHERE component_code='prime_image_web'").fetchone()))
    template.update(component_code='prime_meter_web',component_name='PrimeMeter',component_type='indicator',dart_class_name='PrimeMeter',html_tag_equivalent='meter',source_file_path='websites/typescript/src/media-look.ts',purpose='Read-only API visual score',allowed_element_types_json='["meter"]',required_props_json='["min","max","value","aria-label","data-cy"]',optional_props_json='[]',event_props_json='[]',example_usage='<meter min="0" max="100" value="80" aria-label="Layout: 80/100" data-cy="look-score-layout"></meter>')
    db.execute('INSERT OR IGNORE INTO primecare_ui_component_registry('+','.join(columns)+') VALUES('+','.join('?' for _ in columns)+')',tuple(template[k] for k in columns))
    for code,controls in [('PLATFORM_ADMINISTRATION',[('media-page-heading','card','prime_card')]),('look_review_manager',[('media-page-heading','card','prime_card'),('media-review-process','card','prime_card'),('look-state-{id}','card','prime_card'),('look-score-{id}-{criterion}','meter','prime_meter_web'),('media-empty-review','card','prime_card')])]:
        screen=db.execute('SELECT id FROM screens WHERE screen_code=?',(code,)).fetchone()[0]
        db.execute("INSERT INTO screen_sections(screen_id,section_code,section_name,section_type,section_order,purpose,required,file_path,test_id,status) SELECT ?,'media-operations','Inherited operational presentation','card',0,'Shared headings, icons and read-only review indicators',1,'websites/typescript/src/media-look.ts','media-operations','created' WHERE NOT EXISTS(SELECT 1 FROM screen_sections WHERE screen_id=? AND section_code='media-operations')",(screen,screen))
        section=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='media-operations'",(screen,)).fetchone()[0]
        for n,(key,kind,component) in enumerate(controls):
            cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=?',(component,)).fetchone()[0]
            db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,?,?,?,1,0,?,'partial','governed_content','not_required','not_required','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(section,screen,key,kind,key,key,n,section,key))
            eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(section,key)).fetchone()[0]
            db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?,?,?, 'html-accessible','Inherited operational media',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(screen,section,eid,kind,cid,eid))
    db.commit()
    return json.dumps(seed,ensure_ascii=False,indent=2)+'\n'

if __name__ == '__main__':
    p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');a=p.parse_args()
    source=sqlite3.connect(ROOT/'.agents/governance/governance.db');db=sqlite3.connect(':memory:') if a.check else source
    if a.check: source.backup(db)
    output=register(db)
    if a.check: assert OUT.read_text()==output, 'Media catalog differs from governance'
    else: OUT.write_text(output)
    print('Registered inherited media, theme tokens, approved components and EN/FR/ES')
