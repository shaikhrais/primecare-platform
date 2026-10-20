import os,sys
if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
    if os.environ.get('PRODUCTION_DATABASE_URL') or os.environ.get('GOVERNANCE_DATABASE_URL'):
        raise SystemExit('Production credentials forbidden in historical SQLite recovery fixtures')
else:
    if '--database' in sys.argv:
        raise SystemExit('Historical database paths require explicit GOVERNANCE_ALLOW_SQLITE_FIXTURES=1 with no production credentials')
    sys.path.insert(0,str(__import__('pathlib').Path(__file__).resolve().parents[1]/'tools/governance-production'))
    from recovery_registration import main
    main()
    raise SystemExit(0)
"""Register public web recovery separately from existing native screen metadata."""
import sqlite3,json,argparse
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
p=argparse.ArgumentParser();p.add_argument('--check',action='store_true');p.add_argument('--database',type=Path,default=ROOT/'.agents/governance/governance.db');p.add_argument('--output',type=Path,default=ROOT/'packages/shared/src/auth-recovery.json');a=p.parse_args()
source=sqlite3.connect(a.database);db=sqlite3.connect(':memory:') if a.check else source
if a.check:source.backup(db)
policy={'routes':{'forgot':'/forgot-password','reset':'/reset-password','login':'/login'},'endpoints':{'forgot':'/v1/auth/forgot-password','reset':'/v1/auth/reset-password'},'locales':{},'views':{}}
values={'recovery_loading':['Requesting recovery instructions…','Demande des instructions de récupération…','Solicitando instrucciones de recuperación…'],'recovery_error':['Recovery could not be completed. Check the details and try again.','La récupération a échoué. Vérifiez les renseignements et réessayez.','No se pudo completar la recuperación. Revisa los datos y reintenta.'],'reset_success':['Password updated. Sign in with your new password.','Mot de passe modifié. Connectez-vous avec votre nouveau mot de passe.','Contraseña actualizada. Inicia sesión con tu nueva contraseña.'],'reset_ready':['I have a recovery code','J’ai un code de récupération','Tengo un código de recuperación'],'reset_guidance':['Use the 12-character code emailed to you. Your new password must contain at least 12 characters and no more than 72 UTF-8 bytes.','Utilisez le code de 12 caractères reçu par courriel. Votre nouveau mot de passe doit contenir au moins 12 caractères et au plus 72 octets UTF-8.','Usa el código de 12 caracteres recibido por correo. La nueva contraseña debe tener al menos 12 caracteres y no más de 72 bytes UTF-8.'],'password_mismatch':['Passwords must match and meet the stated length.','Les mots de passe doivent être identiques et respecter la longueur indiquée.','Las contraseñas deben coincidir y cumplir la longitud indicada.'],'recovery_unavailable':['Recovery email is unavailable. Contact the platform operator.','Le courriel de récupération est indisponible. Contactez l’opérateur de la plateforme.','El correo de recuperación no está disponible. Contacta al operador de la plataforma.'],'recovery_limit':['Too many requests. Wait before trying again.','Trop de demandes. Attendez avant de réessayer.','Demasiadas solicitudes. Espera antes de reintentar.']}
for i,lang in enumerate(['en','fr','es']):
 lid=db.execute('select language_id from languages where language_code=?',(lang,)).fetchone()[0]
 for key,translations in values.items():
  resource='authRecovery.'+key;db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'authRecovery','Public recovery presentation','authRecovery',1)",(resource,));rid=db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?',(resource,)).fetchone()[0]
  db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) SELECT ?,?,?,0,0,'recovery-web-v1' WHERE NOT EXISTS(SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?)",(rid,lid,translations[i],rid,lid))
 policy['locales'][lang]={k.removeprefix('authRecovery.'):v for k,v in db.execute("SELECT r.resource_key,v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.context='authRecovery' AND l.language_code=?",(lang,))}
