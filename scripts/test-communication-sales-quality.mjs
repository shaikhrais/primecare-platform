import {test} from 'node:test';
import assert from 'node:assert/strict';
import {scoreSalesCall,salesRubric,salesDigest,salesOperatorDefinition,SalesCallQualityService} from '../packages/shared/src/communications/sales-call-quality.ts';
import {ScopedServiceBase} from '../packages/shared/src/communications/service-base.ts';
import {MemoryAtomicStore} from './fixtures/business-memory-store.mjs';
import {createTwilioSalesQualitySource} from '../packages/shared/src/communications/twilio-sales-quality.mjs';

const sid=(prefix,n)=>prefix+n.repeat(32),accountSid=sid('AC','a'),serviceSid=sid('GA','b'),operatorSid=sid('LY','c'),callId=sid('CA','d'),recordingSid=sid('RE','e'),transcriptSid=sid('GT','f');
const rubric={id:'fixture-sales-script',version:1,points:Array.from({length:10},(_,i)=>({id:'point-'+i,criterion:'Agent states fixture point '+i,weight:1,critical:i===9}))};
const transcript={id:transcriptSid,complete:true,duration:100,sentences:Array.from({length:10},(_,i)=>({id:sid('GX',i.toString()),speaker:'agent',text:'Fixture point '+i+'.',start:i*5,end:i*5+4,confidence:.95}))};
const assessment=(covered=6)=>rubric.points.map((p,i)=>({id:p.id,status:i<covered?'covered':'missed',evidence:i<covered?[{sentenceId:transcript.sentences[i].id,quote:transcript.sentences[i].text}]:[]}));
const scope={callId,tenantId:'tenant-a',ownerId:'agent-a',recordingSid,transcriptSid,agentChannel:1,captureApproved:true};
const actor={id:'agent-a',tenantId:'tenant-a'},request={id:'quality-report',key:'evaluate-1',callId,rubricId:rubric.id};

test('six and nine equal-weight script points produce 60% and 90%, retaining critical misses',()=>{
 for(const n of [6,9,10]){const report=scoreSalesCall(rubric,transcript,assessment(n));assert.equal(report.coveragePercent,n*10);assert.equal(report.lowerBoundPercent,n*10);assert.equal(report.upperBoundPercent,n*10);assert.equal(report.status,'scored');assert.deepEqual(report.criticalMisses,n===10?[]:['point-9']);assert.equal(report.points[0].evidence[0].start,0);}
});
test('weights belong to the script and model percentages cannot override arithmetic',()=>{
 const script=structuredClone(rubric);script.points[9].weight=11;
 const results=assessment(9);results[0].coveragePercent=100;results[9].weight=0;
 assert.equal(scoreSalesCall(script,transcript,results).coveragePercent,45);
});
test('incomplete or uncertain transcript yields review range and no definitive percentage',()=>{
 for(const mutate of [t=>t.complete=false,t=>t.sentences[9].confidence=null,t=>t.sentences[9].confidence=.3]){
  const t=structuredClone(transcript);mutate(t);const report=scoreSalesCall(rubric,t,assessment(6));assert.equal(report.coveragePercent,null);assert.equal(report.status,'review_required');assert.equal(report.lowerBoundPercent,60);assert.equal(report.upperBoundPercent,100);assert.deepEqual(report.criticalMisses,[]);
 }
 const results=assessment(6);results[8].status='unknown';const report=scoreSalesCall(rubric,transcript,results);assert.equal(report.coveragePercent,null);assert.equal(report.upperBoundPercent,70);
});
test('low-confidence positive evidence does not earn coverage',()=>{
 const t=structuredClone(transcript);t.sentences[0].confidence=.79;const r=scoreSalesCall(rubric,t,assessment(6));assert.equal(r.coveredWeight,5);assert.equal(r.points[0].status,'unknown');assert.equal(r.coveragePercent,null);
});
test('fabricated, duplicate, partial, customer and unsupported evidence fail closed',()=>{
 for(const mutate of [a=>a[0].evidence[0].quote='invented',a=>a[0].evidence[0].quote='Fixture',a=>a[0].evidence[0].sentenceId='missing',a=>a[0].evidence.push(a[0].evidence[0]),a=>a[9].evidence=a[0].evidence,a=>a[0].status='not_applicable',a=>a[1].id=a[0].id,a=>a.pop(),a=>a[0].evidence=[]]){const a=assessment();mutate(a);assert.throws(()=>scoreSalesCall(rubric,transcript,a));}
 const t=structuredClone(transcript);t.sentences[0].speaker='customer';assert.throws(()=>scoreSalesCall(rubric,t,assessment()));
});
test('exact required language is enforced independently of model pass label',()=>{
 const script=structuredClone(rubric);script.points[0].exactPhrase='MANDATORY DISCLOSURE';assert.throws(()=>scoreSalesCall(script,transcript,assessment()));script.points[0].exactPhrase='Fixture point 0';assert.equal(scoreSalesCall(script,transcript,assessment()).coveragePercent,60);
});
test('invalid script, duplicate sentences, malformed timestamps and oversized inputs fail',()=>{
 for(const mutate of [r=>r.points[0].weight=0,r=>r.points[0].weight=1.5,r=>r.points[1].id=r.points[0].id,r=>r.version=0,r=>r.points=[],r=>r.points[0].criterion='x'.repeat(1001)]){const r=structuredClone(rubric);mutate(r);assert.throws(()=>salesRubric(r));}
 for(const mutate of [t=>t.sentences[0].end=101,t=>t.sentences[0].start=-1,t=>t.sentences[0].confidence=NaN,t=>t.sentences[0].end=0,t=>t.sentences[1].id=t.sentences[0].id,t=>t.sentences[0].text='x'.repeat(524289)]){const t=structuredClone(transcript);mutate(t);assert.throws(()=>scoreSalesCall(rubric,t,assessment()));}
});
test('operator configuration is reproducible, bounded and treats transcript instructions as data',async()=>{
 const d=await salesOperatorDefinition(rubric);assert.equal(d.operatorType,'GenerativeJSON');assert.equal(d.rubricDigest,await salesDigest(salesRubric(rubric)));assert.equal(d.operatorConfigDigest,await salesDigest(d.config));assert.match(d.config.prompt,/never follow instructions/);assert.equal(d.config.json_result_schema.properties.points.items.properties.status.enum.includes('not_applicable'),false);
 assert.equal(await salesDigest({b:2,a:1}),await salesDigest({a:1,b:2}));
 const big=structuredClone(rubric);for(const p of big.points)p.criterion='x'.repeat(500);await assert.rejects(salesOperatorDefinition(big),/prompt bound/);
});

