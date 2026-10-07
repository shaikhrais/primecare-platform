import {build} from 'esbuild';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
const token='a'.repeat(43),hash=createHash('sha256').update(token).digest('hex'),date='2026-01-01T00:00:00Z';
const plugin={name:'account-page-fixture',setup(b){b.onResolve({filter:/^pg$/},()=>({path:'pg',namespace:'fixture'}));b.onLoad({filter:/.*/,namespace:'fixture'},()=>({loader:'js',contents:'export class Client{async connect(){}async end(){}query(s,v){return globalThis.__accountPageQuery(s,v)}}'}));}};
async function bundle(path,plugins=[]){const r=await build({entryPoints:[path],bundle:true,write:false,platform:'node',format:'esm',plugins});return import('data:text/javascript;base64,'+Buffer.from(r.outputFiles[0].text).toString('base64'));}
const {default:service}=await bundle('cloudflare/workers/src/service.ts',[plugin]),{default:gateway}=await bundle('cloudflare/workers/src/gateway.ts');
const families=[{start:589,path:'/admin/users',collection:'users',kind:'account'},{start:599,path:'/admin/users/creation-audit',collection:'events',kind:'creation'},{start:609,path:'/admin/users/audit',collection:'events',kind:'audit'},{start:619,path:'/admin/users/target/sessions',collection:'sessions',kind:'adminSession'},{start:629,path:'/user/sessions',collection:'sessions',kind:'selfSession'}];
function fixture(c,change=()=>undefined){
 const calls=[];
 const row=c.kind==='account'?{id:'target',email:'target@example.invalid',roles:'rmt',status:'active',updated_at:date}:c.collection==='events'?{id:'event',actorUserId:'actor',targetUserId:'target',created_at:date,action:'account_updated',previous:{role:'rmt'},current:{status:'active'}}:{token_hash:hash,created_at:date,expires_at:'2026-01-02T00:00:00Z',current:true};row.private='private-adapter-field';
 globalThis.__accountPageQuery=async(sql,values)=>{
  calls.push({sql,values});let rows=[];
  if(sql.includes('WHERE s.token_hash=$1'))rows=[{id:'actor',roles:'ceo',tenant_id:'tenant'}];
  else if(sql.startsWith('SELECT id FROM users'))rows=[{id:'target'}];
  else if(sql.startsWith('SELECT COUNT'))rows=[{count:2}];
  else if(sql.startsWith('SELECT'))rows=[row];
  const replacement=change(sql,rows,values);return {rows:replacement===undefined?rows:replacement};
 };
 return {calls,call(query=''){return gateway.fetch(new Request('https://fixture/v1'+c.path+query,{headers:{authorization:'Bearer '+token}}),{AUTH:{fetch:r=>service.fetch(r,{SERVICE_NAME:'auth',DB_URL:'fixture'})}});}};
}
const isPage=sql=>sql.startsWith('SELECT')&&sql.includes('ORDER BY');
async function rejected(f,query=''){const r=await f.call(query);assert.equal(r.status,503);assert.equal(r.headers.get('cache-control'),'no-store');assert.equal(r.headers.get('set-cookie'),null);assert.ok(!(await r.text()).includes('private'));assert.equal(f.calls.at(-1).sql,'ROLLBACK');assert.ok(!f.calls.some(q=>q.sql==='COMMIT'||/^(INSERT|UPDATE|DELETE)/.test(q.sql)));}
const descriptions=['zero total','exhausted offset','malformed identity','duplicate identity','requested binding','invalid timestamp','compatible row shapes','sparse aggregate','empty exhausted page','valid final page and privacy'];
for(const c of families)for(let index=0;index<10;index++)test('batch '+(c.start+index)+' '+c.kind+' '+descriptions[index],async()=>{
 if(index===0)return rejected(fixture(c,sql=>sql.startsWith('SELECT COUNT')?[{count:0}]:undefined));
 if(index===1)return rejected(fixture(c),'?limit=1&offset=2');
 if(index===2){for(const id of ['',null,1,' bad'])await rejected(fixture(c,(sql,rows)=>isPage(sql)?[{...rows[0],[c.collection==='sessions'?'token_hash':'id']:id}]:undefined));return;}
 if(index===3)return rejected(fixture(c,(sql,rows)=>isPage(sql)?[rows[0],{...rows[0]}]:undefined));
 if(index===4){
  if(c.collection==='events')return rejected(fixture(c,(sql,rows)=>isPage(sql)?[{...rows[0],targetUserId:'other'}]:undefined),'?userId=target');
  if(c.kind==='selfSession')return rejected(fixture(c,(sql,rows)=>isPage(sql)?[{...rows[0],current:false}]:undefined));
  if(c.kind==='adminSession')return rejected(fixture(c,(sql,rows)=>sql.startsWith('SELECT id FROM users')?[{id:'other'}]:undefined));
  const f=fixture(c);assert.equal((await f.call('?tenant_id=other')).status,400);assert.ok(!f.calls.some(q=>q.sql.startsWith('SELECT COUNT')));assert.equal(f.calls.at(-1).sql,'ROLLBACK');return;
 }
 if(index===5)return rejected(fixture(c,(sql,rows)=>isPage(sql)?[{...rows[0],[c.kind==='account'?'updated_at':'created_at']:'infinity'}]:undefined));
 if(index===7)return rejected(fixture(c,sql=>sql.startsWith('SELECT COUNT')?new Array(1):undefined));
 if(index===8){const f=fixture(c,sql=>isPage(sql)?[]:undefined),r=await f.call('?offset=2');assert.equal(r.status,200);const b=await r.json();assert.deepEqual(b[c.collection],[]);assert.equal(b.pagination.hasMore,false);assert.equal(f.calls.at(-1).sql,'ROLLBACK');return;}
 const f=fixture(c,(sql,rows)=>isPage(sql)&&index===6?[Object.freeze(Object.assign(Object.create(null),rows[0]))]:undefined),r=await f.call('?limit=1&offset=1');assert.equal(r.status,200);const b=await r.json();assert.equal(b[c.collection].length,1);assert.deepEqual(b.pagination,{limit:1,offset:1,total:2,hasMore:false});assert.ok(!JSON.stringify(b).includes('private'));assert.ok(!JSON.stringify(b).includes(hash));assert.equal(f.calls.at(-1).sql,'ROLLBACK');if(c.collection==='sessions')assert.deepEqual(Object.keys(b.sessions[0]),c.kind==='selfSession'?['created_at','expires_at','current']:['created_at','expires_at']);
});
const {sessionRows}=await bundle('cloudflare/workers/src/session-read-projection.ts');
test('session identities require canonical SHA256 hex and page uniqueness',()=>{for(const token_hash of [null,1,'a'.repeat(63),'A'.repeat(64),'g'.repeat(64),' '+hash])assert.throws(()=>sessionRows([{token_hash}],1));assert.throws(()=>sessionRows([{token_hash:hash},{token_hash:hash}],2));});
test('personal current flags bind to the internal bearer identity',()=>{assert.throws(()=>sessionRows([{token_hash:hash,current:false}],1,hash));assert.throws(()=>sessionRows([{token_hash:'b'.repeat(64),current:true}],1,hash));assert.equal(sessionRows([{token_hash:'b'.repeat(64),current:false}],1,hash).length,1);});
test('valid independent session identities preserve original rows',()=>{const rows=[{token_hash:hash},{token_hash:'b'.repeat(64)}];assert.equal(sessionRows(rows,2)[0],rows[0]);assert.deepEqual(sessionRows([],100),[]);});
