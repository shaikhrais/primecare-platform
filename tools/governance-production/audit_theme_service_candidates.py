"""Read authoritative service candidates for unresolved theme workflows. Never binds or writes."""
import argparse
import hashlib
import json
from datetime import datetime, timezone
from pathlib import Path

GROUPS={
    'calendar':['appointment','calendar','schedule','recurr'],
    'contacts_notes':['contact','note'],
    'messaging_files':['notification','message','mail','file','folder'],
    'academy':['academy','learning','training','course','enrol','certificate'],
    'commerce_finance':['commerce','inventory','purchase','order','payment','invoice','ledger','finance','price','refund'],
    'ai_images_help':['image','knowledge','article','support','help'],
}
def schema_evidence(value):
    if value is None or value == '':
        return {'state':'missing','sha256':None}
    if not isinstance(value,str):
        return {'state':'unexpected_type','sha256':None}
    try:
        parsed=json.loads(value)
    except (ValueError,TypeError):
        return {'state':'invalid_json','sha256':None}
    if not isinstance(parsed,dict):
        return {'state':'not_schema_object','sha256':None}
    return {'state':'json_object_requires_semantic_review',
            'sha256':hashlib.sha256(json.dumps(parsed,sort_keys=True,separators=(',',':')).encode()).hexdigest()}

def capture(reader):
    # Only registered governance metadata. No handler is called and no business
    # record, provider credential or account detail is read.
    rows=reader.execute('SELECT id,http_method,route_path,service_name,auth_required,permission_key,endpoint_code,implementation_status,request_schema,response_schema FROM api_endpoints ORDER BY id').fetchall()
    links={row[0]:row[1] for row in reader.execute('SELECT api_id,COUNT(*) FROM screen_api_links GROUP BY api_id').fetchall()}
    grants={row[0]:{'rows':row[1],'enabledRows':row[2],'authorityEstablished':False} for row in reader.execute('SELECT api_id,COUNT(*),SUM(CASE WHEN can_access=1 THEN 1 ELSE 0 END) FROM api_permissions GROUP BY api_id').fetchall()}
    candidates=[]
    for rid,method,path,service,auth,permission,code,status,request,response in rows:
        if not isinstance(path,str):continue
        groups=[key for key,terms in GROUPS.items() if any(term in path.lower() for term in terms)]
        if groups:candidates.append({'id':rid,'method':method,'path':path,'service':service,'authRequired':auth,
            'permissionKey':permission,'endpointCode':code,'implementationStatus':status,
            'requestSchema':schema_evidence(request),'responseSchema':schema_evidence(response),
            'screenLinkCount':links.get(rid,0),'grantInventory':grants.get(rid,{'rows':0,'enabledRows':0,'authorityEstablished':False}),
            'candidateGroups':groups,'bindingApproved':False})
    return {'format':2,'authority':'pinned production governance PostgreSQL','manifestSha256':reader.pin['manifestSha256'],
            'readOnly':True,'businessDataRead':False,'writes':0,'roleGrants':0,'runtimeActivated':False,
            'endpointRowsRead':len(rows),'candidateCount':len(candidates),'candidates':candidates,
            'limits':['Keyword matches are candidates, not equivalent workflow contracts or role grants',
                      'A parseable schema or enabled grant count does not establish semantic correctness or authority',
                      'No endpoint is executed and no service/provider operation is sent',
                      'Independent host/role/request/response contract review is required before binding']}

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--output',required=True);args=parser.parse_args()
    from production_reader import connect
    try:
        with connect() as reader:
            result=capture(reader)
        result['capturedAt']=datetime.now(timezone.utc).isoformat()
        target=Path(args.output);target.parent.mkdir(parents=True,exist_ok=True);target.write_text(json.dumps(result,indent=2)+'\n')
        print('THEME_SERVICE_CANDIDATES '+json.dumps(result,sort_keys=True))
    except Exception:
        raise SystemExit('Theme service candidate read failed; no writes or fallback performed')

if __name__=='__main__':main()
