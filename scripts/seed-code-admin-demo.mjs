/** Approved design demo: additive, isolated, non-login identities; no provider calls. */
import {readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import pg from 'pg';
import {createTenantRecord} from '../packages/shared/src/tenant-creation.mjs';
import {owner} from './code-admin-owner.mjs';
export const definition=JSON.parse(await readFile(new URL('../packages/shared/src/code-admin-demo.json',import.meta.url),'utf8'));
export const demoId=key=>{const hex=createHash('sha256').update(definition.version+':'+key).digest('hex');return hex.slice(0,8)+'-'+hex.slice(8,12)+'-5'+hex.slice(13,16)+'-a'+hex.slice(17,20)+'-'+hex.slice(20,32);};
export async function seedCodeAdminDemo(db,{actorId}={}){
 const f=definition.fixture,receipt=demoId('receipt');
 await db.query('BEGIN');
 try{
  await db.query("SET LOCAL statement_timeout='30s'");
  await db.query('SELECT pg_advisory_xact_lock(hashtext($1))',[definition.version]);
  const actors=(await db.query("SELECT id,email FROM users WHERE roles='code_admin' AND LOWER(status)='active'" )).rows;
  const approved=actors.filter(a=>actorId?String(a.id)===actorId:createHash('sha256').update(String(a.email).trim().toLowerCase()).digest('hex')===owner.emailSha256);
  if(approved.length!==1)throw Error('Exactly one authorized existing Code Admin actor required');
  const actor=String(approved[0].id);
  const prior=(await db.query('SELECT current_state FROM platform_administration_audit WHERE id=$1',[receipt])).rows;
  if(prior.length){if(prior.length!==1||prior[0].current_state?.demoDataset?.version!==definition.version)throw Error('Demo receipt collision');const report=await verifyDemo(db);await db.query('COMMIT');return {...report,inserted:false};}
  for(const name of ['tenants','users','platform_master_records','platform_documents','platform_support_tickets','platform_support_messages','platform_launch','platform_administration_audit']){
   if(!(await db.query('SELECT to_regclass($1) AS name',[name])).rows[0]?.name)throw Error('Required existing schema missing: '+name);
  }
  const ids=Object.fromEntries(f.tenants.map(t=>[t.id,demoId('tenant:'+t.id)]));
  const audit=async(action,tenant,target,state,key)=>db.query('INSERT INTO platform_administration_audit(id,actor_id,tenant_id,target_id,action,previous_state,current_state) VALUES($1,$2,$3,$4,$5,$6,$7)',[demoId('audit:'+key),actor,tenant,target,action,'{}',JSON.stringify({...state,demo:true,seedVersion:definition.version})]);
  for(const t of f.tenants){
   const id=ids[t.id],slug=definition.namespace+t.slug;
   if((await db.query('SELECT id FROM tenants WHERE id::text=$1 OR slug=$2',[id,slug])).rows.length)throw Error('Existing tenant collision; no records changed');
   await createTenantRecord(db,{id,slug,name:'DEMO · '+t.name});
   if(t.status==='Inactive')await db.query("UPDATE tenants SET status='inactive' WHERE id::text=$1",[id]);
   if(t.id!=='maple')await audit('tenant_created',id,id,{name:'DEMO · '+t.name,slug},'tenant:'+t.id);
   for(let i=0;i<t.accounts;i++){
    const known=f.accounts.filter(a=>a.tenant===t.id)[i],userId=demoId('user:'+t.id+':'+i),email='demo.'+t.id+'.'+String(i+1).padStart(2,'0')+'@primecare.example';
    const role=known?.role??'caregiver';
    if((await db.query('SELECT id FROM users WHERE id::text=$1 OR LOWER(email)=$2',[userId,email])).rows.length)throw Error('Existing account collision');
    await db.query("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES($1,$2,$3,$4,'!DEMO-NO-LOGIN','active',NOW())",[userId,email,id,role]);
    await audit('account_created',id,userId,{role,status:'active',demoLoginDisabled:true},'user:'+t.id+':'+i);
   }
   const desired=t.setup===100?['location','service_category']:t.id==='harbour'?['location']:t.id==='meadow'?['service_category']:[];
   for(const type of desired){const key=t.id+':'+type,mid=demoId('master:'+key),code=type==='location'?'demo-office':'demo-home-support',label=type==='location'?'DEMO · '+t.city+' office':'DEMO · Home support';await db.query('INSERT INTO platform_master_records(id,tenant_id,type,code,label) VALUES($1,$2,$3,$4,$5)',[mid,id,type,code,label]);await audit('master_created',id,mid,{type,code,label,status:'active',version:1},'master:'+key);}
   // Draft only: seeding never grants clinical or launch authorization.
   await db.query("INSERT INTO platform_launch(tenant_id,state,training_evidence) VALUES($1,'draft','')",[id]);
  }
  const objects=['<< /Type /Catalog /Pages 2 0 R >>','<< /Type /Pages /Kids [3 0 R] /Count 1 >>','<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Resources << /Font << /F1 4 0 R >> >> /Contents 5 0 R >>','<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>'];
  const content='BT /F1 18 Tf 50 730 Td (PrimeCare DEMO document) Tj /F1 12 Tf 0 -30 Td (Sample only. No clinical or business approval.) Tj ET';objects.push('<< /Length '+Buffer.byteLength(content)+' >>\nstream\n'+content+'\nendstream');
  let pdfText='%PDF-1.4\n',offsets=[0];for(let i=0;i<objects.length;i++){offsets.push(Buffer.byteLength(pdfText));pdfText+=(i+1)+' 0 obj\n'+objects[i]+'\nendobj\n';}const xref=Buffer.byteLength(pdfText);pdfText+='xref\n0 6\n0000000000 65535 f \n'+offsets.slice(1).map(n=>String(n).padStart(10,'0')+' 00000 n \n').join('')+'trailer << /Size 6 /Root 1 0 R >>\nstartxref\n'+xref+'\n%%EOF\n';const pdf=Buffer.from(pdfText);
  for(const d of f.documents){const tenantId=ids[d.tenant],kind=d.type.toLowerCase(),expires=new Date(Date.now()+(d.status==='Renewal due'?14:180)*86400000).toISOString().slice(0,10);await db.query("INSERT INTO platform_documents(id,tenant_id,kind,revision,filename,media_type,content,content_hash,expires_on,status,uploaded_by) VALUES($1,$2,$3,1,$4,'application/pdf',$5,$6,$7,'pending',$8)",[demoId('document:'+d.id),tenantId,kind,'DEMO-'+kind+'.pdf',pdf,createHash('sha256').update(pdf).digest('hex'),expires,actor]);}
  for(const t of f.tickets){const tid=demoId('ticket:'+t.id),isUrgent=t.priority==='Urgent',creator=demoId('user:'+t.tenant+':0');await db.query("INSERT INTO platform_support_tickets(id,tenant_id,subject,priority,status,created_by,response_due,resolution_due) VALUES($1,$2,$3,$4,'open',$5,NOW()+$6::int*INTERVAL '1 hour',NOW()+$7::int*INTERVAL '1 hour')",[tid,ids[t.tenant],'DEMO · '+t.subject,isUrgent?'urgent':'normal',creator,isUrgent?4:24,isUrgent?24:72]);await db.query('INSERT INTO platform_support_messages(id,tenant_id,ticket_id,actor_id,message) VALUES($1,$2,$3,$4,$5)',[demoId('ticket-message:'+t.id),ids[t.tenant],tid,creator,'DEMO support request from the approved dashboard design. No real customer request or message delivery.']);}
  // Preserve every approved example in a separately labelled snapshot inside the
  // real tenant-created audit event. Never invent provider events or approvals.
  await db.query('INSERT INTO platform_administration_audit(id,actor_id,tenant_id,target_id,action,previous_state,current_state) VALUES($1,$2,$3,$3,\'tenant_created\',\'{}\',$4)',[receipt,actor,ids.maple,JSON.stringify({demo:true,name:'DEMO · Maple Home Care',slug:definition.namespace+'maple-home-care',demoDataset:{version:definition.version,tenantIds:ids,examples:f,nonLoginAccounts:true,noProviderActions:true}})]);
  const report=await verifyDemo(db);await db.query('COMMIT');return {...report,inserted:true};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
export async function verifyDemo(db){
 const ids=definition.fixture.tenants.map(t=>demoId('tenant:'+t.id));
 const tenants=(await db.query('SELECT id,name,slug FROM tenants WHERE id::text=ANY($1::text[])',[ids])).rows;
 if(tenants.length!==ids.length||tenants.some(t=>!t.slug.startsWith(definition.namespace)||!t.name.startsWith('DEMO · ')))throw Error('Demo tenant verification failed');
 const users=(await db.query('SELECT id,email,password_hash FROM users WHERE tenant_id::text=ANY($1::text[])',[ids])).rows;
 if(users.length!==55||users.some(u=>!u.email.endsWith('@primecare.example')||u.password_hash!=='!DEMO-NO-LOGIN'))throw Error('Demo user verification failed; existing edits preserved');
 const sessions=(await db.query('SELECT COUNT(*)::int AS count FROM auth_sessions WHERE user_id::text=ANY($1::text[])',[users.map(u=>String(u.id))])).rows[0].count;
 if(sessions!==0)throw Error('Demo identities must not own sessions');
 const documents=(await db.query('SELECT COUNT(*)::int AS count FROM platform_documents WHERE tenant_id::text=ANY($1::text[])',[ids])).rows[0].count;
 const tickets=(await db.query('SELECT COUNT(*)::int AS count FROM platform_support_tickets WHERE tenant_id::text=ANY($1::text[])',[ids])).rows[0].count;
 if(documents<3||tickets<2)throw Error('Demo domain records missing');
 return {version:definition.version,tenants:tenants.length,accounts:users.length,documents,tickets,sessions,providerActions:0,clinicalRecords:0,launchApprovals:0};
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 if(process.env.PRIMECARE_DEMO_SEED_AUTHORIZATION!=='APPLY_APPROVED_CODE_ADMIN_DEMO')throw Error('Explicit demo seed authorization required');
 const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL??process.env.PLATFORM_TEST_DATABASE_URL});await db.connect();
 try{console.log(JSON.stringify(await seedCodeAdminDemo(db)));}finally{await db.end();}
}
