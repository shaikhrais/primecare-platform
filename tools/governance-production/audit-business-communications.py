"""Read-only production requirements inventory. Never reads messages or user records."""
import hashlib
import json
import os
from pathlib import Path
from production_reader import connect
from communication_contract_report import assess_contracts

root = Path(__file__).resolve().parents[2]
terms = ['messag', 'communicat', 'email', 'attachment', 'voice', 'video', 'call', 'task',
    'appointment', 'booking', 'cancel', 'reschedul',
    'twilio', 'vapi', 'telephony', 'integration']
def matches(value):
    return any(term in str(value).lower() for term in terms)

with connect() as db:
    apis = [dict(zip(['id','method','path','status','permission','service','authRequired','requestSchema','responseSchema'], row)) for row in db.execute(
        'SELECT id,http_method,route_path,implementation_status,permission_key,service_name,auth_required,request_schema,response_schema FROM api_endpoints ORDER BY id').fetchall()
        if matches(row[2])]
    screens = [dict(zip(['id','code','route'], row)) for row in db.execute(
        'SELECT id,screen_code,route_path FROM screens WHERE active=1 ORDER BY id').fetchall() if matches(row[1]) or matches(row[2])]
    api_ids = {api['id'] for api in apis}
    links = [dict(zip(['apiId','screenId'], row)) for row in db.execute(
        'SELECT api_id,screen_id FROM screen_api_links').fetchall() if row[0] in api_ids]
    permissions = [dict(zip(['apiId','roleId','permission','canAccess'], row)) for row in db.execute(
        'SELECT api_id,role_id,permission_key,can_access FROM api_permissions').fetchall() if row[0] in api_ids]
    screen_ids = {row['screenId'] for row in links}
    grants = [dict(zip(['screenId','roleId','canView'], row)) for row in db.execute(
        'SELECT screen_id,role_id,can_view FROM role_screen_permissions').fetchall() if row[0] in screen_ids]
    roles = [row[0] for row in db.execute('SELECT id FROM roles WHERE active=1').fetchall()]
    contracts = assess_contracts(apis, links, permissions, grants, roles)
    flows = []
    rows = db.execute('SELECT flow_id,definition_json,definition_sha256,test_status FROM virtual_workflow_definitions WHERE flow_kind=?', ('business_process',)).fetchall()
    for flow_id, text, digest, status in rows:
        if hashlib.sha256(text.encode()).hexdigest() != digest:
            raise RuntimeError('Definition digest mismatch')
        definition = json.loads(text)
        if matches(flow_id) or matches(definition.get('title', '')):
            flows.append({'id':flow_id,'testStatus':status,'definition':definition})
    report = {'source':os.environ['GITHUB_SHA'],'authority':'pinned-production-postgresql',
        'writesAttempted':False,'registrationIsNotVerification':True,'apis':apis,'screens':screens,'flows':flows,
        'contractBindings':contracts,
        'contractSummary':{'total':len(contracts),'metadataComplete':sum(c['metadataComplete'] for c in contracts),
            'liveAcceptanceVerified':0,'grantsChanged':False,
            'gapCounts':{gap:sum(gap in c['metadataGaps'] for c in contracts)
                for gap in sorted({gap for c in contracts for gap in c['metadataGaps']})}}}
    out = root/'test-results/business-communications'
    out.mkdir(parents=True, exist_ok=True)
    (out/'production-inventory.json').write_text(json.dumps(report, indent=2))
    print('BUSINESS_COMMUNICATIONS_REGISTRY '+json.dumps(report))
