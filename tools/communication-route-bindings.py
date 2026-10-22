"""Reproduce Dart routing from the persisted production contract read-back."""
import json
import re
import sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
catalog=json.loads((ROOT/'packages/shared/src/communications/registered-contracts.json').read_text())
definition=json.loads((ROOT/'tools/governance-production/communications-registration.json').read_text())
if (catalog.get('authority')!='pinned-production-postgresql' or
    not re.fullmatch('[0-9a-f]{40}',catalog.get('sourceCommit','')) or
    not isinstance(catalog.get('registrationRun'),int) or catalog.get('roleGrantsChanged') is not False):
    raise RuntimeError('Production read-back provenance required')
lines=[f"// Generated from pinned production read-back, registration run {catalog['registrationRun']}.",
       '// Routing only: no role grants or live feature acceptance.',
       "import 'dio_communication_transport.dart';",'',
       'final registeredCommunicationBindings = Map<String, CommunicationRouteBinding>.unmodifiable({']
seen=set(); api_ids=set()
for op in definition['operations']:
    rows=[row for row in catalog['apis'] if row['operation']==op['key']]
    if len(rows)!=1:raise RuntimeError('Missing or duplicate registered communication operation')
    row=rows[0]
    if row['id'] in api_ids:raise RuntimeError('Duplicate API identity')
    api_ids.add(row['id'])
    if (row['method']!=op['method'] or row['path']!=op['path'] or row['service']!=definition['service'] or
        row['authRequired']!=1 or row['permission']!=definition['permission'] or
        row['requestSchema']!=op['request'] or row['responseSchema']!=op['response'] or
        row['status'] not in ['registered-unimplemented','implemented'] or
        ('existingId' in op and row['id']!=op['existingId'])):
        raise RuntimeError('Production communication contract differs from pinned registration')
    schemas=op['request'].get('oneOf',[op['request']])
    # Several query variants (e.g. inbound/outbound mailbox scopes) can share
    # one action-less GET binding; duplicates across operations still fail.
    actions=list(dict.fromkeys(schema.get('properties',{}).get('action',{}).get('const') for schema in schemas))
    for action in actions:
        key=op['key'] if action is None else op['key'].split('.')[0]+'.'+action
        if key in seen:raise RuntimeError('Duplicate channel action')
        seen.add(key)
        suffix=', includeAction: false' if action is None else ''
        lines.append(f"  '{key}': CommunicationRouteBinding(path: '{row['path']}', method: '{row['method']}'{suffix}), // API{row['id']}")
if len(catalog['apis'])!=len(definition['operations']):raise RuntimeError('Unexpected registered communication operation')
lines.append('});');expected='\n'.join(lines)+'\n'
path=ROOT/'packages/flutter_core/lib/communications/registered_communication_bindings.dart'
if sys.argv[1:]==['--write']:path.write_text(expected)
elif sys.argv[1:]:raise SystemExit('Only --write or check mode is supported')
elif path.read_text()!=expected:raise RuntimeError('Shared Dart routes differ from production read-back; regenerate explicitly')
print(f'Communication bindings: {len(api_ids)} registered APIs, {len(seen)} shared channel actions; no grants')
