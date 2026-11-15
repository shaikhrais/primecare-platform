/** Controlled transaction-port regressions. No native PostgreSQL, payment or provider operations. */
import {readFile} from 'node:fs/promises';
import {stripTypeScriptTypes} from 'node:module';
import {createHash} from 'node:crypto';
import {test} from 'node:test';
import assert from 'node:assert/strict';
const source=await readFile(process.env.LEDGER_TEST_SOURCE??new URL('../packages/domain/src/services/LedgerService.ts',import.meta.url),'utf8');
const resultSource=await readFile(new URL('../packages/domain/src/utils/Result.ts',import.meta.url),'utf8');
const auditSource=await readFile(new URL('../packages/domain/src/services/AuditService.ts',import.meta.url),'utf8');
const js=text=>stripTypeScriptTypes(text.replace(/^import .*;\r?\n/gm,''),{mode:'transform'}).replace(/^export /gm,'');
class Decimal{constructor(value){this.value=Number(value);}mul(value){return new Decimal(this.value*Number(value));}valueOf(){return this.value;}}
const LedgerService=new Function('Prisma','CurrencyService','TaxService','createHash',
 js(resultSource)+'\n'+js(auditSource)+'\n'+js(source)+'\nreturn LedgerService;')(
 {Decimal},{convertToBase:async()=>({data:{rate:1,baseCurrency:'CAD'}})},
 {calculateTax:async()=>{throw Error('No tax call in reversal fixture');}},
 createHash);
const accounts=[{id:'cash',tenantId:'tenant-a',code:'1000',type:'ASSET'},{id:'revenue',tenantId:'tenant-a',code:'4000',type:'REVENUE'}];
const original={id:'original',tenantId:'tenant-a',status:'posted',currency:'CAD',exchangeRate:1,
 journalEntries:[{accountId:'cash',debit:100,paidOutAmount:0,account:{code:'1000'}},{accountId:'revenue',debit:0,paidOutAmount:100,account:{code:'4000'}}]};
