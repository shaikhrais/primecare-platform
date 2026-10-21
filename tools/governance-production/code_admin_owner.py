"""Bind the approved first Code Admin identity without changing user accounts."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('code-admin-owner.json')
def expected_scope():
    return dict(optInVariable='GOVERNANCE_CODE_ADMIN_OWNER',tables=['platform_hierarchy_policy'],
        policyId='code-admin-owner-v1',definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),
        schemaChanges=False,businessDataWrites=False,accountAssignments=False)
def bind(store):
    if store.pin.get('codeAdminOwnerWriter')!=expected_scope() or os.environ.get('GOVERNANCE_CODE_ADMIN_OWNER')!='1':
        raise GovernanceReadError('Exact owner-binding scope required')
    definition=json.loads(FILE.read_text())
    table=store.table('platform_hierarchy_policy')
    store.db.execute('LOCK TABLE '+table+' IN SHARE ROW EXCLUSIVE MODE')
    if store.execute("SELECT active FROM roles WHERE role_code='code_admin'").fetchall()!=[(1,)]:
        raise GovernanceReadError('Active governed Code Admin role required')
    existing=store.execute('SELECT definition,requirement FROM platform_hierarchy_policy WHERE id=?',(definition['id'],)).fetchall()
    requirement=definition['approvalSource']
    if existing:
        if len(existing)!=1 or json.loads(existing[0][0])!=definition or existing[0][1]!=requirement:
            raise GovernanceReadError('Owner binding changed; preserve existing record')
    else:
        ordinal=store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+table).fetchone()[0]
        store.db.execute('INSERT INTO '+table+' (_primecare_import_row,id,definition,requirement) VALUES (%s,%s,%s,%s)',
            (ordinal,definition['id'],json.dumps(definition,sort_keys=True),requirement))
    return {'ownerBound':True,'roleCode':'code_admin','accountChanges':0,'activation':False}
def main():
    if len(sys.argv)!=2 or sys.argv[1] not in ['--apply','--dry-run']:raise SystemExit('Explicit mode required')
    with ProductionWorkflowStore() as store:
        result=bind(store)
        if result!=bind(store):raise GovernanceReadError('Owner binding must be idempotent')
        if sys.argv[1]=='--dry-run':store.db.rollback()
    print('CODE_ADMIN_OWNER_BOUND '+json.dumps(result))
if __name__=='__main__':main()
