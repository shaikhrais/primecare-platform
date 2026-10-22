"""Read-only production requirements inventory. Never reads messages or user records."""
import hashlib
import json
import os
from pathlib import Path
from production_reader import connect

root = Path(__file__).resolve().parents[2]
terms = ['messag', 'communicat', 'email', 'attachment', 'voice', 'video', 'call', 'task']
def matches(value):
    return any(term in str(value).lower() for term in terms)

with connect() as db:
    apis = [dict(zip(['id','method','path','status','permission'], row)) for row in db.execute(
        'SELECT id,http_method,route_path,implementation_status,permission_key FROM api_endpoints ORDER BY id').fetchall()
        if matches(row[2])]
    screens = [dict(zip(['id','code','route'], row)) for row in db.execute(
        'SELECT id,screen_code,route_path FROM screens WHERE active=1 ORDER BY id').fetchall() if matches(row[1]) or matches(row[2])]
    flows = []
    rows = db.execute('SELECT flow_id,definition_json,definition_sha256,test_status FROM virtual_workflow_definitions WHERE flow_kind=?', ('business_process',)).fetchall()
    for flow_id, text, digest, status in rows:
        if hashlib.sha256(text.encode()).hexdigest() != digest:
            raise RuntimeError('Definition digest mismatch')
        definition = json.loads(text)
        if matches(flow_id) or matches(definition.get('title', '')):
            flows.append({'id':flow_id,'testStatus':status,'definition':definition})
    report = {'source':os.environ['GITHUB_SHA'],'authority':'pinned-production-postgresql',
        'writesAttempted':False,'registrationIsNotVerification':True,'apis':apis,'screens':screens,'flows':flows}
    out = root/'test-results/business-communications'
    out.mkdir(parents=True, exist_ok=True)
    (out/'production-inventory.json').write_text(json.dumps(report, indent=2))
    print('BUSINESS_COMMUNICATIONS_REGISTRY '+json.dumps(report))
