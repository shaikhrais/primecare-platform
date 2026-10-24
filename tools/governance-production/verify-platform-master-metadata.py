"""Read existing identities only. Never writes grants or business records."""
import json
from pathlib import Path
from production_reader import connect

required = {('GET', '/v1/governance/platform'),
            ('GET', '/v1/governance/platform/tenants/{tenantId}/masters'),
            ('POST', '/v1/governance/platform/tenants/{tenantId}/masters')}
with connect() as db:
    screens = db.execute('SELECT id,screen_code,route_path FROM screens WHERE active=1 AND route_path=?',
                         ('/platform/administration',)).fetchall()
    if screens != [(1269, 'PLATFORM_ADMINISTRATION', '/platform/administration')]:
        raise ValueError('Registered administration screen identity drift')
    rows = db.execute('SELECT id,http_method,route_path,service_name,auth_required,permission_key,request_schema,response_schema FROM api_endpoints').fetchall()
    matched = [row for row in rows if (row[1], row[2]) in required]
    if len(matched) != len(required) or {(row[1], row[2]) for row in matched} != required:
        raise ValueError('Registered platform master API identity drift')
    for row in matched:
        if row[3] != 'governance' or row[4] != 1 or row[5] != 'platform_administration_policy' or not row[6] or not row[7]:
            raise ValueError('Registered platform master API contract missing')
report = {'screenId': 1269, 'apiIds': [row[0] for row in matched], 'contractsMatched': len(matched),
          'writesAttempted': False, 'grantsChanged': False, 'businessRecordsRead': False,
          'liveDepartmentCreationVerified': False}
target = Path('test-results/platform-master-metadata'); target.mkdir(parents=True, exist_ok=True)
(target/'identities.json').write_text(json.dumps(report, indent=2)+'\n')
print('PLATFORM_MASTER_IDENTITIES '+json.dumps(report))