function fixture({failLedger=false,failVoidAudit=false,failCreationAudit=false,racingReaders=0,allowLegacyNested=false}={}){
 let state={transactions:[structuredClone(original)],journals:[],audits:[],ledgers:[
  {id:'foreign-ledger',tenantId:'tenant-b',referenceId:'original',status:'sealed',amount:700,checksum:'foreign-hash'},
  {id:'original-ledger',tenantId:'tenant-a',referenceId:'original',status:'sealed',amount:100,checksum:'original-hash'}
 ]};
 let queue=Promise.resolve(),transactionCalls=0,rolledBack=0,reads=0,releaseReaders;const events=[];
 const readGate=new Promise(resolve=>releaseReaders=resolve);
 const matches=(row,where)=>Object.entries(where).every(([key,value])=>key==='OR'?value.some(part=>matches(row,part)):row[key]===value);
 const root={tenant:{findUnique:async()=>({taxSettings:null})},$transaction:async callback=>{
  transactionCalls++;let working=structuredClone(state),release,locked=false,tenantLocked=false;
  const claim=async()=>{
   if(locked)return;const wait=queue;queue=new Promise(resolve=>release=resolve);await wait;
   // READ COMMITTED update rechecks the row after the previous writer commits.
   working=structuredClone(state);locked=true;
  };
  const tx={
   tenant:{findUnique:async()=>({taxSettings:null})},
   chartOfAccount:{findFirst:async({where})=>accounts.find(row=>matches(row,where))??null},
   financialTransaction:{
    findUnique:async({where})=>{
     events.push('financial-read');
     const row=working.transactions.find(row=>matches(row,where));
     const copy=row?structuredClone(row):null;
     if(racingReaders&&row?.id==='original'&&!tenantLocked){if(++reads===racingReaders)releaseReaders();await readGate;}
     return copy;
    },
    updateMany:async({where,data})=>{await claim();const rows=working.transactions.filter(row=>matches(row,where));rows.forEach(row=>Object.assign(row,data));return{count:rows.length};},
    update:async({where,data})=>{await claim();const row=working.transactions.find(row=>matches(row,where));if(!row)throw Error('Missing transaction');Object.assign(row,data);return row;},
    create:async({data})=>{const row={id:'reversal-'+working.transactions.length,...data};working.transactions.push(row);return row;}
   },
   journalEntry:{findFirst:async()=>null,create:async({data})=>{working.journals.push(data);return{id:'journal-'+working.journals.length};}},
   transactionLedger:{
    findFirst:async({where})=>working.ledgers.find(row=>matches(row,where))??null,
    create:async({data})=>{if(failLedger)throw Error('ledger unavailable');const row={id:'reversal-ledger-'+working.ledgers.length,...data};working.ledgers.push(row);return row;},
    update:async({where,data})=>{const row=working.ledgers.find(row=>matches(row,where));if(!row)throw Error('Missing ledger');Object.assign(row,data);return row;}
   },
   $executeRaw:async()=>{await claim();return 1;},$queryRaw:async(strings,...values)=>{
    if(strings.join('?').includes('FROM tenants')){await claim();tenantLocked=true;events.push('tenant-lock');return[{id:values[0],recordedAt:new Date()}];}
    return[];
   },
   auditLog:{create:async({data})=>{if(failVoidAudit&&data.action==='VOID_FINANCIAL_TRANSACTION')throw Error('void audit unavailable');if(failCreationAudit&&data.action==='CREATE_FINANCIAL_TRANSACTION')throw Error('creation audit unavailable');working.audits.push(data);return{id:'audit-'+working.audits.length};}}
  };
  // Dedicated lookup/race cases permit the old mock's nested-client shape,
  // isolating those defects from the separate real-client-shape regression.
  if(allowLegacyNested)tx.$transaction=async nested=>nested(tx);
  try{const value=await callback(tx);if(locked)state=working;return value;}
  catch(error){rolledBack++;throw error;}
  finally{release?.();}
 }};
 return{root,state:()=>state,metrics:()=>({transactionCalls,rolledBack,events})};
}
test('reversal reuses a transaction client that has no nested $transaction method',async()=>{
 const f=fixture();const result=await LedgerService.voidTransaction(f.root,'original','tenant-a','actor');
 assert.equal(result.isSuccess,true,result.isFailure?result.error:'');
 assert.equal(f.metrics().transactionCalls,1);
 assert.equal(f.state().transactions[0].status,'voided');
 assert.equal(f.state().transactions.filter(row=>row.type==='REVERSAL').length,1);
 assert.deepEqual(f.state().journals.map(row=>[row.accountId,row.debit,row.paidOutAmount]),[['cash',0,100],['revenue',100,0]]);
});
test('reversal failure rolls back the status claim, journal, audit and ledger changes together',async()=>{
 const f=fixture({failLedger:true});const before=structuredClone(f.state());
 const result=await LedgerService.voidTransaction(f.root,'original','tenant-a','actor');
 assert.equal(result.isFailure,true);assert.match(result.error,/ledger unavailable/);
 assert.deepEqual(f.state(),before);assert.equal(f.metrics().rolledBack,1);
});
test('linked ledger lookup cannot void a foreign tenant row with the same reference ID',async()=>{
 const f=fixture({allowLegacyNested:true});const before=structuredClone(f.state().ledgers[0]);
 const result=await LedgerService.voidTransaction(f.root,'original','tenant-a','actor');
 assert.equal(result.isSuccess,true,result.isFailure?result.error:'');
 assert.deepEqual(f.state().ledgers[0],before);
 const own=f.state().ledgers.find(row=>row.id==='original-ledger');assert.equal(own.status,'voided');
 assert.equal(own.amount,100);assert.equal(own.checksum,'original-hash');
});
test('required void audit failure rolls back the completed reversal and original ledger status link',async()=>{
 const f=fixture({failVoidAudit:true});const before=structuredClone(f.state());
 const result=await LedgerService.voidTransaction(f.root,'original','tenant-a','actor');
 assert.equal(result.isFailure,true);assert.match(result.error,/void audit unavailable/);assert.deepEqual(f.state(),before);
});
test('actual audit Result failure prevents a normal recording transaction from committing',async()=>{
 const f=fixture({failCreationAudit:true});const before=structuredClone(f.state());
 const result=await LedgerService.recordTransaction(f.root,{tenantId:'tenant-a',type:'PAYMENT',entries:[{accountId:'cash',debit:100},{accountId:'revenue',credit:100}]});
 assert.equal(result.isFailure,true);assert.match(result.error,/creation audit unavailable/);assert.deepEqual(f.state(),before);
});
test('wrong-tenant reversal cannot claim or mutate the original transaction',async()=>{
 const f=fixture();const before=structuredClone(f.state());const result=await LedgerService.voidTransaction(f.root,'original','tenant-b','actor');
 assert.equal(result.isFailure,true);assert.match(result.error,/Transaction not found/);assert.deepEqual(f.state(),before);
});
test('concurrent reversal requests can commit only one conditional reversal claim',async()=>{
 const f=fixture({racingReaders:2,allowLegacyNested:true});const results=await Promise.all([
  LedgerService.voidTransaction(f.root,'original','tenant-a','actor-a'),LedgerService.voidTransaction(f.root,'original','tenant-a','actor-b')]);
 assert.equal(results.filter(result=>result.isSuccess).length,1);
 assert.equal(results.filter(result=>result.isFailure).length,1);
 assert.match(results.find(result=>result.isFailure).error,/already voided(?: or changed)?/);
 assert.equal(f.state().transactions.filter(row=>row.type==='REVERSAL').length,1);
 assert.equal(f.state().journals.length,2);assert.equal(f.state().audits.length,2);
});
test('reversal acquires the tenant lock before reading or claiming financial rows',async()=>{
 const f=fixture();const result=await LedgerService.voidTransaction(f.root,'original','tenant-a','actor');
 assert.equal(result.isSuccess,true,result.isFailure?result.error:'');
 assert.deepEqual(f.metrics().events.slice(0,2),['tenant-lock','financial-read']);
});

