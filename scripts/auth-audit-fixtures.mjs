/** Explicit successful RETURNING fixture, shared by tests only. */
export function auditFixture(sql,values) {
 const base={id:'fixture-audit',created_at:'2026-01-01T00:00:00Z'};
 if(sql.startsWith('INSERT INTO auth_account_audit'))return {rows:[{...base,actor_user_id:values[0],target_user_id:values[1],tenant_id:values[2],action:'account_created'}]};
 if(sql.startsWith('INSERT INTO auth_password_audit'))return {rows:[{...base,user_id:values[0],action:'password_changed'}]};
 if(sql.startsWith('INSERT INTO auth_management_audit')) {
  const self=sql.includes('VALUES($1,$1,');
  return {rows:[{...base,actor_user_id:values[0],target_user_id:values[self?0:1],tenant_id:values[self?1:2],previous_state:JSON.parse(values[self?2:3]),new_state:JSON.parse(values[self?3:4])}]};
 }
 return null;
}
