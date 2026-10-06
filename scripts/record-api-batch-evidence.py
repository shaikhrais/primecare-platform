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
 db.execute("INSERT OR REPLACE INTO api_batch_test_evidence VALUES('API_BATCHES_1_211',?,?,?,?,0,0)",
  (evidence['scope'],evidence['passed'],evidence['failed'],json.dumps(evidence['sourceHashes'],sort_keys=True)))
 db.execute("UPDATE governance_api_batches SET test_status='unit_tested' WHERE batch IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211)")
 db.execute("UPDATE governance_api_batches SET test_status='unit_tested' WHERE batch=17 AND implementation_status='blocked'")
print('Recorded current API unit-fixture evidence; no production or PostgreSQL claims.')
