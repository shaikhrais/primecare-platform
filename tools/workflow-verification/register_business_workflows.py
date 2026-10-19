"""Register start-to-end process specifications, separately from legacy role outlines."""
import hashlib
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def register(db, spec, root):
    for key in ('id', 'name', 'start', 'end', 'trigger', 'preconditions', 'acceptance', 'steps'):
        if not spec.get(key):
            raise ValueError('Incomplete process definition: ' + key)
    if [s['order'] for s in spec['steps']] != list(range(1, len(spec['steps']) + 1)):
        raise ValueError('Process steps must be contiguous and ordered')
    if len({a['id'] for a in spec['acceptance']}) != len(spec['acceptance']):
        raise ValueError('Acceptance IDs must be unique')
    if any(not a.get('requirement') or not a.get('test_layer') for a in spec['acceptance']):
        raise ValueError('Every acceptance criterion needs an expectation and test layer')
    for source in spec['sources']:
        path = (root / source).resolve()
        if not path.is_relative_to(root.resolve()) or not path.is_file():
            raise ValueError('Missing or unsafe source: ' + source)
    bindings = spec['bindings']
    role = db.execute('SELECT id FROM roles WHERE role_code=?', (bindings['role_code'],)).fetchone()
    screen = db.execute('SELECT id FROM screens WHERE screen_code=?', (bindings['screen_code'],)).fetchone()
    policy = db.execute('SELECT id FROM care_delivery_policy WHERE id=?', (bindings['policy'],)).fetchone()
    if not role or not screen or not policy:
        raise ValueError('Role, screen and policy must already be governed')
    apis = {}
    for code in bindings['api_codes']:
        row = db.execute('SELECT id FROM api_endpoints WHERE endpoint_code=?', (code,)).fetchone()
        if not row:
            raise ValueError('API is not registered: ' + code)
        apis[code] = row[0]
    if any(s.get('api_code') and s['api_code'] not in apis for s in spec['steps']):
        raise ValueError('Step references an unbound API')
    definition = json.dumps(spec, sort_keys=True)
    fingerprint = hashlib.sha256(definition.encode()).hexdigest()
    db.execute('''CREATE TABLE IF NOT EXISTS business_workflow_specs(
        workflow_id TEXT PRIMARY KEY, name TEXT NOT NULL,
        primary_role_id INTEGER NOT NULL REFERENCES roles(id),
        screen_id INTEGER NOT NULL REFERENCES screens(id),
        definition_json TEXT NOT NULL, specification_sha256 TEXT NOT NULL,
        verification_status TEXT NOT NULL DEFAULT 'implemented-unverified'
          CHECK(verification_status IN ('missing','implemented-unverified','verified','blocked')),
        verification_reason TEXT NOT NULL, updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP)''')
    db.execute('''INSERT INTO business_workflow_specs(workflow_id,name,primary_role_id,
        screen_id,definition_json,specification_sha256,verification_reason)
        VALUES(?,?,?,?,?,?,?) ON CONFLICT(workflow_id) DO UPDATE SET
        name=excluded.name,primary_role_id=excluded.primary_role_id,screen_id=excluded.screen_id,
        definition_json=excluded.definition_json,specification_sha256=excluded.specification_sha256,
        verification_status='implemented-unverified',verification_reason=excluded.verification_reason,
        updated_at=CURRENT_TIMESTAMP
        WHERE business_workflow_specs.specification_sha256<>excluded.specification_sha256''',
        (spec['id'], spec['name'], role[0], screen[0], definition, fingerprint,
         'Existing implementation mapped; real credential login, browser/database correlation, video and required reviews remain unverified.'))
    db.execute('''CREATE VIEW IF NOT EXISTS business_workflow_verification_summary AS SELECT
        COUNT(*) total,COALESCE(SUM(verification_status='missing'),0) missing,
        COALESCE(SUM(verification_status='implemented-unverified'),0) implemented_unverified,
        COALESCE(SUM(verification_status='verified'),0) verified,
        COALESCE(SUM(verification_status='blocked'),0) blocked FROM business_workflow_specs''')
    return fingerprint


if __name__ == '__main__':
    with sqlite3.connect(ROOT / '.agents/governance/governance.db') as db:
        db.execute('PRAGMA foreign_keys=ON')
        for path in sorted(Path(__file__).with_name('specs').glob('*.json')):
            register(db, json.loads(path.read_text()), ROOT)
        db.row_factory = sqlite3.Row
        result = {'scope': 'Newly mapped business processes only; discovery across role outlines is incomplete',
                  'summary': dict(db.execute('SELECT * FROM business_workflow_verification_summary').fetchone()),
                  'processes': [dict(row) for row in db.execute('SELECT workflow_id,name,verification_status,verification_reason,specification_sha256 FROM business_workflow_specs ORDER BY workflow_id')]}
    (ROOT / 'docs/task-progress/business-workflow-status.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result['summary']))
