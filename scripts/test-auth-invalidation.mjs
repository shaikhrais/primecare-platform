import {build} from 'esbuild';import {test} from 'node:test';import assert from 'node:assert/strict';
const b=await build({entryPoints:['cloudflare/workers/src/auth-invalidation.ts'],bundle:true,write:false,platform:'node',format:'esm'});
const {invalidateSessions,invalidatePasswordResets,invalidateSessionToken}=await import('data:text/javascript;base64,'+Buffer.from(b.outputFiles[0].text).toString('base64'));
for(const [name,invalidate] of [['sessions',invalidateSessions],['reset codes',invalidatePasswordResets],['logout token',invalidateSessionToken]]){
 test(name+' requires a native false postcondition after DELETE',async()=>{const calls=[];await invalidate({query:async(sql,args)=>{calls.push({sql,args});return {rows:sql.startsWith('SELECT')?[{remaining:false}]:[]};}},'owned-user');assert.equal(calls.length,2);assert(calls[0].sql.startsWith('DELETE'));assert(calls[1].sql.startsWith('SELECT'));assert(calls.every(c=>c.args[0]==='owned-user'));});
 for(const rows of [[],null,[null],[{remaining:true}],[{remaining:0}],[{remaining:'false'}],[{}],[{remaining:false},{remaining:false}]])test(name+' rejects incomplete or invalid postcondition '+JSON.stringify(rows),async()=>{await assert.rejects(invalidate({query:async sql=>({rows:sql.startsWith('SELECT')?rows:[]})},'owned-user'));});
 test(name+' never checks or claims success after delete failure',async()=>{let n=0;await assert.rejects(invalidate({query:async()=>{n++;throw Error('synthetic database outage');}},'owned-user'));assert.equal(n,1);});
}
