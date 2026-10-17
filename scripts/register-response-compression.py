"""Register and export the transport policy without altering API or readiness records."""
import argparse
import json
import sqlite3
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
POLICY = {'preference': ['zstd', 'br', 'gzip', 'identity'], 'clientHeader': 'Accept-Encoding', 'cloudflareOriginalHeader': 'cf.clientAcceptEncoding', 'excluded': ['internal service binding', 'range', 'no-transform', 'event stream', 'already encoded']}
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--database', type=Path, default=ROOT / '.agents/governance/governance.db')
parser.add_argument('--output', type=Path, default=ROOT / 'docs/transport/compression-policy.json')
args = parser.parse_args()
with sqlite3.connect(args.database) as database:
    database.execute('CREATE TABLE IF NOT EXISTS http_transport_policy (name TEXT PRIMARY KEY, definition TEXT NOT NULL)')
    database.execute('INSERT OR REPLACE INTO http_transport_policy VALUES (?, ?)', ('response_compression', json.dumps(POLICY)))
    exported = json.loads(database.execute('SELECT definition FROM http_transport_policy WHERE name=?', ('response_compression',)).fetchone()[0])
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(exported, indent=2) + '\n')
print('Response compression policy registered and exported; no API or readiness changes')