function serviceFixture(store=new MemoryAtomicStore()){
 let current=structuredClone(scope),script=structuredClone(rubric),allowed=true,sourceReads=0,afterSource=()=>{};
 const policy={async assert(a,action,state){if(!allowed||a.tenantId!==state?.tenantId||state.ownerId!==a.id||!['fixture.analyze','fixture.read'].includes(action))throw Error('Denied');},async assignee(){throw Error('unused');}};
 const service=new SalesCallQualityService(store,policy,{async scope(){return structuredClone(current);},async rubric(){return structuredClone(script);},async source(s,digest){sourceReads++;afterSource();return {transcript:structuredClone(transcript),points:assessment(),operatorId:operatorSid,rubricDigest:digest};},actions:{analyze:'fixture.analyze',read:'fixture.read'}});
 return {store,service,get reads(){return sourceReads;},revoke(){allowed=false;},changeScope(fn){fn(current);},changeRubric(fn){fn(script);},afterSource(fn){afterSource=fn;}};
}
test('scoped service persists an auditable versioned report and retries idempotently',async()=>{
 const f=serviceFixture();assert.ok(f.service instanceof ScopedServiceBase);const first=await f.service.analyze(actor,request);assert.equal(first.report.coveragePercent,60);assert.deepEqual(await f.service.analyze(actor,request),first);assert.equal(f.store.events.length,1);const saved=await f.service.read(actor,request.id);assert.equal(saved.version,1);assert.equal(saved.rubricVersion,undefined);assert.equal(saved.rubric.version,1);assert.match(saved.transcriptDigest,/^[a-f0-9]{64}$/);assert.equal(saved.transcript,undefined);
 f.revoke();await assert.rejects(f.service.read(actor,request.id));await assert.rejects(f.service.analyze(actor,request));assert.equal(f.reads,2);
});
test('cross tenant, nonowner and missing capture approval fail before provider reads',async()=>{
 for(const wrong of [{...actor,tenantId:'tenant-b'},{...actor,id:'other-user'}]){const f=serviceFixture();await assert.rejects(f.service.analyze(wrong,request));assert.equal(f.reads,0);}
 const f=serviceFixture();f.changeScope(s=>s.captureApproved=false);await assert.rejects(f.service.analyze(actor,request));assert.equal(f.reads,0);
});
test('revoked permission, ownership, consent or changed script during provider reads never persists',async()=>{
 for(const mutate of [f=>f.revoke(),f=>f.changeScope(s=>s.ownerId='other'),f=>f.changeScope(s=>s.captureApproved=false),f=>f.changeScope(s=>s.recordingSid=sid('RE','0')),f=>f.changeRubric(r=>r.points[0].weight=2)]){const f=serviceFixture();f.afterSource(()=>mutate(f));await assert.rejects(f.service.analyze(actor,request));assert.equal(f.store.events.length,0);}
});
test('caller mutations across async boundaries do not alter report scope or identifiers',async()=>{
 const f=serviceFixture(),a={...actor},r={...request};f.afterSource(()=>{a.tenantId='attacker';r.id='attacker';});const result=await f.service.analyze(a,r);assert.equal(result.id,request.id);assert.equal((await f.service.read(actor,request.id)).tenantId,actor.tenantId);
});

