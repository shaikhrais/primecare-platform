"""Approved 2026-09-28: tenant-scoped CEO/HR account creation; default deny."""
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
HR_TARGETS = set('chiropractor physio rmt social_worker therapist intake rn physician cns pediatric caregiver community_outreach franchise_sales gm local_marketing ops_manager partnership regional_bdm regional_manager_usa scrum_master hr_hiring territory_expansion territory_sales volunteer_coordinator premium_concierge vip_manager psw hsw rn_field_supervisor np rpn lpn employee volunteer admin scheduler customer_support qa_specialist'.split())


def apply(db):
    roles = dict(db.execute('SELECT role_code,id FROM roles WHERE active=1'))
    assert HR_TARGETS <= roles.keys() and {'ceo','hr_director'} <= roles.keys()
    with db:
        # User approved GET compatibility plus registered POST on 2026-09-28.
        source = db.execute("SELECT app_id FROM api_endpoints WHERE id=779 AND route_path='/v1/auth/me' AND http_method='POST'").fetchone()
        assert source, 'Expected governed POST session lookup'
        db.execute("""INSERT OR IGNORE INTO api_endpoints
          (app_id,endpoint_code,route_path,http_method,auth_required,implementation_status)
          VALUES(?,'API_V1_AUTH_ME_GET','/v1/auth/me','GET',1,'in_progress')""", source)
        session_schema = {'type':'object','additionalProperties':False,'required':['userId','roles','status'],
          'properties':{'userId':{'type':'string'},'roles':{'type':'string'},'status':{'const':'authenticated'}}}
        db.execute("""UPDATE api_endpoints SET auth_required=1,permission_key='authenticated_self_session',
          response_schema=?,implementation_status='in_progress'
          WHERE route_path='/v1/auth/me' AND http_method IN ('GET','POST')""", (json.dumps(session_schema),))
        db.execute('''CREATE TABLE IF NOT EXISTS auth_setup_policy (
          policy_code TEXT PRIMARY KEY, role_code TEXT NOT NULL,
          entry_point TEXT NOT NULL, scope TEXT NOT NULL, overwrite_existing INTEGER NOT NULL CHECK(overwrite_existing=0))''')
        db.execute('INSERT OR IGNORE INTO auth_setup_policy VALUES(?,?,?,?,0)',
          ('first_ceo','ceo','protected_workflow','existing_active_tenant_without_ceo'))
        db.execute('''CREATE TABLE IF NOT EXISTS auth_account_management_policy (
          actor_role_code TEXT PRIMARY KEY, scope TEXT NOT NULL,
          permitted_fields TEXT NOT NULL, self_modification INTEGER NOT NULL CHECK(self_modification=0))''')
        db.execute('INSERT OR IGNORE INTO auth_account_management_policy VALUES(?,?,?,0)',
                   ('ceo','same_tenant','roles,status'))
        password_schema={'type':'object','additionalProperties':False,'required':['currentPassword','newPassword'],
          'properties':{'currentPassword':{'type':'string','minLength':1},'newPassword':{'type':'string','minLength':12,'description':'Maximum 72 UTF-8 bytes'}}}
        db.execute("UPDATE api_endpoints SET request_schema=?,permission_key='authenticated_self_with_current_password',implementation_status='in_progress' WHERE route_path='/v1/user/change-password' AND http_method='POST'",(json.dumps(password_schema),))
        update_schema={'type':'object','additionalProperties':False,'required':['id','role','status'],
          'properties':{'id':{'type':'string','format':'uuid'},'role':{'type':'string','enum':sorted(roles)},
                        'status':{'enum':['active','inactive']}}}
        db.execute("UPDATE api_endpoints SET request_schema=?,permission_key='auth_account_management_policy',implementation_status='in_progress' WHERE route_path='/v1/admin/users' AND http_method='POST'",(json.dumps(update_schema),))
        db.execute('''CREATE TABLE IF NOT EXISTS auth_account_creation_policy (
          actor_role_id INTEGER NOT NULL REFERENCES roles(id),
          target_role_id INTEGER NOT NULL REFERENCES roles(id),
          scope TEXT NOT NULL CHECK(scope='same_tenant'),
          approval_source TEXT NOT NULL,
          PRIMARY KEY(actor_role_id,target_role_id))''')
        for actor, targets in [('ceo',set(roles)),('hr_director',HR_TARGETS)]:
            for target in sorted(targets):
                db.execute('INSERT OR IGNORE INTO auth_account_creation_policy VALUES(?,?,?,?)',
                           (roles[actor], roles[target], 'same_tenant', 'User approved policy 2026-09-28 13:12 America/Toronto'))
        schema = {'type':'object','additionalProperties':False,'required':['email','password','role'],
                  'properties':{'email':{'type':'string','format':'email','maxLength':254},
                                'password':{'type':'string','minLength':12,'description':'Maximum 72 UTF-8 bytes; never returned.'},
                                'role':{'type':'string','enum':sorted(roles)}}}
        db.execute('''UPDATE api_endpoints SET request_schema=?,permission_key=?,implementation_status=?
          WHERE route_path='/v1/auth/register' AND http_method='POST' ''',
          (json.dumps(schema), 'auth_account_creation_policy', 'in_progress'))
    rows = db.execute('''SELECT a.role_code,t.role_code FROM auth_account_creation_policy p
      JOIN roles a ON a.id=p.actor_role_id JOIN roles t ON t.id=p.target_role_id ORDER BY a.role_code,t.role_code''').fetchall()
    policy = {}
    for actor,target in rows: policy.setdefault(actor,[]).append(target)
    return policy


if __name__ == '__main__':
    with sqlite3.connect(ROOT / '.agents/governance/governance.db') as db:
        db.execute('PRAGMA foreign_keys=ON')
        policy = apply(db)
    output = ROOT / 'cloudflare/workers/src/account-policy.json'
    output.write_text(json.dumps(policy,indent=2)+'\n')
    print('Generated approved account creation policy; default deny; same tenant only.')
