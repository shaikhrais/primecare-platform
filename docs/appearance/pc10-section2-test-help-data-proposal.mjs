// Isolated DDL/read-predicate proposal checks, not an authorized Help handler.
import {PGlite} from '@electric-sql/pglite';
import {readFileSync,writeFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import assert from 'node:assert/strict';
import {fileURLToPath} from 'node:url';
const here=new URL('./',import.meta.url);
const migration=readFileSync(new URL('pc10-section2-help-data-proposal.sql',here),'utf8');
const rollback=readFileSync(new URL('pc10-section2-help-data-rollback.sql',here),'utf8');
const results=[];
async function verify(name,fn){await fn();results.push({name,passed:true});}
async function fresh(type){
 const db=new PGlite();
 await db.exec(`CREATE TABLE tenants(id ${type} PRIMARY KEY); CREATE TABLE faqs(id TEXT PRIMARY KEY,question TEXT NOT NULL,answer TEXT NOT NULL,category TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()); INSERT INTO faqs(id,question,answer,category) VALUES('legacy','Existing legacy question','Existing legacy answer','general');`);
 return db;
}
async function rejected(db,sql,values=[],pattern){
 await assert.rejects(()=>(sql===migration||sql===rollback)?db.exec(sql):db.query(sql,values),pattern);
 // Failed multi-statement proposal transaction must be explicitly retired.
 await db.exec('ROLLBACK');
}
for(const type of ['text','uuid']){
 const db=await fresh(type);
 const a=type==='uuid'?'00000000-0000-4000-8000-000000000001':'tenant-a';
 const b=type==='uuid'?'00000000-0000-4000-8000-000000000002':'tenant-b';
 try{
  await verify(type+': migration requires isolated-fixture opt-in',async()=>{
   await rejected(db,migration,[],/isolated fixture/);
   assert.equal((await db.query("SELECT count(*)::INT AS n FROM information_schema.columns WHERE table_name='faqs' AND column_name='tenant_id'")).rows[0].n,0);
  });
  await db.exec("SET primecare.help_proposal_fixture='draft-only'");await db.exec(migration);
  await db.query('INSERT INTO tenants(id) VALUES($1),($2)',[a,b]);
  await verify(type+': old FAQ content preserved and unpublished',async()=>{
   const row=(await db.query("SELECT * FROM faqs WHERE id='legacy'")).rows[0];
   assert.equal(row.question,'Existing legacy question');assert.equal(row.answer,'Existing legacy answer');
   assert.equal(row.tenant_id,null);assert.equal(row.locale,null);assert.equal(row.publication_state,'draft');assert.equal(row.published_at,null);assert.equal(Number(row.revision),1);
  });
  const insert=async(id,tenant,locale,state='published',body='Approved synthetic body')=>db.query('INSERT INTO faqs(id,question,answer,category,tenant_id,locale,publication_state,published_at,summary) VALUES($1,$2,$3,$4,$5,$6,$7,CASE WHEN $7=\'published\' THEN NOW() ELSE NULL END,$8)',[id,'Synthetic '+id,body,'general',tenant,locale,state,'Synthetic summary']);
  await insert('a-en',a,'en');await insert('a-en-2',a,'en');await insert('a-fr',a,'fr');await insert('b-en',b,'en');await insert('draft',a,'en','draft');await insert('withdrawn',a,'en','withdrawn');
  const filters="tenant_id=$1 AND locale=$2 AND publication_state='published' AND published_at<=CURRENT_TIMESTAMP";
  const page=async(tenant,locale,query='',offset=0,limit=25)=>{
   await db.exec('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
   try{
    const where=filters+" AND strpos(lower(question||' '||summary),lower($3))>0";
    const rows=(await db.query('SELECT id,revision,question AS title,category,summary FROM faqs WHERE '+where+' ORDER BY id OFFSET $4 LIMIT $5',[tenant,locale,query.trim(),offset,limit])).rows;
    const total=(await db.query('SELECT count(*)::INT AS n FROM faqs WHERE '+where,[tenant,locale,query.trim()])).rows[0].n;
    await db.exec('COMMIT');return {rows,total};
   }catch(e){await db.exec('ROLLBACK');throw e;}
  };
  const detail=async(tenant,locale,id)=>(await db.query('SELECT id,revision,question AS title,category,answer AS body FROM faqs WHERE '+filters+' AND id=$3',[tenant,locale,id])).rows;
  await verify(type+': list isolates tenant and omits legacy/draft/withdrawn',async()=>{assert.deepEqual((await page(a,'en')).rows.map(r=>r.id),['a-en','a-en-2']);});
  await verify(type+': other tenant list stays independent',async()=>{assert.deepEqual((await page(b,'en')).rows.map(r=>r.id),['b-en']);});
  await verify(type+': exact locale and no locale fallback',async()=>{assert.deepEqual((await page(a,'fr')).rows.map(r=>r.id),['a-fr']);assert.equal((await page(a,'es')).total,0);});
  await verify(type+': other tenant or unpublished detail is absent',async()=>{for(const id of ['b-en','legacy','draft','withdrawn'])assert.deepEqual(await detail(a,'en',id),[]);assert.deepEqual(await detail(a,'fr','a-en'),[]);});
  await verify(type+': detail returns only approved projection',async()=>{const row=(await detail(a,'en','a-en'))[0];assert.deepEqual(Object.keys(row).sort(),['body','category','id','revision','title']);assert.equal(row.body,'Approved synthetic body');});
  await verify(type+': stable paging and empty page keep accurate total',async()=>{const first=await page(a,'en','',0,1),second=await page(a,'en','',1,1),empty=await page(a,'en','',20,1);assert.equal(first.rows[0].id,'a-en');assert.equal(second.rows[0].id,'a-en-2');assert.equal(empty.rows.length,0);assert.equal(empty.total,2);});
  await verify(type+': search treats SQL and wildcard characters as literal data',async()=>{for(const q of ["' OR TRUE--",'%','_'])assert.equal((await page(a,'en',q)).rows.length,0);assert.equal((await page(a,'en','a-en-2')).rows.length,1);});
  await verify(type+': publishing requires assigned tenant/locale/time',async()=>{await rejected(db,"UPDATE faqs SET publication_state='published',published_at=NOW() WHERE id='legacy'",[],/check constraint/);});
  await verify(type+': publication rejects unknown tenant and locale',async()=>{await rejected(db,"INSERT INTO faqs(id,question,answer,category,tenant_id,locale) VALUES('bad-tenant','Q','B','g',$1,'en')",[type==='uuid'?'00000000-0000-4000-8000-000000000099':'missing'],/foreign key/);await rejected(db,"UPDATE faqs SET locale='de' WHERE id='legacy'",[],/check constraint/);});
  await verify(type+': published article identity and UTF16 limits enforced',async()=>{
   await assert.rejects(()=>insert('invalid/id',a,'en'),/check constraint/);
   await assert.rejects(()=>insert('too-long',a,'en','published','😀'.repeat(2501)),/check constraint/);
   await assert.rejects(()=>insert('controls',a,'en','published','bad\x01content'),/check constraint/);
   await insert('unicode-limit',a,'en','published','😀'.repeat(2500));assert.equal((await detail(a,'en','unicode-limit')).length,1);
  });
  await verify(type+': changing published content withdraws it and bumps revision',async()=>{
   await db.query("UPDATE faqs SET answer='Changed synthetic body' WHERE id='a-en'");
   const row=(await db.query("SELECT publication_state,published_at,revision FROM faqs WHERE id='a-en'")).rows[0];assert.equal(row.publication_state,'draft');assert.equal(row.published_at,null);assert.equal(Number(row.revision),2);assert.deepEqual(await detail(a,'en','a-en'),[]);
  });
  await verify(type+': reassignment and manual revision edits rejected',async()=>{
   await rejected(db,"UPDATE faqs SET tenant_id=$1 WHERE id='a-en'",[b],/cannot change tenants/);
   await rejected(db,"UPDATE faqs SET locale='fr' WHERE id='a-en'",[],/cannot change locale/);
   await rejected(db,"UPDATE faqs SET revision=99 WHERE id='a-en'",[],/managed by the database/);
  });
  await verify(type+': stale revision cannot overwrite newer content',async()=>{const r=await db.query("UPDATE faqs SET answer='stale overwrite' WHERE id='a-en' AND revision=1 RETURNING id");assert.equal(r.rows.length,0);});
  await verify(type+': republish is separate and increments revision',async()=>{await db.query("UPDATE faqs SET publication_state='published',published_at=NOW() WHERE id='a-en' AND revision=2");assert.equal(Number((await detail(a,'en','a-en'))[0].revision),3);});
  await verify(type+': future publication time and invalid withdrawal rejected',async()=>{
   await rejected(db,"UPDATE faqs SET published_at=NOW()+INTERVAL '1 hour' WHERE id='a-en'",[],/check constraint/);
   await rejected(db,"UPDATE faqs SET publication_state='withdrawn' WHERE id='a-en'",[],/check constraint/);
  });
  await verify(type+': rollback refuses to discard adopted data',async()=>{await rejected(db,rollback,[],/would discard adopted data/);assert.equal((await detail(a,'en','a-en')).length,1);});
 }finally{await db.close();}
 const clean=await fresh(type);
 try{
  await clean.exec("SET primecare.help_proposal_fixture='draft-only'");await clean.exec(migration);await clean.exec(rollback);
  await verify(type+': unadopted rollback preserves legacy columns and content',async()=>{
   const row=(await clean.query("SELECT * FROM faqs WHERE id='legacy'")).rows[0];assert.equal(row.question,'Existing legacy question');assert.equal(Object.hasOwn(row,'tenant_id'),false);assert.equal(Object.hasOwn(row,'revision'),false);
  });
 }finally{await clean.close();}
}
const receipt={scope:'draft-DDL-and-read-predicates-in-isolated-PGlite-only',migrationSha256:createHash('sha256').update(migration).digest('hex'),rollbackSha256:createHash('sha256').update(rollback).digest('hex'),casesPassed:results.length,results,productionMigrationApplied:false,productionRowsRead:0,productionWrites:0,apiHandlerImplemented:false,hostActivated:false,roleGrantsChanged:0,actualAuthenticationTested:false,humanReviewApproved:false};
const out=fileURLToPath(new URL('pc10-section2-help-data-proposal.validation.json',here));
if(process.argv.includes('--check'))assert.deepEqual(JSON.parse(readFileSync(out,'utf8')),receipt);else writeFileSync(out,JSON.stringify(receipt,null,2)+'\n');
console.log(JSON.stringify({...receipt,results:undefined}));
