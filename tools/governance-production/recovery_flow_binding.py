"""Bind existing recovery processes to registered production controls and contracts."""
import hashlib,json,datetime
from pathlib import Path
from recovery_registration import ROOT,FLOWS,SCREENS,SOURCE,read_catalog,load_definition,GovernanceReadError,quote
SCOPE={'flowIds':FLOWS,'tables':['virtual_workflow_definitions','virtual_workflow_source_links'],'schemaChanges':False,'businessDataWrites':False}
def bind(db,catalog):
    if db.pin['recoveryRegistrationWriter'].get('workflowBinding')!=SCOPE:raise GovernanceReadError('Exact recovery workflow binding scope required')
    if read_catalog(db,load_definition())!=catalog or json.loads((ROOT/'packages/shared/src/auth-recovery.json').read_text())!=catalog:raise GovernanceReadError('Current production recovery catalog required before binding')
    paths=['cloudflare/workers/src/password-recovery.ts','cloudflare/workers/src/auth-invalidation.ts','cloudflare/workers/src/password-change.ts','cloudflare/workers/src/auth.ts','cloudflare/workers/src/email.ts','cloudflare/workers/src/gateway.ts',SOURCE,'websites/typescript/src/auth-screen.ts','websites/typescript/src/main.ts','packages/shared/src/auth-recovery.json','tools/governance-production/recovery_registration.py','tools/governance-production/recovery_flow_binding.py']
    sources={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest() for p in paths}
    results=[]
    for mode,flow in zip(['forgot','reset'],FLOWS):
        sid,code,aid,rid=SCREENS[mode]
        rows=db.execute('SELECT definition_json,definition_sha256,flow_kind,actor_roles_json FROM virtual_workflow_definitions WHERE flow_id=?',(flow,)).fetchall()
        if len(rows)!=1 or rows[0][2]!='business_process' or json.loads(rows[0][3])!=[] or hashlib.sha256(rows[0][0].encode()).hexdigest()!=rows[0][1]:raise GovernanceReadError('Exact existing public recovery workflow required')
        plan=json.loads(rows[0][0])
        if plan['id']!=flow or plan['actor_roles']!=[] or not any(s.get('api_method')=='POST' and s.get('api_path')==catalog['endpoints'][mode] for s in plan['steps']):raise GovernanceReadError('Recovery specification operation changed')
        refs=[dict(table=t,key=k,key_columns=['id'],reference_status='row') for t,k in [('auth_route_registry',rid),('screens',sid),('api_endpoints',aid)]]
        for cid, in db.execute('SELECT id FROM screen_components WHERE screen_id=? AND file_path=? ORDER BY id',(sid,SOURCE)):
            refs.append(dict(table='screen_components',key=cid,key_columns=['id'],reference_status='row'))
        for key, in db.execute("SELECT resource_id FROM language_resources WHERE context='authRecovery' AND active=1 ORDER BY resource_id"):
            refs.append(dict(table='language_resources',key=key,key_columns=['resource_id'],reference_status='row'))
        api=db.execute('SELECT route_path,http_method,service_name,auth_required,request_schema,response_schema,rate_limit_key FROM api_endpoints WHERE id=?',(aid,)).fetchone()
        plan.update(governance_refs=refs,declared_governance_refs=refs,definition_quality='source_mapped',source_paths=paths,source_sha256=sources,registered_source={'screen_id':sid,'route_registry_id':rid,'api_id':aid,'api':dict(zip(['route_path','http_method','service_name','auth_required','request_schema','response_schema','rate_limit_key'],api)),'view':catalog['views'][mode],'resourceSha256':hashlib.sha256(json.dumps(catalog['locales'],sort_keys=True,ensure_ascii=False).encode()).hexdigest(),'authority':catalog['authority']},gaps=['Current deployed browser/API/email/database proof, complete failure alternatives, accessibility/PWA/cross-platform acceptance and independent review approvals remain required.'])
        encoded=json.dumps(plan,ensure_ascii=False,sort_keys=True);fingerprint=hashlib.sha256(encoded.encode()).hexdigest()
        if fingerprint==rows[0][1]:
            results.append({'flow_id':flow,'changed':False,'definition_sha256':fingerprint});continue
        db._update('virtual_workflow_definitions',{'definition_json':encoded,'definition_sha256':fingerprint,'definition_status':'source_mapped','verification_status':'implemented-unverified','test_status':'stale','blocker_json':json.dumps(plan['gaps']),'updated_at':datetime.datetime.now(datetime.timezone.utc).isoformat()},flow)
        db.db.execute('DELETE FROM '+db.table('virtual_workflow_source_links')+' WHERE flow_id=%s',(flow,))
        for ref in refs:
            values={'flow_id':flow,'source_table':ref['table'],'source_key':str(ref['key']),'source_key_columns':json.dumps(ref['key_columns']),'reference_status':'row'}
            ordinal=db.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+db.table('virtual_workflow_source_links')).fetchone()[0]
            fields=list(values)
            db.db.execute('INSERT INTO '+db.table('virtual_workflow_source_links')+' (_primecare_import_row,'+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*(len(fields)+1))+')',[ordinal,*[db._value('virtual_workflow_source_links',k,values[k]) for k in fields]])
        if db.execute('SELECT flow_id FROM virtual_workflow_checkpoints WHERE flow_id=?',(flow,)).fetchone():
            db.execute('UPDATE virtual_workflow_checkpoints SET invalidation_json=?, updated_at=CURRENT_TIMESTAMP WHERE flow_id=?',(json.dumps([{'reason':'Recovery production controls/API/resource registration reconciled; prior evidence requires current replay','old_definition_sha256':rows[0][1],'definition_sha256':fingerprint}]),flow))
        results.append({'flow_id':flow,'changed':True,'definition_sha256':fingerprint,'source_links':len(refs),'verification_status':'implemented-unverified','test_status':'stale'})
    return results
