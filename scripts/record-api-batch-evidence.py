"""Persist tested source hashes in governance without promoting release gates."""
import hashlib,json,sqlite3
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
evidence=json.loads((ROOT/'docs/api/batch-test-evidence.json').read_text())
if evidence.get('scope')!='local_unit_fixtures' or evidence.get('failed')!=0 or not evidence.get('passed'):
 raise RuntimeError('Passing unit-fixture evidence required')
for path,digest in evidence['sourceHashes'].items():
 if hashlib.sha256((ROOT/path).read_bytes()).hexdigest()!=digest:raise RuntimeError('Stale fixture evidence: '+path)
with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
 db.execute('''CREATE TABLE IF NOT EXISTS api_batch_test_evidence (
  evidence_code TEXT PRIMARY KEY,scope TEXT NOT NULL,passed INTEGER NOT NULL,failed INTEGER NOT NULL,
  source_hashes_json TEXT NOT NULL,production_verified INTEGER NOT NULL DEFAULT 0,postgres_verified INTEGER NOT NULL DEFAULT 0)''')
 db.execute("INSERT OR REPLACE INTO api_batch_test_evidence VALUES('API_BATCHES_1_20',?,?,?,?,0,0)",
  (evidence['scope'],evidence['passed'],evidence['failed'],json.dumps(evidence['sourceHashes'],sort_keys=True)))
 db.execute("UPDATE governance_api_batches SET test_status='unit_tested' WHERE batch IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20)")
 db.execute("UPDATE governance_api_batches SET test_status='unit_tested' WHERE batch=17 AND implementation_status='blocked'")
print('Recorded current API unit-fixture evidence; no production or PostgreSQL claims.')
