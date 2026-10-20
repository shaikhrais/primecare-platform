"""Bind existing maintenance business processes to its now-registered production contract."""
import hashlib,json,sys,datetime
from pathlib import Path
from maintenance_registration import MaintenanceRegistrationStore,ROOT,quote,GovernanceReadError

from maintenance_catalog import verify

FLOW='auth.inspect-email-config'
FLOWS={FLOW:('GET','/v1/auth/maintenance/configuration','can_view'),'auth.save-email-config':('POST','/v1/auth/maintenance/configuration','can_edit'),'auth.test-maintenance-email':('POST','/v1/auth/maintenance/configuration/test-email','can_edit')}
def bind(db,flow=FLOW):
    if flow not in FLOWS:raise GovernanceReadError('Only existing maintenance workflows may be rebound')
    method,route,permission=FLOWS[flow]
    scope=db.pin['maintenanceRegistrationWriter'].get('workflowBinding',{})
    if scope!={'flowIds':list(FLOWS),'tables':['virtual_workflow_definitions','virtual_workflow_source_links'],'schemaChanges':False,'businessDataWrites':False}:
        raise GovernanceReadError('Exact existing maintenance workflow binding scope required')
    db.db.execute('LOCK TABLE '+db.table('virtual_workflow_source_links')+' IN SHARE ROW EXCLUSIVE MODE')
    metadata=db.tables['virtual_workflow_source_links']
    actual=dict(db.db.execute('SELECT column_name,data_type FROM information_schema.columns WHERE table_schema=%s AND table_name=%s',(db.pin['schema'],'govt_virtual_workflow_source_links')).fetchall())
    expected={'_primecare_import_row':'bigint',**{c['name']:{'integer':'bigint','real':'double precision','text':'text','blob':'bytea'}.get(c['storage_types'][0] if c['storage_types'] else None,'jsonb') for c in metadata['columns']}}
    if actual!=expected:raise GovernanceReadError('Workflow source-link schema differs from pin')
    rows=db.execute('SELECT definition_json,definition_sha256,flow_kind,actor_roles_json FROM virtual_workflow_definitions WHERE flow_id=?',(flow,)).fetchall()
    if len(rows)!=1 or rows[0][2]!='business_process' or sorted(json.loads(rows[0][3]))!=['ceo','maintenance']:
        raise GovernanceReadError('Existing maintenance process/actors required; no new duty is created')
    plan=json.loads(rows[0][0])
    if plan['id']!=flow or sorted(plan['actor_roles'])!=['ceo','maintenance']:raise GovernanceReadError('Unexpected maintenance definition')
    if not any(step.get('api_method')==method and step.get('api_path')==route for step in plan.get('steps',[])):
        raise GovernanceReadError('Existing workflow must already declare this exact operation')
    api=db.execute("SELECT id,http_method,route_path,service_name,auth_required,permission_key,request_schema,response_schema FROM api_endpoints WHERE route_path=? AND http_method=? AND permission_key='role_screen_permissions' AND service_name='auth' AND auth_required=1",(route,method)).fetchall()
    if len(api)!=1:raise GovernanceReadError('Exact registered configuration read API required')
    grants=db.execute('SELECT p.id,r.role_code FROM role_screen_permissions p JOIN roles r ON r.id=p.role_id WHERE p.screen_id=1264 AND p.can_view=1 AND p.'+permission+'=1 AND r.active=1 ORDER BY p.id').fetchall()
    if sorted(r[1] for r in grants)!=['ceo','maintenance']:raise GovernanceReadError('Maintenance '+permission+' authority changed')
    api_roles=db.execute('SELECT r.role_code FROM api_permissions p JOIN roles r ON r.id=p.role_id WHERE p.api_id=? AND p.can_access=1 AND p.permission_key=\'role_screen_permissions\' AND r.active=1',(api[0][0],)).fetchall()
    if sorted(r[0] for r in api_roles)!=['ceo','maintenance']:raise GovernanceReadError('Exact existing maintenance API authority required')
    catalog=json.loads((ROOT/'packages/shared/src/maintenance.json').read_text())
    verify(db,catalog)
    paths=['cloudflare/workers/src/maintenance.ts','cloudflare/workers/src/auth.ts','websites/typescript/src/maintenance.ts','websites/typescript/src/maintenance-client.ts','websites/typescript/src/auth-screen.ts','websites/typescript/src/main.ts','websites/typescript/src/styles.css','packages/shared/src/maintenance.json']
    refs=[dict(table='screens',key=1264,key_columns=['id'],reference_status='row'),dict(table='api_endpoints',key=api[0][0],key_columns=['id'],reference_status='row')]+[dict(table='role_screen_permissions',key=r[0],key_columns=['id'],reference_status='row') for r in grants]
    plan.update(governance_refs=refs,declared_governance_refs=refs,definition_quality='source_mapped',source_paths=paths,source_sha256={path:hashlib.sha256((ROOT/path).read_bytes()).hexdigest() for path in paths},gaps=['Source-mapped production contract; complete acceptance evidence and independent review gates still required.'],registered_source={'screen_id':1264,'api':dict(zip(['id','http_method','route_path','service_name','auth_required','permission_key','request_schema','response_schema'],api[0])),'permission_operation':permission,'permission_rows':[r[0] for r in grants],'controls':catalog['controls'],'resources_sha256':hashlib.sha256(json.dumps(catalog['locales'],sort_keys=True,ensure_ascii=False).encode()).hexdigest(),'authority':catalog['authority']})
    plan.pop('unresolved_governance_refs',None)
    encoded=json.dumps(plan,ensure_ascii=False,sort_keys=True);fingerprint=hashlib.sha256(encoded.encode()).hexdigest()
    if fingerprint==rows[0][1]:return {'flow_id':flow,'definition_sha256':fingerprint,'changed':False}
    db._update('virtual_workflow_definitions',{'definition_json':encoded,'definition_sha256':fingerprint,'definition_status':'source_mapped','test_status':'stale','updated_at':datetime.datetime.now(datetime.timezone.utc).isoformat()},flow)
    # Remove only this flow's obsolete links, then bind exact existing row identities.
    db.db.execute('DELETE FROM '+db.table('virtual_workflow_source_links')+' WHERE flow_id=%s',(flow,))
    for ref in refs:
        values={'flow_id':flow,'source_table':ref['table'],'source_key':str(ref['key']),'source_key_columns':json.dumps(ref['key_columns']),'reference_status':'row'}
        ordinal=db.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+db.table('virtual_workflow_source_links')).fetchone()[0]
        fields=list(values)
        db.db.execute('INSERT INTO '+db.table('virtual_workflow_source_links')+' (_primecare_import_row,'+','.join(map(quote,fields))+') VALUES('+','.join(['%s']*(len(fields)+1))+')',[ordinal,*[db._value('virtual_workflow_source_links',k,values[k]) for k in fields]])
    invalidation=[{'reason':'Existing API, screen view authority and resource/control bindings reconciled through production cutover','old_definition_sha256':rows[0][1],'current_definition_sha256':fingerprint}]
    if db.execute('SELECT flow_id FROM virtual_workflow_checkpoints WHERE flow_id=?',(flow,)).fetchone():
        db.execute('UPDATE virtual_workflow_checkpoints SET invalidation_json=?, updated_at=CURRENT_TIMESTAMP WHERE flow_id=?',(json.dumps(invalidation),flow))
    return {'flow_id':flow,'old_definition_sha256':rows[0][1],'definition_sha256':fingerprint,'changed':True,'business_process_count':db.execute("SELECT COUNT(*) FROM virtual_workflow_definitions WHERE flow_kind='business_process'").fetchone()[0],'actors_unchanged':True,'source_links':len(refs)}

if __name__=='__main__':
    if '--apply' not in sys.argv:raise SystemExit('Explicit --apply required')
    with MaintenanceRegistrationStore() as db:
        result=[bind(db,flow) for flow in FLOWS]
        db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP',('maintenance-workflow-binding-current',json.dumps(result,sort_keys=True)))
    print('MAINTENANCE_FLOW_BINDING_COMMITTED '+json.dumps(result))
