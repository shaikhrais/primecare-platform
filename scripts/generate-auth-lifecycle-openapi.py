"""Reproducible documentation from exact registered lifecycle contract sources."""
from pathlib import Path
import json,sys
ROOT=Path(__file__).resolve().parents[1]
paths={}
def example(schema,key=''):
 if 'const' in schema:return schema['const']
 if 'enum' in schema:return schema['enum'][0]
 kind=schema.get('type')
 if kind=='object':return {name:example(value,name) for name,value in schema.get('properties',{}).items()}
 if kind=='array':return [example(schema['items'],key) for _ in range(schema.get('minItems',1))] if key!='recoveryCodes' else [chr(65+i)+'A'*25 for i in range(10)]
 if kind=='integer':return schema.get('maximum',schema.get('minimum',0))
 if schema.get('format')=='uuid':return '11111111-1111-4111-8111-111111111111'
 if schema.get('format')=='date-time':return '2026-10-22T12:15:00Z'
 return {'password':'[current password]','code':'123456','challenge':'A'*43,'setupKey':'A'*32,'recoveryCode':'A'*26,'ticket':'SUP-1234','reason':'Investigate tenant sign-in counts'}.get(key,'example')
for filename in ['auth-lifecycle-surface.json','auth-elevation-surface.json']:
 d=json.loads((ROOT/'tools/governance-production'/filename).read_text())
 for e in d['endpoints']:
  permission=e['permission'];method=e.get('method','POST').lower()
  operation={'operationId':e['code'],'description':'Registered contract. Deployment and verification status are tracked separately. Permission: '+permission,
   'x-permission-key':permission,'security':[{'sessionBearer':[]}] if e['authenticated'] else [],
   'responses':{'200':{'description':'Validated operation result','content':{'application/json':{'schema':e['response'],'example':example(e['response'])}}}}}
  if method!='get':operation['requestBody']={'required':True,'content':{'application/json':{'schema':e['request'],'example':example(e['request'])}}}
  for status,description in [('400','Invalid request'),('401','Missing, stale or rejected authority or proof'),('403','Actor, scope or tenant not authorized'),('405','Method not allowed'),('429','Rate limited'),('503','Required authority, audit, database or cryptographic service unavailable')]:
   operation['responses'][status]={'description':description,'content':{'application/json':{'schema':{'type':'object','required':['error'],'properties':{'error':{'type':'string'}}}}}}
  paths.setdefault(e['route'],{})[method]=operation
output={'openapi':'3.1.0','info':{'title':'PrimeCare registered MFA lifecycle and temporary support contracts','version':'1.0.0','description':'Generated from pinned registration definitions. This file establishes no activation, role grants or independent approval.'},'servers':[{'url':'https://primecare-api-gateway.itpro-mohammed.workers.dev'}],'paths':paths,'components':{'securitySchemes':{'sessionBearer':{'type':'http','scheme':'bearer','description':'Existing 43-character opaque session. Management operations require an explicit Authorization header; cookie-only requests are rejected.'}}}}
p=ROOT/'docs/api/auth-lifecycle-openapi.json';text=json.dumps(output,indent=2,ensure_ascii=False)+'\n'
if '--check' in sys.argv:
 if p.read_text()!=text:raise SystemExit('Registered auth OpenAPI documentation is stale')
else:p.write_text(text)
print('Registered auth contracts documented:',len(paths),'paths; no activation')
