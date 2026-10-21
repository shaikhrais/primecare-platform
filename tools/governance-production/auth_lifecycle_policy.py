"""Register user-requested auth lifecycle requirements; never activate access."""
import hashlib
import json
import os
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError

FILE = Path(__file__).with_name('auth-lifecycle-policy.json')


def scope():
    return dict(optInVariable='GOVERNANCE_AUTH_LIFECYCLE_POLICY_WRITES',
        tables=['platform_hierarchy_policy'], policyId='auth-lifecycle-completion-v1',
        definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),
        schemaChanges=False, businessDataWrites=False, permissionChanges=False, activation=False)


def register(store):
    expected = scope()
    if store.pin.get('authLifecyclePolicyWriter') != expected or os.environ.get(expected['optInVariable']) != '1':
        raise GovernanceReadError('Exact auth lifecycle requirement scope required')
    definition = json.loads(FILE.read_text())
    if definition['activationApproved'] or definition['permissionGrants'] or definition['status'] != 'registered-unimplemented' or any(v != 'pending' for v in definition['approvals'].values()):
        raise GovernanceReadError('Requirements cannot infer implementation or approval')
    roles = {r[0] for r in store.execute("SELECT role_code FROM roles WHERE active=1")}
    if not set(definition['existingRoles']) <= roles:
        raise GovernanceReadError('Existing administrator roles required')
    if store.execute('SELECT screen_code,active FROM screens WHERE id=949').fetchall() != [('mfa', 1)]:
        raise GovernanceReadError('Existing MFA screen required')
    table = store.table('platform_hierarchy_policy')
    store.db.execute('LOCK TABLE ' + table + ' IN SHARE ROW EXCLUSIVE MODE')
    existing = store.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?', (definition['id'],)).fetchall()
    if existing:
        if len(existing) != 1 or json.loads(existing[0][0]) != definition or existing[0][1] != definition['requirement']:
            raise GovernanceReadError('Preserve existing lifecycle requirements')
    else:
        ordinal = store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM ' + table).fetchone()[0]
        store.db.execute('INSERT INTO ' + table + ' (_primecare_import_row,id,definition,requirement) VALUES (%s,%s,%s,%s)',
            (ordinal, definition['id'], json.dumps(definition, sort_keys=True), definition['requirement']))
    return dict(registered=True, implemented=False, permissionGrants=0, accountChanges=0, approvals=False)


if __name__ == '__main__':
    if sys.argv[1:] not in [['--dry-run'], ['--apply']]:
        raise SystemExit('Explicit mode required')
    with ProductionWorkflowStore() as store:
        result = register(store)
        if register(store) != result:
            raise GovernanceReadError('Non-idempotent policy registration')
        if sys.argv[1] == '--dry-run':
            store.db.rollback()
    print('AUTH_LIFECYCLE_REQUIREMENTS ' + json.dumps(result))
