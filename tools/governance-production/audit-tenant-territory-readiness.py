"""Read only pinned workflow metadata; never inspect business accounts or sales."""
import hashlib
import json
import os
from pathlib import Path
from production_reader import connect

root=Path(__file__).resolve().parents[2]
out=root/'test-results/tenant-onboarding';out.mkdir(parents=True,exist_ok=True)
with connect() as db:
    rows=db.execute('SELECT flow_id,definition_status,verification_status,test_status,definition_json,definition_sha256 FROM virtual_workflow_definitions WHERE flow_kind=? ORDER BY flow_id',('business_process',)).fetchall()
    selected=[]
    for flow,definition_status,verification_status,test_status,text,digest in rows:
        if hashlib.sha256(text.encode()).hexdigest()!=digest:raise RuntimeError('Workflow definition hash mismatch')
        definition=json.loads(text)
        search=' '.join([flow,definition.get('title',''),*[str(s.get('api_path') or '') for s in definition.get('steps',[])]]).lower()
        if not any(v in search for v in ['territor','/platform/tenants','/platform/onboarding','/platform/launch','/platform/documents','/platform/setup']):continue
        sources=definition.get('source_paths',[])
        selected.append({'flow':flow,'title':definition.get('title'),
            'definitionStatus':definition_status,'verificationStatus':verification_status,'testStatus':test_status,
            'definitionSha256':digest,'actorRoles':definition.get('actor_roles',[]),
            'steps':[{'action':s.get('action'),'method':s.get('api_method'),'path':s.get('api_path'),'expected':s.get('expected')} for s in definition.get('steps',[])],
            'sourceBindings':[{'path':s,'exists':(root/s).is_file()} for s in sources],
            'flutterSourceBindingRecorded':any(s.endswith('.dart') for s in sources),
            'recordedGaps':definition.get('gaps',[])})
    if not selected:raise RuntimeError('No matching production workflow definitions; do not substitute historical exports')
    api_rows=db.execute("SELECT id,http_method,route_path,implementation_status,permission_key FROM api_endpoints WHERE route_path LIKE ? OR route_path LIKE ? OR route_path LIKE ? ORDER BY id",('/v1/governance/platform/territories%','/v1/governance/platform/tenants%','/v1/governance/platform/onboarding%')).fetchall()
    sections=db.execute("SELECT s.screen_code,s.route_path,x.section_code,x.status,x.file_path FROM screens s JOIN screen_sections x ON x.screen_id=s.id WHERE s.screen_code=? ORDER BY x.section_code",('PLATFORM_ADMINISTRATION',)).fetchall()
    report={'apiRegistrations':[dict(zip(['id','method','path','implementationStatus','permissionKey'],r)) for r in api_rows],
            'presentationSections':[dict(zip(['screen','route','section','status','file'],r)) for r in sections],
            'source':os.environ['GITHUB_SHA'],'authority':'pinned-production-postgresql',
            'businessProcesses':len(rows),'selectedProcesses':len(selected),'writesAttempted':False,
            'registrationDoesNotProveImplementation':True,'flows':selected}
    (out/'production-registry-readiness.json').write_text(json.dumps(report,indent=2))
    print('TENANT_TERRITORY_REGISTRY '+json.dumps(report))
