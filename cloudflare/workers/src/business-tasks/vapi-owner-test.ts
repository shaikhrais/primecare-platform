import type {SpokenCandidate} from './vapi-spoken-verification.ts';
export type OwnerTest={callId:string;customerPhone:string;email:string;expiresAt:number};
/** Exact user-authorized owner test, not a general outbound enrollment bypass. */
export function ownerTestGrant(env:Record<string,unknown>):OwnerTest|undefined {
 const callId=env.OWNER_TEST_CALL_ID,expiresAt=Number(env.OWNER_TEST_EXPIRES_AT);
 if(env.OWNER_TEST_EMAIL!=='shkh.rais@gmail.com'||env.OWNER_TEST_PHONE!=='+12898873200'||typeof callId!=='string'||!/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/i.test(callId)||!Number.isSafeInteger(expiresAt)||expiresAt<=Date.now()||expiresAt>Date.now()+600000)return;
 return {callId,customerPhone:env.OWNER_TEST_PHONE,email:env.OWNER_TEST_EMAIL,expiresAt};
}
export async function pendingOwnerCandidate(db:any,grant:OwnerTest|undefined,callId:string,phone:string,callSid:string):Promise<SpokenCandidate|null>{
 if(!grant||grant.expiresAt<=Date.now()||grant.callId!==callId||grant.customerPhone!==phone)return null;
 const rows=(await db.query("SELECT u.id::text AS id,u.tenant_id::text AS tenant FROM public.users u JOIN public.tenants t ON t.id=u.tenant_id WHERE LOWER(u.email)=$1 AND u.roles='code_admin' AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2",[grant.email])).rows;
 if(rows.length!==1)return null;const owner=rows[0];
 if((await db.query('SELECT 1 FROM public.communication_voice_verified_contacts WHERE user_id=$1 AND tenant_id=$2',[owner.id,owner.tenant])).rows.length)return null;
 return {actor:{id:owner.id,tenantId:owner.tenant},phone,version:1,callSid,callId};
}
/** Only invoked after the dedicated provider approves a code for this exact call.
 * Current owner/contact locks are rechecked; existing/revoked records preserved. */
export async function enrollApprovedOwner(pool:any,grant:OwnerTest|undefined,c:SpokenCandidate,approved:boolean){
 if(approved!==true||!grant||grant.callId!==c.callId||grant.customerPhone!==c.phone||grant.expiresAt<=Date.now())throw Error('Owner verification unavailable');
 const db=await pool.connect();try{await db.query('BEGIN');await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[JSON.stringify(['voice-contact',c.actor.tenantId,c.actor.id])]);
 const rows=(await db.query("SELECT u.id FROM public.users u JOIN public.tenants t ON t.id=u.tenant_id WHERE u.id::text=$1 AND u.tenant_id::text=$2 AND LOWER(u.email)=$3 AND u.roles='code_admin' AND LOWER(u.status)='active' AND LOWER(t.status)='active' FOR SHARE OF u,t",[c.actor.id,c.actor.tenantId,grant.email])).rows;
 if(rows.length!==1||grant.expiresAt<=Date.now())throw Error('Owner changed');
 const existing=(await db.query('SELECT phone,version::float8 AS version,revoked_at FROM public.communication_voice_verified_contacts WHERE user_id=$1 AND tenant_id=$2 FOR UPDATE',[c.actor.id,c.actor.tenantId])).rows;
 if(existing.length){if(existing.length!==1||existing[0].phone!==c.phone||existing[0].version!==c.version||existing[0].revoked_at!==null)throw Error('Existing contact preserved');}
 else await db.query('INSERT INTO public.communication_voice_verified_contacts(tenant_id,user_id,phone,version,verified_at) VALUES($1,$2,$3,1,now())',[c.actor.tenantId,c.actor.id,c.phone]);
 await db.query('COMMIT');
 }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
}
