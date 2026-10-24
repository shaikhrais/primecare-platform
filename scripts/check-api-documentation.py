"""Verify complete generated comments without calling business endpoints."""
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
folder = ROOT / 'packages/contracts'
spec = json.loads((folder / 'openapi.json').read_text())
coverage = json.loads((folder / 'api-documentation-coverage.json').read_text())
readiness = json.loads((folder / 'api-readiness.json').read_text())
reference = (folder / 'ENDPOINT_REFERENCE.md').read_text()
index = (folder / 'API_DOCUMENTATION_INDEX.md').read_text()
operations = [operation for methods in spec['paths'].values() for operation in methods.values()]
assert len(operations) == coverage['documentedOperations'] == readiness['exported_operations']
assert coverage['registeredRecords'] == readiness['registered_endpoints']
assert coverage['registeredRecords'] == coverage['documentedOperations'] + coverage['omittedOrQuarantinedRecords']
assert coverage['sourceLinkedOperations'] + coverage['registryOnlyOperations'] == coverage['documentedOperations']
assert spec['x-production-ready'] is False and coverage['productionReady'] is False
required = ['Registered operation', 'Purpose and behavior', 'Authentication and permissions', 'Request contract',
            'Response contract', 'Persistence and tenant isolation', 'Rate limiting and audit', 'Required verification',
            'Blocking findings', 'Endpoint-specific implementation references']
for operation in operations:
    assert operation['x-documentation-complete'] is True
    assert all(heading in operation['description'] for heading in required)
    assert f'id="api-{operation["x-governance-id"]}"' in reference
    assert f'ENDPOINT_REFERENCE.md#api-{operation["x-governance-id"]}' in index
    for source in operation['x-documentation-sources']:
        path = (ROOT / source['file']).resolve()
        assert path.is_relative_to(ROOT)
        assert hashlib.sha256(path.read_bytes()).hexdigest() == source['sha256']
print(json.dumps({key: value for key, value in coverage.items() if key != 'operations'}))
