/** Execute the actual LedgerService against isolated dependency/database ports; no database or provider connections. */
import {readFile} from 'node:fs/promises';
import {stripTypeScriptTypes} from 'node:module';
import {test} from 'node:test';
import assert from 'node:assert/strict';

const source=await readFile(process.env.LEDGER_TEST_SOURCE??new URL('../packages/domain/src/services/LedgerService.ts',import.meta.url),'utf8');
const resultSource=await readFile(new URL('../packages/domain/src/utils/Result.ts',import.meta.url),'utf8');
const js=text=>stripTypeScriptTypes(text.replace(/^import .*;\r?\n/gm,''),{mode:'transform'}).replace(/^export /gm,'');
const {createHash}=await import('node:crypto');
// Integer-only fixture arithmetic: these cases verify account isolation, not Decimal or tax algorithms.
class Decimal{constructor(value){this.value=Number(value);}mul(value){return new Decimal(this.value*Number(value));}}
const LedgerService=new Function('Prisma','CurrencyService','TaxService','AuditService','createHash',
 js(resultSource)+'\n'+js(source)+'\nreturn LedgerService;')(
 {Decimal},
 {convertToBase:async()=>({data:{rate:1,baseCurrency:'CAD'}})},
 {calculateTax:async()=>{throw Error('No tax provider allowed in account-isolation fixture');}},
 {recordLog:async()=>{}},createHash);

const local={id:'local-account',tenantId:'tenant-a',code:'1000',type:'ASSET'};
const foreign={id:'foreign-account',tenantId:'tenant-b',code:'1000',type:'ASSET'};
const credit={id:'local-credit',tenantId:'tenant-a',code:'2000',type:'LIABILITY'};
function fixture(accounts=[foreign,local,credit]){
 const writes=[],locks=[],lookups=[];
 // Model the Prisma AND/OR predicate against both tenants rather than returning a canned account.
 const matches=(row,where)=>Object.entries(where).every(([key,value])=>key==='OR'?value.some(part=>matches(row,part)):row[key]===value);
 const db={
  tenant:{findUnique:async()=>({taxSettings:null})},
  chartOfAccount:{findFirst:async({where})=>{lookups.push(where);return accounts.find(row=>matches(row,where))??null;}},
  $transaction:async callback=>callback(db),
  $executeRaw:async(strings,...values)=>{locks.push(values);return 1;},
  $queryRaw:async()=>[],
  financialTransaction:{create:async({data})=>{writes.push(['transaction',data]);return{id:'transaction-a'};}},
  journalEntry:{findFirst:async()=>null,create:async({data})=>{writes.push(['journal',data]);return{id:'journal-a'};}},
  transactionLedger:{create:async({data})=>{writes.push(['ledger',data]);return{id:'ledger-a'};}}
 };
 return{db,writes,locks,lookups};
}
const input=accountId=>({tenantId:'tenant-a',type:'TEST',entries:[{accountId,debit:100},{accountId:'local-credit',credit:100}]});

test('foreign tenant primary account ID is denied before locking or financial writes',async()=>{
 const f=fixture();const result=await LedgerService.recordTransaction(f.db,input(foreign.id));
 assert.equal(result.isFailure,true);
 assert.match(result.error,/Invalid Account Reference/);
 assert.equal(f.locks.length,0);
 assert.equal(f.writes.length,0);
});
test('owned primary account IDs retain the existing transaction and balanced journal path',async()=>{
 const f=fixture();const result=await LedgerService.recordTransaction(f.db,input(local.id));
 assert.equal(result.isSuccess,true);
 assert.deepEqual(f.writes.filter(([kind])=>kind==='journal').map(([,row])=>row.accountId),[local.id,credit.id]);
 assert.equal(f.writes.filter(([kind])=>kind==='transaction').length,1);
 assert.equal(f.writes.filter(([kind])=>kind==='ledger').length,1);
 assert.ok(f.writes.every(([,row])=>row.tenantId==='tenant-a'));
});
test('account code fallback selects the current tenant even when another tenant has the same code',async()=>{
 const f=fixture();const result=await LedgerService.recordTransaction(f.db,input('1000'));
 assert.equal(result.isSuccess,true);
 assert.equal(f.writes.find(([kind])=>kind==='journal')[1].accountId,local.id);
});
test('foreign-only account code fails closed without financial writes',async()=>{
 const f=fixture([foreign,credit]);const result=await LedgerService.recordTransaction(f.db,input('1000'));
 assert.equal(result.isFailure,true);
 assert.equal(f.writes.length,0);
 assert.equal(f.locks.length,0);
});
