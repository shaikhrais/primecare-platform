/** Only native account scope can become a session claim. Legacy unscoped users
 * retain authentication compatibility, but gain no tenant communication access.
 */
export function sessionTenant(row) {
 const value=row.tenant_id;
 if(value===null||value===undefined)return {};
 if(typeof value!=='string'||!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(value))throw Error('Invalid session tenant');
 return {tenantId:value};
}
