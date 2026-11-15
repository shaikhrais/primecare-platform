/** Native-only proof of actual LedgerService recording/reversal/sealing through a thin SQL adapter.
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
// Integer-only recording cases exercise transaction ordering, not FX/Decimal accuracy.
let beforeConvert=async()=>{};
class Decimal{constructor(value){this.value=Number(value);}mul(value){return new Decimal(this.value*Number(value));}}
const notUsed=()=>{throw Error('Unexpected non-sealing dependency');};
const LedgerService=new Function('Prisma','CurrencyService','TaxService','createHash',
 js(resultSource)+'\n'+js(auditSource)+'\n'+js(source)+'\nreturn LedgerService;')(
 {Decimal},{convertToBase:async()=>{await beforeConvert();return{data:{rate:1,baseCurrency:'CAD'}};}},{calculateTax:notUsed},createHash);

function transactionRoot(pool,{onStart=()=>{},afterTenantLock=async()=>{}}={}){
 const tenantRead=async(query,{where})=>(await query('SELECT id,tax_settings AS "taxSettings" FROM tenants WHERE id=$1',[where.id])).rows[0]??null;
 return{tenant:{findUnique:args=>tenantRead((...args)=>pool.query(...args),args)},$transaction:async callback=>{
  const db=await pool.connect();
  try{
   await db.query('BEGIN ISOLATION LEVEL READ COMMITTED');await onStart(db.processID,db);
   const tx={
    $queryRaw:async(strings,...values)=>{
     const sql=strings.reduce((text,part,index)=>text+part+(index<values.length?'$'+(index+1):''),'');
     const result=await db.query(sql,values);
     if(sql.includes('FROM tenants WHERE id = $1 FOR NO KEY UPDATE'))await afterTenantLock();
     return result.rows;
    },
    $executeRaw:async(strings,...values)=>{
     const sql=strings.reduce((text,part,index)=>text+part+(index<values.length?'$'+(index+1):''),'');
     return(await db.query(sql,values)).rowCount;
    },
    tenant:{
     findUnique:args=>tenantRead((...args)=>db.query(...args),args),
     update:async({where,data})=>(await db.query('UPDATE tenants SET tax_settings=$2::jsonb WHERE id=$1 RETURNING id,tax_settings AS "taxSettings"',[where.id,JSON.stringify(data.taxSettings)])).rows[0]
    },
    chartOfAccount:{findFirst:async({where})=>{
     if(where.OR)return(await db.query('SELECT id,tenant_id AS "tenantId",code,type FROM financial_accounts WHERE tenant_id=$1 AND (id=$2 OR code=$3)',[where.tenantId,where.OR[0].id,where.OR[1].code])).rows[0]??null;
     return(await db.query('SELECT id,code,type FROM financial_accounts WHERE tenant_id=$1 AND code=$2',[where.tenantId,where.code])).rows[0]??null;
    }},
    financialTransaction:{findUnique:async({where})=>{
     const row=(await db.query('SELECT id,tenant_id AS "tenantId",status FROM financial_transactions WHERE id=$1 AND tenant_id=$2',[where.id,where.tenantId])).rows[0];
     if(!row)return null;
     row.journalEntries=(await db.query('SELECT j.account_id AS "accountId",j.debit,j.paid_out_amount AS "paidOutAmount",json_build_object(\'code\',a.code) AS account FROM journal_entries j JOIN financial_accounts a ON a.id=j.account_id WHERE j.transaction_id=$1',[row.id])).rows;
     return row;
    },create:async({data})=>(await db.query("INSERT INTO financial_transactions(id,tenant_id,status) VALUES('recorded', $1,$2) RETURNING id",[data.tenantId,data.status])).rows[0],updateMany:async({where,data})=>{
     if(where.id){const result=await db.query('UPDATE financial_transactions SET status=$4 WHERE id=$1 AND tenant_id=$2 AND status=$3',[where.id,where.tenantId,where.status,data.status]);return{count:result.rowCount};}
     const excluded=where.status.notIn??[where.status.not];
     if(!Array.isArray(excluded)||excluded.some(value=>typeof value!=='string'))throw Error('Unsupported seal status predicate');
     const result=await db.query('UPDATE financial_transactions SET status=$4 WHERE tenant_id=$1 AND created_at<=$2 AND status<>ALL($3::text[])',
      [where.tenantId,where.createdAt.lte,excluded,data.status]);
     return{count:result.rowCount};
    }},
    journalEntry:{findFirst:async()=>null,create:async({data})=>(await db.query('INSERT INTO journal_entries(tenant_id,transaction_id,account_id,debit,paid_out_amount) VALUES($1,$2,$3,$4,$5) RETURNING id',[data.tenantId,data.transactionId,data.accountId,data.debit,data.paidOutAmount])).rows[0]},
    transactionLedger:{findFirst:async()=>null,create:async({data})=>(await db.query('INSERT INTO transaction_ledger(tenant_id,reference_id,checksum) VALUES($1,$2,$3) RETURNING id',[data.tenantId,data.referenceId,data.checksum])).rows[0]},
    auditLog:{create:async({data})=>(await db.query(`INSERT INTO audit_logs(tenant_id,actor_user_id,action,resource_type,resource_id,metadata)
     VALUES($1,$2,$3,$4,$5,$6::jsonb) RETURNING id`,[data.tenantId,data.actorUserId,data.action,data.resourceType,data.resourceId,JSON.stringify(data.metadata)])).rows[0]}
   };
   const result=await callback(tx);await db.query('COMMIT');return result;
  }catch(error){await db.query('ROLLBACK');throw error;}finally{db.release();}
 }};
}
async function fixture(run){
 beforeConvert=async()=>{};
 const pool=new pg.Pool({...connection,max:6});
 try{
  assert.equal((await pool.query('SELECT current_database() AS name')).rows[0].name,'ledger_seal_test');
  await pool.query(`DROP TABLE IF EXISTS audit_logs,journal_entries,transaction_ledger,financial_accounts,financial_transactions,tenants CASCADE;
   DROP FUNCTION IF EXISTS reject_ledger_seal_audit();
   CREATE TABLE tenants(id text PRIMARY KEY,tax_settings jsonb);
   CREATE TABLE financial_transactions(id text PRIMARY KEY,tenant_id text NOT NULL REFERENCES tenants(id),created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,status text NOT NULL);
   CREATE TABLE audit_logs(id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,tenant_id text NOT NULL REFERENCES tenants(id),actor_user_id text,action text,resource_type text,resource_id text,metadata jsonb);
   CREATE TABLE financial_accounts(id text PRIMARY KEY,tenant_id text NOT NULL REFERENCES tenants(id),code text,type text);
   CREATE TABLE journal_entries(id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,tenant_id text NOT NULL REFERENCES tenants(id),transaction_id text REFERENCES financial_transactions(id),account_id text REFERENCES financial_accounts(id),debit integer,paid_out_amount integer,created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP);
   CREATE TABLE transaction_ledger(id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,tenant_id text NOT NULL REFERENCES tenants(id),reference_id text REFERENCES financial_transactions(id),checksum text,created_at timestamptz NOT NULL DEFAULT statement_timestamp());
   INSERT INTO tenants VALUES('tenant-a','{"existing":"preserve"}'),('tenant-b','{"foreign":"preserve"}');
   INSERT INTO financial_accounts VALUES('cash','tenant-a','1000','ASSET'),('revenue','tenant-a','4000','REVENUE');
   INSERT INTO financial_transactions VALUES
    ('posted','tenant-a','2026-01-01T00:00:00Z','posted'),
    ('voided','tenant-a','2026-01-01T00:00:00Z','voided'),
    ('sealed','tenant-a','2026-01-01T00:00:00Z','sealed'),
    ('future','tenant-a','2026-02-01T00:00:00Z','posted'),
    ('foreign','tenant-b','2026-01-01T00:00:00Z','posted');`);
  await run(pool);
 }finally{beforeConvert=async()=>{};await pool.end();}
}
async function snapshot(pool){
 return{
  tenants:(await pool.query('SELECT * FROM tenants ORDER BY id')).rows,
  transactions:(await pool.query('SELECT * FROM financial_transactions ORDER BY id')).rows,
  audits:(await pool.query('SELECT * FROM audit_logs ORDER BY id')).rows
 };
}
const native={skip:!connection},cutoff=new Date('2026-01-31T23:59:59.000Z');
const recordInput={tenantId:'tenant-a',type:'TEST',actorUserId:'actor',entries:[{accountId:'cash',debit:100},{accountId:'revenue',credit:100}]};
test('native open-period recording adapter commits actual financial, journal, audit and ledger rows',native,()=>fixture(async pool=>{
 const result=await LedgerService.recordTransaction(transactionRoot(pool),recordInput);
 assert.equal(result.isSuccess,true,result.isFailure?result.error:'');
 assert.equal((await pool.query("SELECT count(*)::int n FROM financial_transactions WHERE id='recorded' AND status='posted'")).rows[0].n,1);
 assert.equal((await pool.query('SELECT count(*)::int n FROM journal_entries')).rows[0].n,2);
 assert.deepEqual((await pool.query('SELECT account_id,debit,paid_out_amount FROM journal_entries ORDER BY id')).rows,
  [{account_id:'cash',debit:100,paid_out_amount:0},{account_id:'revenue',debit:0,paid_out_amount:100}]);
 assert.equal((await pool.query('SELECT count(*)::int n FROM transaction_ledger')).rows[0].n,1);
 assert.equal((await pool.query("SELECT count(*)::int n FROM audit_logs WHERE action='CREATE_FINANCIAL_TRANSACTION'")).rows[0].n,1);
}));
test('native recording preflight cannot bypass a seal committed while currency work awaited',native,()=>fixture(async pool=>{
 let releaseCurrency,markCurrency;
 const held=new Promise(resolve=>markCurrency=resolve),released=new Promise(resolve=>releaseCurrency=resolve);
 beforeConvert=async()=>{markCurrency();await released;};
 const root=transactionRoot(pool),recording=LedgerService.recordTransaction(root,recordInput);
 try{
  await Promise.race([held,delay(3000).then(()=>{throw Error('Recording did not reach currency await after preflight');})]);
  const sealed=await LedgerService.sealLedgerPeriod(root,'tenant-a',new Date('2099-01-01T00:00:00.000Z'),'seal-actor');
  assert.equal(sealed.isSuccess,true,sealed.isFailure?sealed.error:'');
 }finally{releaseCurrency();}
 const result=await recording;
 assert.equal(result.isFailure,true);assert.match(result.error,/Financial period is sealed/);
 assert.equal((await pool.query("SELECT count(*)::int n FROM financial_transactions WHERE id='recorded'")).rows[0].n,0);
 assert.equal((await pool.query('SELECT count(*)::int n FROM journal_entries')).rows[0].n,0);
 assert.equal((await pool.query('SELECT count(*)::int n FROM transaction_ledger')).rows[0].n,0);
 assert.equal((await pool.query("SELECT count(*)::int n FROM audit_logs WHERE action='CREATE_FINANCIAL_TRANSACTION'")).rows[0].n,0);
}));
test('native recording rejects its database transaction timestamp even after a seal lock waits beyond the cutoff',native,()=>fixture(async pool=>{
 const boundary=(await pool.query("SELECT clock_timestamp()+interval '2 seconds' AS cutoff")).rows[0].cutoff;
 let releaseSeal,markHeld,markRecording;
 const held=new Promise(resolve=>markHeld=resolve),release=new Promise(resolve=>releaseSeal=resolve);
 const started=new Promise(resolve=>markRecording=resolve);
 const sealing=LedgerService.sealLedgerPeriod(transactionRoot(pool,{afterTenantLock:async()=>{markHeld();await release;}}),'tenant-a',boundary,'seal-actor');
 let recording;
 try{
  await Promise.race([held,delay(3000).then(()=>{throw Error('Seal did not acquire the tenant lock');})]);
  recording=LedgerService.recordTransaction(transactionRoot(pool,{onStart:async(pid,db)=>{
   const timestamp=(await db.query('SELECT transaction_timestamp() AS timestamp')).rows[0].timestamp;
   markRecording({pid,timestamp});
  }}),recordInput);
  const {pid,timestamp}=await Promise.race([started,delay(3000).then(()=>{throw Error('Recording transaction did not start');})]);
  assert.ok(timestamp<=boundary,'Recording transaction must start inside the soon-to-be sealed period');
  let observed=false;
  for(let attempt=0;attempt<40;attempt++){
   const row=(await pool.query('SELECT wait_event_type,query FROM pg_stat_activity WHERE pid=$1',[pid])).rows[0];
   if(row?.wait_event_type==='Lock'&&row.query.includes('FOR NO KEY UPDATE')){observed=true;break;}
   await delay(25);
  }
  assert.equal(observed,true,'Recorder must wait on the actual tenant-row lock');
  let elapsed=false;
  for(let attempt=0;attempt<120;attempt++){
   if((await pool.query('SELECT clock_timestamp()>$1 AS elapsed',[boundary])).rows[0].elapsed){elapsed=true;break;}
   await delay(25);
  }
  assert.equal(elapsed,true,'Server wall clock must pass the cutoff before releasing the lock');
 }finally{releaseSeal();}
 const sealed=await sealing;assert.equal(sealed.isSuccess,true,sealed.isFailure?sealed.error:'');
 const result=await recording;assert.equal(result.isFailure,true);assert.match(result.error,/Financial period is sealed/);
 assert.equal((await pool.query("SELECT count(*)::int n FROM financial_transactions WHERE id='recorded'")).rows[0].n,0);
 assert.equal((await pool.query('SELECT count(*)::int n FROM journal_entries')).rows[0].n,0);
 assert.equal((await pool.query('SELECT count(*)::int n FROM transaction_ledger')).rows[0].n,0);
 assert.equal((await pool.query("SELECT count(*)::int n FROM audit_logs WHERE action='CREATE_FINANCIAL_TRANSACTION'")).rows[0].n,0);
}));
test('native reversal waits for tenant seal lock before claiming financial rows',native,()=>fixture(async pool=>{
 await pool.query("INSERT INTO journal_entries(tenant_id,transaction_id,account_id,debit,paid_out_amount) VALUES('tenant-a','posted','cash',100,0),('tenant-a','posted','revenue',0,100)");
 let releaseSeal,markHeld,markReversal;
 const held=new Promise(resolve=>markHeld=resolve),release=new Promise(resolve=>releaseSeal=resolve);
 const started=new Promise(resolve=>markReversal=resolve);
 const sealing=LedgerService.sealLedgerPeriod(transactionRoot(pool,{afterTenantLock:async()=>{markHeld();await release;}}),'tenant-a',new Date('2099-01-01T00:00:00.000Z'),'seal-actor');
 let reversal;
 try{
  await Promise.race([held,delay(3000).then(()=>{throw Error('Seal did not acquire the tenant lock');})]);
  reversal=LedgerService.voidTransaction(transactionRoot(pool,{onStart:pid=>markReversal(pid)}),'posted','tenant-a','void-actor');
  const pid=await Promise.race([started,delay(3000).then(()=>{throw Error('Reversal transaction did not start');})]);
  let observed=false;
  for(let attempt=0;attempt<40;attempt++){
   const row=(await pool.query('SELECT wait_event_type,query FROM pg_stat_activity WHERE pid=$1',[pid])).rows[0];
   if(row?.wait_event_type==='Lock'&&row.query.includes('FOR NO KEY UPDATE')){observed=true;break;}
   await delay(25);
  }
  assert.equal(observed,true,'Reversal must wait on the actual tenant-row lock');
  const available=await pool.query("SELECT id FROM financial_transactions WHERE id='posted' FOR UPDATE NOWAIT");
  assert.equal(available.rows[0].id,'posted','Waiting reversal must not hold the financial row needed by sealing');
 }finally{releaseSeal();}
 const sealed=await sealing;assert.equal(sealed.isSuccess,true,sealed.isFailure?sealed.error:'');
 const result=await reversal;assert.equal(result.isFailure,true);assert.match(result.error,/Financial period is sealed/);
 assert.equal((await pool.query("SELECT status FROM financial_transactions WHERE id='posted'")).rows[0].status,'sealed');
 assert.equal((await pool.query("SELECT count(*)::int n FROM financial_transactions WHERE id='recorded'")).rows[0].n,0);
 assert.equal((await pool.query('SELECT count(*)::int n FROM journal_entries')).rows[0].n,2);
 assert.equal((await pool.query('SELECT count(*)::int n FROM transaction_ledger')).rows[0].n,0);
 assert.equal((await pool.query("SELECT count(*)::int n FROM audit_logs WHERE action IN ('CREATE_FINANCIAL_TRANSACTION','VOID_FINANCIAL_TRANSACTION')")).rows[0].n,0);
}));
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
