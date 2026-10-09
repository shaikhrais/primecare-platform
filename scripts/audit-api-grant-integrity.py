"""Diagnose registry/endpoint ID-domain collisions without repairing authority."""
import argparse,hashlib,json,sqlite3
from collections import Counter
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]

def classify(endpoint,registry,grant_key):
    if not endpoint: return 'missing_endpoint'
    if not registry or grant_key!='api_permission_'+registry['endpoint_code']: return 'unknown_key_origin'
    if (endpoint['http_method'],endpoint['route_path'])!=(registry['method'],registry['endpoint_path']):return 'registry_endpoint_identity_mismatch'
    return 'identity_matches_requires_authority_review'

def build():
    db=sqlite3.connect(f"file:{ROOT/'.agents/governance/governance.db'}?mode=ro",uri=True);db.row_factory=sqlite3.Row
    endpoints={r['id']:dict(r) for r in db.execute('select id,endpoint_code,http_method,route_path,permission_key from api_endpoints')}
    registry={r['id']:dict(r) for r in db.execute('select id,api_id,endpoint_code,method,endpoint_path from api_endpoint_registry')}
    pending={o['api'] for o in json.loads((ROOT/'docs/api/api-delivery-checklist.json').read_text())['operations'] if o['stage'] in ['needs_contract_and_verification','needs_reconciliation']}
    counts=Counter();pendingcounts=Counter();items=[]
    for r in db.execute('select api_id,permission_key,count(*) rows,sum(can_access) allowedRows from api_permissions group by api_id,permission_key'):
        e=endpoints.get(r['api_id']);reg=registry.get(r['api_id']);state=classify(e,reg,r['permission_key']);counts[state]+=r['rows']
        api=e['http_method']+' '+e['route_path'] if e else None
        if api in pending:pendingcounts[state]+=r['rows']
        items.append({**dict(r),'classification':state,'pendingOperation':api in pending,'referencedEndpoint':e,'keyOriginRegistry':reg,'authorityAccepted':False})
    pendingitems=[i for i in items if i['pendingOperation']]
    return {'schemeEvidence':{'generator':'scripts/migrate_architecture_tables.py:984-1007','keyScheme':'api_permission_ + api_endpoint_registry.endpoint_code','writtenId':'api_endpoint_registry.id','declaredForeignKey':'api_permissions.api_id -> api_endpoints.id'},'policy':'Fail closed for mismatched or unknown identities. Identity match alone does not establish scoped business authority. No grants reassigned or removed.','summary':{'grantRows':sum(counts.values()),'classifications':dict(counts),'pendingReferencedGrantRows':sum(pendingcounts.values()),'pendingClassifications':dict(pendingcounts),'pendingUniqueOperationsWithGrantRows':len({i['referencedEndpoint']['http_method']+' '+i['referencedEndpoint']['route_path'] for i in pendingitems})},'grantGroups':items}

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--full',action='store_true',help='Include every source grant group instead of compact examples');args=parser.parse_args()
    data=build()
    if not args.full:
        groups=data.pop('grantGroups');data['grantGroupCount']=len(groups)
        data['exampleGrantGroups']=groups[:12]
        data['affectedPendingOperations']=sorted({g['referencedEndpoint']['http_method']+' '+g['referencedEndpoint']['route_path'] for g in groups if g['pendingOperation']})
        data['fullAuditCommand']='python3 scripts/audit-api-grant-integrity.py --full'
    data['sourceHashes']={p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest() for p in ['scripts/migrate_architecture_tables.py','docs/api/api-delivery-checklist.json']}
    (ROOT/'docs/api/api-grant-integrity-audit.json').write_text(json.dumps(data,indent=2)+'\n');print(json.dumps(data['summary']))