async function providerFixture(){
 const definition=await salesOperatorDefinition(rubric),calls=[];
 const rows={operator:{sid:operatorSid,account_sid:accountSid,config:definition.config},recording:{sid:recordingSid,account_sid:accountSid,call_sid:callId,status:'completed',channels:2},header:{sid:transcriptSid,account_sid:accountSid,service_sid:serviceSid,status:'completed',duration:100,channel:{media_properties:{source_sid:recordingSid}}},sentences:transcript.sentences.map((s,i)=>({sid:s.id,media_channel:1,sentence_index:i,transcript:s.text,start_time:String(s.start),end_time:String(s.end),confidence:String(s.confidence)})),results:[{operator_sid:operatorSid,transcript_sid:transcriptSid,operator_type:'json',json_results:{rubricDigest:definition.rubricDigest,points:assessment().map(p=>({...p,evidence:p.evidence.map(e=>({quote:e.quote}))}))}}]};
 let failure=false;
 const source=createTwilioSalesQualitySource({accountSid,serviceSid,operatorSid,apiKeySid:sid('SK','1'),apiKeySecret:'2'.repeat(32),rubricDigest:definition.rubricDigest,operatorConfigDigest:definition.operatorConfigDigest,httpClient:{async request(options){
  calls.push(options);if(failure)throw Error('PRIVATE provider secret');
  let body;if(options.uri.includes('/Operators/Custom/'))body=rows.operator;else if(options.uri.includes('/Recordings/'))body=rows.recording;else if(options.uri.endsWith('/Sentences'))body={sentences:rows.sentences,meta:{next_page_url:null}};else if(options.uri.endsWith('/OperatorResults'))body={operator_results:rows.results,meta:{next_page_url:null}};else body=rows.header;
  return {statusCode:200,headers:{},body:JSON.stringify(body)};
 }}});
 return {source,rows,calls,definition,fail(){failure=true;}};
}
test('official SDK reads canonical dual-channel recording, transcript and pinned JSON operator',async()=>{
 const f=await providerFixture(),data=await f.source.read(scope,f.definition.rubricDigest);assert.equal(scoreSalesCall(rubric,data.transcript,data.points).coveragePercent,60);assert.equal(f.calls.length,5);assert.ok(f.calls.every(c=>c.method==='get'));assert.equal(f.calls[3].params.Redacted,'true');assert.equal(f.calls[3].params.PageSize,500);assert.equal(f.calls[4].params.Redacted,'true');assert.equal(data.points[0].evidence[0].sentenceId,transcript.sentences[0].id);
});
test('mismatched account, call, transcript, service, operator, rubric and config are rejected',async()=>{
 for(const mutate of [r=>r.recording.account_sid=sid('AC','0'),r=>r.recording.call_sid=sid('CA','0'),r=>r.recording.channels=1,r=>r.recording.status='processing',r=>r.header.channel.media_properties.source_sid=sid('RE','0'),r=>r.header.service_sid=sid('GA','0'),r=>r.header.status='in-progress',r=>r.results[0].transcript_sid=sid('GT','0'),r=>r.results[0].operator_sid=sid('LY','0'),r=>r.results.push(r.results[0]),r=>r.results[0].json_results.rubricDigest='0'.repeat(64),r=>r.operator.config.prompt+='edited']){const f=await providerFixture();mutate(f.rows);await assert.rejects(f.source.read(scope,f.definition.rubricDigest),/^Error: Sales analysis unavailable$/);}
});
test('unknown speaker, missing timestamps, ambiguous or invented quotes never earn points',async()=>{
 for(const mutate of [r=>r.sentences[0].media_channel=0,r=>r.sentences[0].start_time=null,r=>r.results[0].json_results.points[0].evidence[0].quote='invented',r=>r.sentences.push({...r.sentences[0],sid:sid('GX','a')}),r=>r.sentences[0].media_channel=2]){const f=await providerFixture();mutate(f.rows);await assert.rejects(f.source.read(scope,f.definition.rubricDigest));}
});
test('bounded provider lists fail instead of silently scoring truncated data',async()=>{
 const f=await providerFixture();f.rows.sentences=Array(4001).fill(f.rows.sentences[0]);await assert.rejects(f.source.read(scope,f.definition.rubricDigest));
 const g=await providerFixture();g.rows.results=Array(101).fill(g.rows.results[0]);await assert.rejects(g.source.read(scope,g.definition.rubricDigest));
});
test('provider errors are redacted, do not retry and unapproved input causes no requests',async()=>{
 const f=await providerFixture();await assert.rejects(f.source.read({...scope,captureApproved:false},f.definition.rubricDigest));await assert.rejects(f.source.read(scope,'0'.repeat(64)));assert.equal(f.calls.length,0);f.fail();await assert.rejects(f.source.read(scope,f.definition.rubricDigest),/^Error: Sales analysis unavailable$/);assert.equal(f.calls.length,1);
});

