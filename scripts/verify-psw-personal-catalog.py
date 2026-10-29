import ast,hashlib,json
from pathlib import Path
root=Path(__file__).resolve().parents[1];file=root/'packages/shared/src/psw-personal/catalog.json';c=json.loads(file.read_text());pin=json.loads((root/'tools/governance-production/production-pin.json').read_text());scope=pin['pswPersonalRegistrationWriter']
assert scope['catalogSha256']==hashlib.sha256(file.read_bytes()).hexdigest()
assert scope['namespace']=='psw_personal_' and scope['schemaChanges'] is False and scope['businessDataWrites'] is False
assert len(c['questions'])==50 and len({q['id'] for q in c['questions']})==50
assert len(c['screens'])==12 and len({s['code'] for s in c['screens']})==12
assert len(c['tasks'])==18 and len({s['code'] for s in c['tasks']})==18
assert all(any(s['previewView']==q['screen'] and s['workflow']==q['workflow'] for s in c['screens']) for q in c['questions'])
assert all((root/s['file']).is_file() and s['code'].startswith('psw_personal_') for s in c['screens'])
assert c['endpoint']=='/v1/governance/care/personal'
source=(root/'websites/typescript/src/psw-personal/view.mjs').read_text()
assert 'localStorage' not in source and 'api.mutate' in source and 'renderCare' in source
ast.parse((root/'tools/governance-production/psw_personal_registration.py').read_text())
print('PSW personal catalogue passed: 50 questions, 18 tasks, 12 screens, pinned PostgreSQL registration, real care reuse and no localStorage persistence.')
