"""Register the dedicated control-tenant requirement before provisioning it."""
import hashlib,json,os,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/workflow-verification'))
from production_store import ProductionWorkflowStore
from production_reader import GovernanceReadError
FILE=Path(__file__).with_name('code-admin-root.json')
def expected_scope():
    return dict(optInVariable='GOVERNANCE_CODE_ADMIN_ROOT_POLICY',tables=['platform_hierarchy_policy'],
        policyId='code-admin-control-tenant-v1',definitionSha256=hashlib.sha256(FILE.read_bytes()).hexdigest(),
        schemaChanges=False,businessDataWrites=False,accountAssignments=False)
def register(store):
    if store.pin.get('codeAdminRootPolicyWriter')!=expected_scope() or os.environ.get('GOVERNANCE_CODE_ADMIN_ROOT_POLICY')!='1':
        raise GovernanceReadError('Exact control-tenant policy scope required')
    definition=json.loads(FILE.read_text());table=store.table('platform_hierarchy_policy')
    store.db.execute('LOCK TABLE '+table+' IN SHARE ROW EXCLUSIVE MODE')
    if store.execute("SELECT active FROM roles WHERE role_code='code_admin'").fetchall()!=[(1,)]:raise GovernanceReadError('Governed Code Admin role required')
    if len(store.execute("SELECT id FROM platform_hierarchy_policy WHERE id='code-admin-owner-v1'").fetchall())!=1:raise GovernanceReadError('Approved owner binding required')
    rows=store.execute('SELECT definition FROM platform_hierarchy_policy WHERE id=?',(definition['id'],)).fetchall()
    if rows:
        if len(rows)!=1:raise GovernanceReadError('Ambiguous root policy')
        existing=json.loads(rows[0][0]);tenant=existing.pop('tenantId',None);existing.pop('provisioningReceipt',None)
        expected={k:v for k,v in definition.items() if k!='tenantId'}
        if existing!=expected or tenant is not None and not isinstance(tenant,str):raise GovernanceReadError('Root policy drift; preserve existing state')
    else:
        ordinal=store.db.execute('SELECT COALESCE(MAX(_primecare_import_row),-1)+1 FROM '+table).fetchone()[0]
        store.db.execute('INSERT INTO '+table+' (_primecare_import_row,id,definition,requirement) VALUES (%s,%s,%s,%s)',(ordinal,definition['id'],json.dumps(definition),definition['approvalSource']))
    return {'rootPolicyRegistered':True,'businessDataChanges':0,'accountAssignments':0}
def main():
    if len(sys.argv)!=2 or sys.argv[1] not in ['--apply','--dry-run']:raise SystemExit('Explicit mode required')
    with ProductionWorkflowStore() as store:
        result=register(store)
        if result!=register(store):raise GovernanceReadError('Root policy must be idempotent')
        if sys.argv[1]=='--dry-run':store.db.rollback()
    print('CODE_ADMIN_ROOT_POLICY '+json.dumps(result))
if __name__=='__main__':main()
