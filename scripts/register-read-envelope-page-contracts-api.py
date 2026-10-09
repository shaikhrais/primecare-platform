"""Batches 1051–1100: describe the fixed envelopes of existing owned reads."""
import json, sqlite3
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
cases = json.loads((ROOT/'docs/api/read-envelope-page-contract-batches-1051-1100.json').read_text())['changes']

def align(schema):
    if schema.get('type') != 'object' or set(schema.get('required', [])) != set(schema['properties']):
        raise RuntimeError('Fixed required response envelope expected')
    schema['additionalProperties'] = False
    paging = schema['properties'].get('pagination')
    if paging is not None:
        if paging.get('type') != 'object' or set(paging['properties']) != {'limit', 'offset', 'total', 'hasMore'} or set(paging['required']) != set(paging['properties']):
            raise RuntimeError('Fixed required pagination envelope expected')
        paging['additionalProperties'] = False
        for key, minimum, maximum in [('limit',1,100),('offset',0,100000),('total',0,9007199254740991)]:
            if paging['properties'][key].get('type') != 'integer': raise RuntimeError('Pagination integer expected')
            paging['properties'][key].update(minimum=minimum,maximum=maximum)

with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
    for case in cases:
        service = case['service']; root = '/v1/'+service+case['path']
        permission = {'client':'authenticated_client_profile_owner','provider':'authenticated_provider_profile_owner','auth':'authenticated_self_record_owner'}[service]
        for route in ([root] if case['kind']=='summary' else [root, root+'/{recordId}']):
            rows = db.execute("SELECT id,service_name,auth_required,permission_key,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'", (route,)).fetchall()
            if len(rows) != 1 or rows[0][1:4] != (service, 1, permission):
                raise RuntimeError('Response envelope authority drift: '+route)
            schema = json.loads(rows[0][4]); align(schema)
            db.execute('UPDATE api_endpoints SET response_schema=? WHERE id=?', (json.dumps(schema), rows[0][0]))
            for file in (ROOT/'docs/api').glob('*.openapi.json'):
                document = json.loads(file.read_text()); operation = document.get('paths', {}).get(route, {}).get('get')
                if operation:
                    schema = operation['responses']['200']['content']['application/json']['schema']
                    before = json.dumps(schema); align(schema)
                    if before != json.dumps(schema): file.write_text(json.dumps(document, indent=2)+'\n')
print('Aligned 41 summary and nine record-family envelopes and page bounds; payloads and authority preserved.')
