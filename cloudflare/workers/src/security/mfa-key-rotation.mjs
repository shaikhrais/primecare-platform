import {activeMfaKeyId,mfaStorageKey,rewrapMfaSeed} from './mfa-keyring.mjs';

/** Protected operator/scheduled use only. No public endpoint or key material in results.
 * Lock users before credentials, matching login/replacement. Defer a live pending
 * replacement so its original-envelope proof remains valid during migration.
 */
export async function rotateMfaStorageBatch(db,env,{fromKeyId,toKeyId,limit=10}={}) {
  if (!['mfa-v1','mfa-v2'].includes(fromKeyId) || !['mfa-v1','mfa-v2'].includes(toKeyId) ||
      fromKeyId===toKeyId || !Number.isInteger(limit) || limit<1 || limit>50 || activeMfaKeyId(env)!==toKeyId) throw Error('Invalid MFA rotation scope');
  mfaStorageKey(env,fromKeyId);
  await db.query('BEGIN');
  try {
    const users=await db.query(`SELECT u.id::text AS id,u.tenant_id::text AS tenant_id FROM users u
      JOIN auth_mfa_credentials c ON c.user_id=u.id::text AND c.tenant_id=u.tenant_id::text
      WHERE c.envelope->>'keyId'=$1 AND NOT EXISTS
        (SELECT 1 FROM auth_mfa_replacement_challenges p WHERE p.user_id=u.id::text AND p.expires_at>NOW())
      ORDER BY u.id LIMIT $2 FOR UPDATE OF u SKIP LOCKED`,[fromKeyId,limit]);
    if(!Array.isArray(users.rows)||users.rows.length>limit)throw Error('Invalid MFA rotation selection');
    let rewrapped=0;
    for(const user of users.rows) {
      const rows=(await db.query('SELECT envelope,tenant_id FROM auth_mfa_credentials WHERE user_id=$1 FOR UPDATE',[user.id])).rows;
      if(rows.length!==1||rows[0].tenant_id!==user.tenant_id||rows[0].envelope.keyId!==fromKeyId)throw Error('MFA rotation identity changed');
      const envelope=await rewrapMfaSeed(env,rows[0].envelope,user);
      const changed=await db.query('UPDATE auth_mfa_credentials SET envelope=$2 WHERE user_id=$1 AND tenant_id=$3 AND envelope=$4::jsonb RETURNING user_id',
        [user.id,JSON.stringify(envelope),user.tenant_id,JSON.stringify(rows[0].envelope)]);
      if(changed.rows.length!==1||changed.rows[0].user_id!==user.id)throw Error('MFA rotation persistence failed');
      const id=crypto.randomUUID();
      const audited=await db.query("INSERT INTO auth_mfa_lifecycle_audit(id,user_id,tenant_id,action) VALUES($1,$2,$3,'server_key_rewrapped') RETURNING id",[id,user.id,user.tenant_id]);
      if(audited.rows.length!==1||audited.rows[0].id!==id)throw Error('MFA rotation audit failed');
      rewrapped++;
    }
    await db.query('COMMIT');
    return {rewrapped};
  }catch(error){await db.query('ROLLBACK');throw error;}
}