native={row['screen_code']:row for row in json.loads((ROOT/'docs/auth-recovery/native-presentation-baseline.json').read_text())['screens']}
for mode,code in [('forgot','forgot_password'),('reset','reset_password')]:
 sid=db.execute('SELECT id FROM screens WHERE screen_code=?',(code,)).fetchone()[0]
 existing=db.execute('SELECT route_path,actual_file_path FROM screens WHERE id=?',(sid,)).fetchone()
 baseline=native[code]
 if existing[0] not in [baseline['route_path'],policy['routes'][mode]] or existing[1] not in [baseline['actual_file_path'],'websites/typescript/src/auth-recovery.ts']:
  raise ValueError('Recovery presentation metadata changed; review before reconciling '+code)
 # Public web routes belong to this platform policy, not the native screen route.
 db.execute('UPDATE screens SET route_path=?,actual_file_path=? WHERE id=?',(baseline['route_path'],baseline['actual_file_path'],sid))
 aid=db.execute('SELECT id FROM api_endpoints WHERE route_path=? AND http_method=\'POST\'',(policy['endpoints'][mode],)).fetchone()[0]
 db.execute('INSERT OR IGNORE INTO screen_api_links(screen_id,api_id,purpose) VALUES(?,?,?)',(sid,aid,'Public email recovery and secret-code redemption; no authority change'))
 # Move only this registrar's former web section to the platform-specific policy.
 old=db.execute("SELECT id FROM screen_sections WHERE screen_id=? AND section_code='auth-recovery' AND file_path='websites/typescript/src/auth-recovery.ts'",(sid,)).fetchone()
 if old:
  owned={'recovery-form','recovery-email','recovery-code','recovery-password','recovery-confirm','recovery-submit','recovery-status','recovery-reset-link','recovery-back'}
  if any(key not in owned for key, in db.execute('SELECT element_key FROM screen_section_elements WHERE section_id=?',(old[0],))):
   raise ValueError('Unreviewed web recovery controls; no metadata removed')
  db.execute('DELETE FROM element_primecare_component_map WHERE element_id IN (SELECT id FROM screen_section_elements WHERE section_id=?)',(old[0],))
  db.execute('DELETE FROM screen_section_elements WHERE section_id=?',(old[0],))
  db.execute('DELETE FROM screen_sections WHERE id=?',(old[0],))
 controls=[]
 for key,kind,component in [('recovery-form','form','prime_card'),('recovery-email','input','prime_text_field'),('recovery-code','input','prime_text_field'),('recovery-password','input','prime_text_field'),('recovery-confirm','input','prime_text_field'),('recovery-submit','button','prime_button'),('recovery-status','card','prime_card'),('recovery-reset-link','link','prime_button'),('recovery-back','link','prime_button')]:
  cid=db.execute('SELECT id FROM primecare_ui_component_registry WHERE component_code=?',(component,)).fetchone()[0]
  controls.append({'key':key,'kind':kind,'componentId':cid,'component':component,'testId':key})
 policy['views'][mode]={'screenCode':code,'route':policy['routes'][mode],'file':'websites/typescript/src/auth-recovery.ts','section':'auth-recovery','endpoint':policy['endpoints'][mode],'controls':controls,'implementationTag':'partial','testTag':'test_pending'}
sid=db.execute("SELECT id FROM screens WHERE screen_code='login'").fetchone()[0];section=db.execute('SELECT id FROM screen_sections WHERE screen_id=? ORDER BY section_order LIMIT 1',(sid,)).fetchone()[0]
key='login-forgot';cid=db.execute("SELECT id FROM primecare_ui_component_registry WHERE component_code='prime_button'").fetchone()[0]
db.execute("INSERT INTO screen_section_elements(section_id,screen_id,element_key,element_type,label,test_id,required,action_required,element_order,implementation_tag,content_tag,action_tag,api_tag,test_tag) SELECT ?,?,?,'link','Forgot password',?,1,1,99,'partial','governed_content','navigation','auth_connected','test_pending' WHERE NOT EXISTS(SELECT 1 FROM screen_section_elements WHERE section_id=? AND element_key=?)",(section,sid,key,key,section,key));eid=db.execute('SELECT id FROM screen_section_elements WHERE section_id=? AND element_key=?',(section,key)).fetchone()[0]
db.execute("INSERT INTO element_primecare_component_map(screen_id,section_id,element_id,element_type,primecare_component_id,component_variant,usage_reason,required) SELECT ?,?,?, 'link',?,'html-accessible','Public recovery navigation',1 WHERE NOT EXISTS(SELECT 1 FROM element_primecare_component_map WHERE element_id=?)",(sid,section,eid,cid,eid))
db.execute('CREATE TABLE IF NOT EXISTS auth_recovery_web_policy(id TEXT PRIMARY KEY,definition TEXT NOT NULL)');db.execute('INSERT OR REPLACE INTO auth_recovery_web_policy VALUES(?,?)',('recovery-web-v1',json.dumps(policy)));db.commit()
policy=json.loads(db.execute("SELECT definition FROM auth_recovery_web_policy WHERE id='recovery-web-v1'").fetchone()[0])
out=a.output;result=json.dumps(policy,indent=2,ensure_ascii=False)+'\n'
if a.check:assert out.read_text()==result
else:out.write_text(result)
print('Connected two existing recovery screens and APIs; no new operation count')