function sealingFixture({failAudit=false,closedUntil}={}){
 const endDate=new Date('2026-01-31T23:59:59Z');
 let state={transactions:[
  {id:'posted',tenantId:'tenant-a',status:'posted',createdAt:new Date('2026-01-01')},
  {id:'voided',tenantId:'tenant-a',status:'voided',createdAt:new Date('2026-01-01')},
  {id:'sealed',tenantId:'tenant-a',status:'sealed',createdAt:new Date('2026-01-01')},
  {id:'future',tenantId:'tenant-a',status:'posted',createdAt:new Date('2026-02-01')},
  {id:'foreign',tenantId:'tenant-b',status:'posted',createdAt:new Date('2026-01-01')}
 ],tenant:{id:'tenant-a',taxSettings:{existing:'preserve',...(closedUntil===undefined?{}:{closedUntil})}},audits:[]};
 let queue=Promise.resolve();
 const db={$transaction:async callback=>{
  let working=structuredClone(state),release;
  const tx={
   $queryRaw:async(strings,...values)=>{
    assert.match(strings.join('?'),/SELECT id FROM tenants WHERE id = \? FOR NO KEY UPDATE/);
    assert.deepEqual(values,['tenant-a']);
    const wait=queue;queue=new Promise(resolve=>release=resolve);await wait;
    // READ COMMITTED sees the previous seal after acquiring the tenant row lock.
    working=structuredClone(state);return[{id:'tenant-a'}];
   },
   financialTransaction:{updateMany:async({where,data})=>{
    const rows=working.transactions.filter(row=>row.tenantId===where.tenantId&&row.createdAt<=where.createdAt.lte&&
     (where.status.notIn?!where.status.notIn.includes(row.status):row.status!==where.status.not));
    rows.forEach(row=>Object.assign(row,data));return{count:rows.length};
   }},
   tenant:{findUnique:async()=>working.tenant,update:async({data})=>{Object.assign(working.tenant,data);return working.tenant;}},
   auditLog:{create:async({data})=>{if(failAudit)throw Error('seal audit unavailable');working.audits.push(data);return{id:'seal-audit'};}}
  };
  try{const result=await callback(tx);state=working;return result;}finally{release?.();}
 }};
 return{db,endDate,state:()=>state};
}
test('period sealing preserves voided, sealed, future and foreign transaction state',async()=>{
 const f=sealingFixture(),before=structuredClone(f.state());
 const result=await LedgerService.sealLedgerPeriod(f.db,'tenant-a',f.endDate,'actor');
 assert.equal(result.isSuccess,true,result.isFailure?result.error:'');
 assert.equal(result.data.count,1);
 assert.equal(f.state().transactions[0].status,'sealed');
 assert.deepEqual(f.state().transactions.slice(1),before.transactions.slice(1));
 assert.equal(f.state().tenant.taxSettings.existing,'preserve');
 assert.equal(f.state().audits.length,1);assert.equal(f.state().audits[0].action,'SEAL_LEDGER_PERIOD');
});
test('actual seal audit Result failure rolls back transaction statuses and period metadata',async()=>{
 const f=sealingFixture({failAudit:true}),before=structuredClone(f.state());
 const result=await LedgerService.sealLedgerPeriod(f.db,'tenant-a',f.endDate,'actor');
 assert.equal(result.isFailure,true);assert.match(result.error,/seal audit unavailable/);
 assert.deepEqual(f.state(),before);
});
test('an earlier requested cutoff cannot reopen an already sealed period',async()=>{
 const f=sealingFixture({closedUntil:'2026-03-31T23:59:59.000Z'}),before=structuredClone(f.state());
 const result=await LedgerService.sealLedgerPeriod(f.db,'tenant-a',f.endDate,'actor');
 assert.equal(result.isFailure,true);assert.match(result.error,/earlier than the existing sealed period/);
 assert.deepEqual(f.state(),before);
});
test('concurrent seals retain the later committed cutoff and reject backwards replacement',async()=>{
 const f=sealingFixture(),later=new Date('2026-03-31T23:59:59.000Z');
 const results=await Promise.all([
  LedgerService.sealLedgerPeriod(f.db,'tenant-a',later,'later-actor'),
  LedgerService.sealLedgerPeriod(f.db,'tenant-a',f.endDate,'earlier-actor')
 ]);
 assert.equal(results.filter(r=>r.isSuccess).length,1);assert.equal(results.filter(r=>r.isFailure).length,1);
 assert.equal(f.state().tenant.taxSettings.closedUntil,later.toISOString());
 assert.equal(f.state().tenant.taxSettings.sealedBy,'later-actor');assert.equal(f.state().audits.length,1);
});
test('invalid existing cutoff fails closed rather than replacing the period boundary',async()=>{
 const f=sealingFixture({closedUntil:'invalid'}),before=structuredClone(f.state());
 const result=await LedgerService.sealLedgerPeriod(f.db,'tenant-a',f.endDate,'actor');
 assert.equal(result.isFailure,true);assert.match(result.error,/Invalid existing sealed period/);
 assert.deepEqual(f.state(),before);
});
