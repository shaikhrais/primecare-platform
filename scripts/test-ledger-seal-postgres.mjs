/** Native-only proof of the actual LedgerService seal path through a thin SQL adapter.
 * This minimal mapped-table fixture is not a production schema or release receipt.
 * Run in its own disposable PostgreSQL database; never alongside another schema-reset suite.
 */
import {readFile} from 'node:fs/promises';
import {stripTypeScriptTypes} from 'node:module';
import {createHash} from 'node:crypto';
import {setTimeout as delay} from 'node:timers/promises';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';

for(const key of ['PRODUCTION_DATABASE_URL','GOVERNANCE_DATABASE_URL','DATABASE_URL','DB_URL','DIRECT_URL']){
 if(Object.hasOwn(process.env,key))throw Error('Production connection variables forbidden in ledger seal fixture');
}
const raw=process.env.LEDGER_SEAL_TEST_DATABASE_URL;
let connection;
if(raw){
 const url=new URL(raw);
 if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='127.0.0.1'||url.port!=='5432'||
    url.pathname!=='/ledger_seal_test'||url.username!=='postgres'||!url.password||url.search||url.hash){
  throw Error('Explicit isolated localhost ledger seal fixture required');
 }
 connection={host:'127.0.0.1',port:5432,database:'ledger_seal_test',user:'postgres',password:decodeURIComponent(url.password),
  ssl:false,connectionTimeoutMillis:5000,application_name:'primecare-ledger-seal-fixture',options:'-c statement_timeout=10000 -c lock_timeout=5000'};
}
const js=text=>stripTypeScriptTypes(text.replace(/^import .*;\r?\n/gm,''),{mode:'transform'}).replace(/^export /gm,'');
const [source,resultSource,auditSource]=await Promise.all([
 readFile(new URL('../packages/domain/src/services/LedgerService.ts',import.meta.url),'utf8'),
 readFile(new URL('../packages/domain/src/utils/Result.ts',import.meta.url),'utf8'),
 readFile(new URL('../packages/domain/src/services/AuditService.ts',import.meta.url),'utf8')
]);
// Sealing never invokes currency/tax/Decimal paths. Refuse any unexpected dependency call.
const notUsed=()=>{throw Error('Unexpected non-sealing dependency');};
const LedgerService=new Function('Prisma','CurrencyService','TaxService','createHash',
 js(resultSource)+'\n'+js(auditSource)+'\n'+js(source)+'\nreturn LedgerService;')(
 {Decimal:class{constructor(){notUsed();}}},{convertToBase:notUsed},{calculateTax:notUsed},createHash);

