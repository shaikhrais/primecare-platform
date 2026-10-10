import assert from 'node:assert/strict';
import {createHash,randomBytes} from 'node:crypto';
import PostalMime from 'postal-mime';
export async function verifyAuthEmailRecovery({db,call,check,email,actorId,password}) {
 const account=process.env.CLOUDFLARE_ACCOUNT_ID, token=process.env.CLOUDFLARE_API_TOKEN;
 if(!account||!token)throw new Error('Cloudflare email verification credentials missing');
 const base=`https://api.cloudflare.com/client/v4/accounts/${account}`;
 async function api(path){const r=await fetch(base+path,{headers:{Authorization:`Bearer ${token}`},signal:AbortSignal.timeout(30000)});assert.ok(r.ok,'Private inbox API authorized');const j=await r.json();assert.ok(j.success,'Private inbox API successful');return j;}
 const namespaces=(await api('/storage/kv/namespaces?per_page=100')).result;
 const namespace=namespaces.find(n=>n.title==='primecare-email-inbox');assert.ok(namespace,'Private inbox exists');
 const started=Date.now();
 const initial=await call('/v1/auth/login','POST',{email,password});check(initial.status===200,'pre-recovery session established');
 const recovery=await call('/v1/auth/forgot-password','POST',{email});check(recovery.status===200,'real account recovery accepted');
 let code;
 const deadline=Date.now()+180000;
 while(!code&&Date.now()<deadline){
  let cursor;
  do{
   const list=await api(`/storage/kv/namespaces/${namespace.id}/keys?prefix=${encodeURIComponent('inbox/'+email+'/')}&limit=1000${cursor?'&cursor='+encodeURIComponent(cursor):''}`);
   for(const key of list.result){
    const r=await fetch(`${base}/storage/kv/namespaces/${namespace.id}/values/${encodeURIComponent(key.name)}`,{headers:{Authorization:`Bearer ${token}`},signal:AbortSignal.timeout(30000)});
    if(!r.ok)continue;const mail=await r.json();
    if(mail.to!==email||Date.parse(mail.receivedAt)<started)continue;
    const parsed=await PostalMime.parse(Buffer.from(mail.rawBase64,'base64'));
    const found=parsed.text?.match(/one-time code in the PrimeCare app:\s*([A-F0-9]{12})\b/);
    if(found){code=found[1];break;}
   }
   cursor=list.result_info?.cursor;
  }while(cursor&&!code);
  if(!code)await new Promise(resolve=>setTimeout(resolve,10000));
 }
 check(Boolean(code),'actual recovery code received and stored in Cloudflare');
 const hash=createHash('sha256').update(email+':'+code).digest('hex');
 const stored=await db.query('SELECT user_id,expires_at FROM auth_password_resets WHERE token_hash=$1',[hash]);
 check(stored.rows.length===1&&stored.rows[0].user_id===actorId,'received code matches stored reset hash');
 const next=randomBytes(24).toString('base64url');
 check((await call('/v1/auth/reset-password','POST',{email,code,newPassword:'short'})).status===400,'weak recovery password rejected');
 const wrong=code==='000000000000'?'FFFFFFFFFFFF':'000000000000';
 check((await call('/v1/auth/reset-password','POST',{email,code:wrong,newPassword:next})).status===400,'incorrect reset code rejected');
 await db.query("UPDATE auth_password_resets SET expires_at=NOW()-INTERVAL '1 minute' WHERE token_hash=$1 AND user_id=$2",[hash,actorId]);
 check((await call('/v1/auth/reset-password','POST',{email,code,newPassword:next})).status===400,'expired reset code rejected');
 await db.query("UPDATE auth_password_resets SET expires_at=NOW()+INTERVAL '5 minutes' WHERE token_hash=$1 AND user_id=$2",[hash,actorId]);
 const reset=await call('/v1/auth/reset-password','POST',{email,code,newPassword:next});
 check(reset.status===200&&reset.data.reauthenticationRequired===true,'received email code resets password');
 check((await call('/v1/auth/me','GET',undefined,initial.data.token)).status===401,'recovery reset revokes previous sessions');
 check((await call('/v1/auth/reset-password','POST',{email,code,newPassword:next})).status===400,'reset code cannot be reused');
 check((await call('/v1/auth/login','POST',{email,password})).status===401,'pre-reset password rejected');
 const login=await call('/v1/auth/login','POST',{email,password:next});check(login.status===200,'reset password authenticates');
 check((await db.query('SELECT token_hash FROM auth_password_resets WHERE user_id=$1',[actorId])).rows.length===0,'consumed reset codes removed');
 const {verifyClientAuthBrowser}=await import('./verify-client-auth-browser.mjs');
 await verifyClientAuthBrowser(email,next);check(true,'published browser login and logout after email recovery');
 await call('/v1/auth/logout','POST',{},login.data.token);
}
