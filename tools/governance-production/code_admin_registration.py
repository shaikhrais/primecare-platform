"""Register the user-approved technical superuser; never assign a live account."""
import copy, hashlib, json, os, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools/workflow-verification'))
from production_store import ProductionWorkflowStore, quote
from production_reader import GovernanceReadError
DEFINITION = Path(__file__).with_name('code-admin-registration.json')
TABLES = ['roles', 'role_screen_permissions', 'platform_hierarchy_policy']

def target_policy(original):
    result = copy.deepcopy(original)
    if 'code_admin' in result['roles']:
        raise GovernanceReadError('Unreviewed Code admin policy already exists')
    result['roles']['code_admin'] = copy.deepcopy(result['roles']['central_admin'])
    result['roles']['code_admin']['trains'] = ['platform_admin', 'tenant_admin']
    result['roles']['code_admin']['bootstrapOnly'] = True
    result['permissions']['code_admin'] = {'view': True, 'create': True, 'edit': True}
    result['protected'].append('code_admin')
    for lang, label in [('en', 'Code Administrator'), ('fr', 'Administrateur technique'), ('es', 'Administrador técnico')]:
        result['locales'][lang]['code_admin'] = label
    if any('code_admin' in role['assignable'] for role in result['roles'].values()):
        raise GovernanceReadError('Code admin cannot be assigned through account management')
    return result

def scope():
    return dict(optInVariable='GOVERNANCE_CODE_ADMIN_REGISTRATION', tables=TABLES,
        definitionSha256=hashlib.sha256(DEFINITION.read_bytes()).hexdigest(),
        screenId=1269, roleCode='code_admin', schemaChanges=False, businessDataWrites=False,
        accountAssignments=False)

def register(store):
    definition = json.loads(DEFINITION.read_text())
    if store.pin.get('codeAdminRegistrationWriter') != scope() or os.environ.get('GOVERNANCE_CODE_ADMIN_REGISTRATION') != '1':
        raise GovernanceReadError('Exact Code admin registration scope required')
    store.db.execute('LOCK TABLE ' + ','.join(store.table(t) for t in TABLES) + ' IN SHARE ROW EXCLUSIVE MODE')
    baseline = definition['baseline']
    fields = list(baseline['roles'][0])
    actual = [dict(zip(fields, row)) for row in store.execute('SELECT '+','.join(fields)+' FROM roles WHERE role_code<>? ORDER BY id', ('code_admin',)).fetchall()]
    if actual != sorted(baseline['roles'], key=lambda r:r['id']):
        raise GovernanceReadError('Role inventory changed; preserve concurrent changes')
    old = baseline['hierarchy']
    target = target_policy(json.loads(old['definition']))
    policy_rows = store.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?', (old['id'],)).fetchall()
    requirement = old['requirement']+'; '+definition['approvalSource']
    if len(policy_rows)!=1 or (json.loads(policy_rows[0][0]),policy_rows[0][1]) not in [(json.loads(old['definition']),old['requirement']), (target,requirement)]:
        raise GovernanceReadError('Hierarchy changed; preserve concurrent changes')
    role_id = max(r['id'] for r in baseline['roles'])+1
    central = next(r for r in baseline['roles'] if r['role_code']=='central_admin')
    expected = {**central, 'id':role_id, 'role_code':'code_admin', 'role_name':definition['displayName']}
    existing = store.execute('SELECT '+','.join(fields)+' FROM roles WHERE role_code=?', ('code_admin',)).fetchall()
    if existing and existing != [tuple(expected[k] for k in fields)]:
        raise GovernanceReadError('Existing Code admin registration differs')
    def insert(table, values):
        ordinal = store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+store.table(table)).fetchone()[0]
        values = {'_primecare_import_row':ordinal, **values}
        keys = list(values)
        store.db.execute('INSERT INTO '+store.table(table)+' ('+','.join(quote(k) for k in keys)+') VALUES ('+','.join(['%s']*len(keys))+')',
            [values[k] if k=='_primecare_import_row' else store._value(table,k,values[k]) for k in keys])
    if not existing:
        insert('roles', {**expected, 'test_email':None, 'test_password':None})
    grant = baseline['screenGrant']
    current = store.execute('SELECT can_view,can_create,can_edit,can_delete,can_export FROM role_screen_permissions WHERE role_id=? AND screen_id=?',(role_id,1269)).fetchall()
    if current and current != [(1,1,1,0,0)]:
        raise GovernanceReadError('Code admin screen grant differs')
    if not current:
        grant_id=store.execute('SELECT MAX(id) FROM role_screen_permissions').fetchone()[0]+1
        insert('role_screen_permissions',{**grant,'id':grant_id,'role_id':role_id})
    changed=store.db.execute('UPDATE '+store.table('platform_hierarchy_policy')+' SET definition=%s,requirement=%s WHERE id=%s', (json.dumps(target,ensure_ascii=False),requirement,old['id']))
    if changed.rowcount!=1:
        raise GovernanceReadError('Hierarchy update did not persist')
    return {'roleId':role_id,'roleCode':'code_admin','screenId':1269,'trainingRoles':definition['trainingRoles'],
        'liveAccountAssignments':0,'independentReviewApprovals':False,'policy':target}

def main():
    if len(sys.argv)!=2 or sys.argv[1] not in ['--apply','--dry-run']:
        raise SystemExit('Explicit --apply or --dry-run required')
    with ProductionWorkflowStore() as store:
        result=register(store)
        if result!=register(store):raise GovernanceReadError('Registration must be idempotent')
        if sys.argv[1]=='--dry-run':store.db.rollback()
    print('CODE_ADMIN_REGISTERED '+json.dumps(result))
if __name__=='__main__':main()