function transactionRoot(pool,{onStart=()=>{},afterTenantLock=async()=>{}}={}){
 return{$transaction:async callback=>{
  const db=await pool.connect();
  try{
   await db.query('BEGIN ISOLATION LEVEL READ COMMITTED');onStart(db.processID);
   const tx={
    $queryRaw:async(strings,...values)=>{
     const sql=strings.reduce((text,part,index)=>text+part+(index<values.length?'$'+(index+1):''),'');
     const result=await db.query(sql,values);
     if(/^SELECT id FROM tenants WHERE id = \$1 FOR NO KEY UPDATE$/.test(sql))await afterTenantLock();
     return result.rows;
    },
    tenant:{
     findUnique:async({where})=>(await db.query('SELECT id,tax_settings AS "taxSettings" FROM tenants WHERE id=$1',[where.id])).rows[0]??null,
     update:async({where,data})=>(await db.query('UPDATE tenants SET tax_settings=$2::jsonb WHERE id=$1 RETURNING id,tax_settings AS "taxSettings"',[where.id,JSON.stringify(data.taxSettings)])).rows[0]
    },
    financialTransaction:{updateMany:async({where,data})=>{
     const excluded=where.status.notIn??[where.status.not];
     if(!Array.isArray(excluded)||excluded.some(value=>typeof value!=='string'))throw Error('Unsupported seal status predicate');
     const result=await db.query('UPDATE financial_transactions SET status=$4 WHERE tenant_id=$1 AND created_at<=$2 AND status<>ALL($3::text[])',
      [where.tenantId,where.createdAt.lte,excluded,data.status]);
     return{count:result.rowCount};
    }},
    auditLog:{create:async({data})=>(await db.query(`INSERT INTO audit_logs(tenant_id,actor_user_id,action,resource_type,resource_id,metadata)
     VALUES($1,$2,$3,$4,$5,$6::jsonb) RETURNING id`,[data.tenantId,data.actorUserId,data.action,data.resourceType,data.resourceId,JSON.stringify(data.metadata)])).rows[0]}
   };
   const result=await callback(tx);await db.query('COMMIT');return result;
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }};
}
async function fixture(run){
 const pool=new pg.Pool({...connection,max:6});
 try{
  assert.equal((await pool.query('SELECT current_database() AS name')).rows[0].name,'ledger_seal_test');
  await pool.query(`DROP TABLE IF EXISTS audit_logs,financial_transactions,tenants CASCADE;
   DROP FUNCTION IF EXISTS reject_ledger_seal_audit();
   CREATE TABLE tenants(id text PRIMARY KEY,tax_settings jsonb);
   CREATE TABLE financial_transactions(id text PRIMARY KEY,tenant_id text NOT NULL REFERENCES tenants(id),created_at timestamptz NOT NULL,status text NOT NULL);
   CREATE TABLE audit_logs(id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,tenant_id text NOT NULL REFERENCES tenants(id),actor_user_id text,action text,resource_type text,resource_id text,metadata jsonb);
   INSERT INTO tenants VALUES('tenant-a','{"existing":"preserve"}'),('tenant-b','{"foreign":"preserve"}');
   INSERT INTO financial_transactions VALUES
    ('posted','tenant-a','2026-01-01T00:00:00Z','posted'),
    ('voided','tenant-a','2026-01-01T00:00:00Z','voided'),
    ('sealed','tenant-a','2026-01-01T00:00:00Z','sealed'),
    ('future','tenant-a','2026-02-01T00:00:00Z','posted'),
    ('foreign','tenant-b','2026-01-01T00:00:00Z','posted');`);
  await run(pool);
 }finally{await pool.end();}
}
async function snapshot(pool){
 return{
  tenants:(await pool.query('SELECT * FROM tenants ORDER BY id')).rows,
  transactions:(await pool.query('SELECT * FROM financial_transactions ORDER BY id')).rows,
  audits:(await pool.query('SELECT * FROM audit_logs ORDER BY id')).rows
 };
}
const native={skip:!connection},cutoff=new Date('2026-01-31T23:59:59.000Z');
test('native seal preserves voided, sealed, future and foreign rows with exact audit metadata',native,()=>fixture(async pool=>{
 const before=await snapshot(pool),result=await LedgerService.sealLedgerPeriod(transactionRoot(pool),'tenant-a',cutoff,'actor');
 assert.equal(result.isSuccess,true,result.isFailure?result.error:'');assert.equal(result.data.count,1);
 const after=await snapshot(pool);
 for(const row of before.transactions)assert.deepEqual(after.transactions.find(value=>value.id===row.id),row.id==='posted'?{...row,status:'sealed'}:row);
 assert.deepEqual(after.tenants.find(row=>row.id==='tenant-b'),before.tenants.find(row=>row.id==='tenant-b'));
 const settings=after.tenants.find(row=>row.id==='tenant-a').tax_settings;
 assert.equal(settings.closedUntil,cutoff.toISOString());assert.equal(settings.existing,'preserve');assert.equal(settings.sealedBy,'actor');
 assert.equal(after.audits.length,1);assert.equal(after.audits[0].action,'SEAL_LEDGER_PERIOD');
 assert.deepEqual(after.audits[0].metadata,{sealedUntil:cutoff.toISOString(),transactionsAffected:1});
}));
test('native PostgreSQL audit failure rolls back seal statuses and tenant metadata',native,()=>fixture(async pool=>{
 await pool.query(`CREATE FUNCTION reject_ledger_seal_audit() RETURNS trigger LANGUAGE plpgsql AS $$
  BEGIN RAISE EXCEPTION 'isolated seal audit unavailable'; END; $$;
  CREATE TRIGGER reject_seal BEFORE INSERT ON audit_logs FOR EACH ROW EXECUTE FUNCTION reject_ledger_seal_audit();`);
 const before=await snapshot(pool),result=await LedgerService.sealLedgerPeriod(transactionRoot(pool),'tenant-a',cutoff,'actor');
 assert.equal(result.isFailure,true);assert.match(result.error,/isolated seal audit unavailable/);
 assert.deepEqual(await snapshot(pool),before);
}));
test('native backwards and malformed existing cutoffs preserve every record',native,()=>fixture(async pool=>{
 for(const existing of ['2026-03-31T23:59:59.000Z','malformed']){
  await pool.query('UPDATE tenants SET tax_settings=$2::jsonb WHERE id=$1',['tenant-a',JSON.stringify({existing:'preserve',closedUntil:existing})]);
  const before=await snapshot(pool),result=await LedgerService.sealLedgerPeriod(transactionRoot(pool),'tenant-a',cutoff,'actor');
  assert.equal(result.isFailure,true);assert.match(result.error,/earlier than the existing sealed period|Invalid existing sealed period/);
  assert.deepEqual(await snapshot(pool),before);
 }
}));
test('native independent connections wait on actual tenant lock and cannot reopen later cutoff',native,()=>fixture(async pool=>{
 let releaseLater,markLocked,markEarlierStarted;
 const laterHeld=new Promise(resolve=>markLocked=resolve),release=new Promise(resolve=>releaseLater=resolve);
 const earlierStarted=new Promise(resolve=>markEarlierStarted=resolve);
 const later=new Date('2026-03-31T23:59:59.000Z');
 const laterRoot=transactionRoot(pool,{afterTenantLock:async()=>{markLocked();await release;}});
 const earlierRoot=transactionRoot(pool,{onStart:pid=>markEarlierStarted(pid)});
 const laterResult=LedgerService.sealLedgerPeriod(laterRoot,'tenant-a',later,'later-actor');
 let earlierResult;
 try{
  await Promise.race([laterHeld,delay(3000).then(()=>{throw Error('Actual later tenant lock not acquired');})]);
  earlierResult=LedgerService.sealLedgerPeriod(earlierRoot,'tenant-a',cutoff,'earlier-actor');
  const pid=await earlierStarted;let observed=false;
  for(let attempt=0;attempt<40;attempt++){
   const row=(await pool.query('SELECT wait_event_type,query FROM pg_stat_activity WHERE pid=$1',[pid])).rows[0];
   if(row?.wait_event_type==='Lock'&&row.query.includes('FOR NO KEY UPDATE')){observed=true;break;}
   await delay(25);
  }
  assert.equal(observed,true,'Earlier independent connection must wait on actual source tenant-row SQL');
 }finally{
  releaseLater();
  const results=await Promise.all([laterResult,...(earlierResult?[earlierResult]:[])]);
  assert.equal(results[0].isSuccess,true,results[0].isFailure?results[0].error:'');
  if(results[1]){assert.equal(results[1].isFailure,true);assert.match(results[1].error,/earlier than the existing sealed period/);}
 }
 const state=await snapshot(pool),settings=state.tenants.find(row=>row.id==='tenant-a').tax_settings;
 assert.equal(settings.closedUntil,later.toISOString());assert.equal(settings.sealedBy,'later-actor');
 assert.equal(state.audits.length,1);assert.equal(state.audits[0].metadata.sealedUntil,later.toISOString());
}));