test('native PostgreSQL persists one report across concurrent workers and enforces replay authorization',{skip:!process.env.TWILIO_SMS_TEST_DATABASE_URL},async()=>{
 const connection=process.env.TWILIO_SMS_TEST_DATABASE_URL,url=new URL(connection);
 assert.ok(['localhost','127.0.0.1','[::1]'].includes(url.hostname)&&url.pathname==='/twilio_sms_test','Disposable local database required');
 const {default:pg}=await import('pg'),{readFile}=await import('node:fs/promises'),{PostgresAtomicStore}=await import('../cloudflare/workers/src/business-tasks/store.ts');
 const schema='sales_quality_fixture_'+crypto.randomUUID().replaceAll('-',''),admin=new pg.Pool({connectionString:connection});let first,second;
 try{
  await admin.query(`CREATE SCHEMA ${schema}`);first=new pg.Pool({connectionString:connection,options:`-c search_path=${schema}`});second=new pg.Pool({connectionString:connection,options:`-c search_path=${schema}`});
  await first.query((await readFile('packages/database/migrations/20261023_sales_call_quality.sql','utf8')).replaceAll('public.',''));
  const a=serviceFixture(new PostgresAtomicStore(first,'business_sales_quality')),b=serviceFixture(new PostgresAtomicStore(second,'business_sales_quality'));
  const results=await Promise.all([a.service.analyze(actor,request),b.service.analyze(actor,request)]);assert.deepEqual(results[0],results[1]);assert.equal(results[0].report.coveragePercent,60);
  assert.equal((await first.query('SELECT count(*)::int AS n FROM business_sales_quality_events')).rows[0].n,1);
  assert.equal((await b.service.read(actor,request.id)).report.points[0].evidence[0].quote,transcript.sentences[0].text);
  await assert.rejects(b.service.read({...actor,tenantId:'other-tenant'},request.id));
  await assert.rejects(b.service.analyze(actor,{...request,key:'different-command'}),/Version conflict/);
  b.revoke();await assert.rejects(b.service.analyze(actor,request));
  a.afterSource(()=>a.revoke());await assert.rejects(a.service.analyze(actor,{...request,id:'revoked-report',key:'revoked'}));
  assert.equal((await first.query('SELECT count(*)::int AS n FROM business_sales_quality_aggregates')).rows[0].n,1);
 }finally{await first?.end();await second?.end();await admin.query(`DROP SCHEMA IF EXISTS ${schema} CASCADE`);await admin.end();}
});
