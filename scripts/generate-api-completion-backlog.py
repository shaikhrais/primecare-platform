"""Record every pending declaration; never infer access or implementation."""
import csv,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
data=json.loads((ROOT/'docs/api/api-execution-inventory.json').read_text())
with (ROOT/'docs/api/API_COMPLETION_BACKLOG.csv').open('w',newline='') as out:
 writer=csv.writer(out);writer.writerow(['id','method','route','declared_service','verification_state','missing_contract_fields','screens','required_next_action'])
 for row in data['data']:
  if row['verificationState']=='unit_fixtures_recorded':continue
  action='Inspect runtime and reconcile declaration; establish exact policy/tenant binding, validation and tests'
  if row['verificationState']=='blocked':action='Resolve documented business/authorization dependency; keep access blocked'
  if row['method']!='GET':action+='; define transactional workflow transitions, idempotency and audit semantics'
  writer.writerow([row['id'],row['method'],row['route'],row['service'],row['verificationState'],';'.join(row['missingContractFields']),';'.join(row['screens']),action])
print('Recorded pending/blocked declaration backlog without implementation inference.')
