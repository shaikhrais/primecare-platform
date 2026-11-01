"""Read authoritative service candidates for unresolved theme workflows. Never binds or writes."""
import argparse
import json
from pathlib import Path
from production_reader import connect

GROUPS={
    'calendar':['appointment','calendar','schedule','recurr'],
    'contacts_notes':['contact','note'],
    'messaging_files':['notification','message','mail','file','folder'],
    'academy':['academy','learning','training','course','enrol','certificate'],
    'commerce_finance':['commerce','inventory','purchase','order','payment','invoice','ledger','finance','price','refund'],
    'ai_images_help':['image','knowledge','article','support','help'],
}
p=argparse.ArgumentParser();p.add_argument('--output',required=True);args=p.parse_args()
try:
    with connect() as reader:
        # Pinned reader validates the manifest and enforces SELECT-only PostgreSQL access.
        rows=reader.execute('SELECT id,http_method,route_path,service_name,auth_required,permission_key FROM api_endpoints ORDER BY id').fetchall()
        candidates=[]
        for rid,method,path,service,auth,permission in rows:
            if not isinstance(path,str):continue
            groups=[key for key,terms in GROUPS.items() if any(term in path.lower() for term in terms)]
            if groups:candidates.append({'id':rid,'method':method,'path':path,'service':service,'authRequired':auth,'permissionKey':permission,'candidateGroups':groups,'bindingApproved':False})
        result={'format':1,'authority':'pinned production governance PostgreSQL','manifestSha256':reader.pin['manifestSha256'],
                'readOnly':True,'businessDataRead':False,'writes':0,'roleGrants':0,'runtimeActivated':False,
                'endpointRowsRead':len(rows),'candidateCount':len(candidates),'candidates':candidates,
                'limits':['Keyword matches are candidates, not equivalent workflow contracts or role grants','No endpoint is executed and no service/provider operation is sent','Independent host/role/request/response contract review is required before binding']}
    target=Path(args.output);target.parent.mkdir(parents=True,exist_ok=True);target.write_text(json.dumps(result,indent=2)+'\n')
    print('THEME_SERVICE_CANDIDATES '+json.dumps(result,sort_keys=True))
except Exception:
    raise SystemExit('Theme service candidate read failed; no writes or fallback performed')
