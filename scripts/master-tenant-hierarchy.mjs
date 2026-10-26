import pg from 'pg';
import {readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {pathToFileURL} from 'node:url';
import {resolveCodeAdminControlTenant} from './bootstrap-code-admin-control-tenant.mjs';
import {owner,verifyCodeAdminOwnerRegistration} from './code-admin-owner.mjs';
const pin=JSON.parse(await readFile(new URL('../tools/governance-production/production-pin.json',import.meta.url),'utf8'));
const definitionUrl=new URL('../tools/governance-production/master-tenant-hierarchy.json',import.meta.url);
export const definition=JSON.parse(await readFile(definitionUrl,'utf8'));
export const triggerBody=`BEGIN
 INSERT INTO public.tenant_parent_links(tenant_id,parent_tenant_id)
 SELECT NEW.id,m.tenant_id FROM public.platform_master_tenant m WHERE m.singleton AND NEW.id<>m.tenant_id;
 RETURN NEW;
END;`;
/** Native identity types and foreign keys; tenant hierarchy never widens data scope. */
export async function ensureMasterHierarchy(db,{rootId,ownerId,apply=false}){
 await db.query('BEGIN');
 try{
  await db.query("SELECT pg_advisory_xact_lock(hashtext('primecare-master-tenant-hierarchy-v1'))");
  if(apply)await db.query('LOCK TABLE public.tenants,public.users IN SHARE ROW EXCLUSIVE MODE');
  const type=async table=>{const r=await db.query("SELECT format_type(a.atttypid,a.atttypmod) AS type FROM pg_attribute a WHERE a.attrelid=to_regclass($1) AND a.attname='id' AND a.attnum>0 AND NOT a.attisdropped",['public.'+table]);if(r.rows.length!==1||!['text','uuid'].includes(r.rows[0].type))throw Error('unsupported_native_identity');return r.rows[0].type;};
  const tenantType=await type('tenants'),userType=await type('users');
  const actor=await db.query("SELECT id FROM public.users WHERE id::text=$1 AND tenant_id::text=$2 AND roles='code_admin' AND LOWER(status)='active'",[ownerId,rootId]);
  if(actor.rows.length!==1)throw Error('master_owner_binding_required');
  if((await db.query("SELECT id FROM public.tenants WHERE id::text=$1 AND LOWER(status)='active'",[rootId])).rows.length!==1)throw Error('active_master_required');
  const expected={platform_master_tenant:[['singleton','boolean'],['tenant_id',tenantType],['owner_user_id',userType]],tenant_parent_links:[['tenant_id',tenantType],['parent_tenant_id',tenantType]]};
  const ddl={platform_master_tenant:`CREATE TABLE public.platform_master_tenant(singleton boolean PRIMARY KEY DEFAULT true CHECK(singleton),tenant_id ${tenantType} NOT NULL UNIQUE REFERENCES public.tenants(id) ON DELETE RESTRICT,owner_user_id ${userType} NOT NULL REFERENCES public.users(id) ON DELETE RESTRICT)`,tenant_parent_links:`CREATE TABLE public.tenant_parent_links(tenant_id ${tenantType} PRIMARY KEY REFERENCES public.tenants(id) ON DELETE CASCADE,parent_tenant_id ${tenantType} NOT NULL REFERENCES public.platform_master_tenant(tenant_id) ON DELETE RESTRICT,CHECK(tenant_id<>parent_tenant_id))`};
  for(const [table,fields]of Object.entries(expected)){
   const columns=(await db.query("SELECT a.attname AS name,format_type(a.atttypid,a.atttypmod) AS type,a.attnotnull AS required FROM pg_attribute a WHERE a.attrelid=to_regclass($1) AND a.attnum>0 AND NOT a.attisdropped ORDER BY a.attnum",['public.'+table])).rows;
   if(!columns.length){if(!apply)throw Error('master_schema_missing');await db.query(ddl[table]);}
   else if(JSON.stringify(columns.map(c=>[c.name,c.type]))!==JSON.stringify(fields)||columns.some(c=>!c.required))throw Error('preserve_changed_master_schema');
  }
  // Independently validate keys and FK targets, including on repeated deployments.
  const constraints=(await db.query("SELECT conrelid::regclass::text AS relation,contype,confrelid::regclass::text AS target,pg_get_constraintdef(oid) AS definition FROM pg_constraint WHERE conrelid IN ('public.platform_master_tenant'::regclass,'public.tenant_parent_links'::regclass)")).rows;
  const requireConstraint=(table,match)=>{if(!constraints.some(c=>c.relation.replace('public.','')===table&&match(c)))throw Error('master_constraint_mismatch');};
  requireConstraint('platform_master_tenant',c=>c.contype==='p'&&c.definition==='PRIMARY KEY (singleton)');
  requireConstraint('platform_master_tenant',c=>c.contype==='u'&&c.definition==='UNIQUE (tenant_id)');
  requireConstraint('platform_master_tenant',c=>c.contype==='c'&&c.definition==='CHECK (singleton)');
  for(const [table,column,target]of [['platform_master_tenant','tenant_id','tenants'],['platform_master_tenant','owner_user_id','users'],['tenant_parent_links','tenant_id','tenants'],['tenant_parent_links','parent_tenant_id','platform_master_tenant']])requireConstraint(table,c=>c.contype==='f'&&c.target.replace('public.','')===target&&c.definition.startsWith('FOREIGN KEY ('+column+')'));
  requireConstraint('tenant_parent_links',c=>c.contype==='p'&&c.definition==='PRIMARY KEY (tenant_id)');
  requireConstraint('tenant_parent_links',c=>c.contype==='c'&&c.definition==='CHECK ((tenant_id <> parent_tenant_id))');
  const functionRow=(await db.query("SELECT p.oid,p.prosrc,p.prosecdef FROM pg_proc p JOIN pg_namespace n ON n.oid=p.pronamespace WHERE n.nspname='public' AND p.proname='primecare_link_master_tenant' AND p.pronargs=0")).rows;
  if(functionRow.length>1||functionRow.length===1&&(functionRow[0].prosrc!==triggerBody||functionRow[0].prosecdef))throw Error('preserve_changed_master_trigger');
  if(!functionRow.length){if(!apply)throw Error('master_trigger_missing');await db.query("CREATE FUNCTION public.primecare_link_master_tenant() RETURNS trigger LANGUAGE plpgsql SET search_path=pg_catalog AS $body$"+triggerBody+'$body$');}
  const trigger=(await db.query("SELECT tgfoid='public.primecare_link_master_tenant()'::regprocedure AS correct_function,tgtype,tgenabled FROM pg_trigger WHERE tgrelid='public.tenants'::regclass AND tgname='primecare_master_parent_insert'")).rows;
  if(trigger.length>1||trigger.length===1&&(!trigger[0].correct_function||trigger[0].tgtype!==5||trigger[0].tgenabled!=='O'))throw Error('preserve_changed_master_trigger');
  if(!trigger.length){if(!apply)throw Error('master_trigger_missing');await db.query('CREATE TRIGGER primecare_master_parent_insert AFTER INSERT ON public.tenants FOR EACH ROW EXECUTE FUNCTION public.primecare_link_master_tenant()');}
  const before=(await db.query('SELECT tenant_id::text AS tenant,owner_user_id::text AS owner FROM public.platform_master_tenant')).rows;
  if(before.length>1||before.length===1&&(before[0].tenant!==rootId||before[0].owner!==ownerId))throw Error('preserve_existing_master');
  if(!before.length){if(!apply)throw Error('master_binding_missing');await db.query('INSERT INTO public.platform_master_tenant(singleton,tenant_id,owner_user_id) VALUES(true,$1,$2)',[rootId,ownerId]);}
  if(apply)await db.query('INSERT INTO public.tenant_parent_links(tenant_id,parent_tenant_id) SELECT t.id,m.tenant_id FROM public.tenants t CROSS JOIN public.platform_master_tenant m WHERE t.id<>m.tenant_id ON CONFLICT(tenant_id) DO NOTHING');
  const counts=(await db.query('SELECT COUNT(*)::int AS tenants,COUNT(l.tenant_id)::int AS linked FROM public.tenants t CROSS JOIN public.platform_master_tenant m LEFT JOIN public.tenant_parent_links l ON l.tenant_id=t.id AND l.parent_tenant_id=m.tenant_id WHERE t.id<>m.tenant_id')).rows[0];
  if(counts.tenants!==counts.linked)throw Error('tenant_parent_links_missing');
  await db.query('COMMIT');return {masterTenantBound:true,codeAdminLinked:true,childTenants:counts.linked,futureTenantsAutomaticallyLinked:true,nativeForeignKeys:true,tenantDataScopeChanged:false,accountChanges:0};
 }catch(error){await db.query('ROLLBACK');throw error;}
}
async function main(){
 if(!['--apply','--verify'].includes(process.argv[2]))throw Error('explicit_mode_required');
 const scope={optInVariable:'MASTER_TENANT_HIERARCHY',definitionSha256:createHash('sha256').update(await readFile(definitionUrl)).digest('hex'),businessTables:['public.platform_master_tenant','public.tenant_parent_links'],triggerTable:'public.tenants',accountChanges:false,tenantDataScopeChanged:false};
 if(JSON.stringify(pin.masterTenantHierarchyWriter)!==JSON.stringify(scope)||process.env.MASTER_TENANT_HIERARCHY!=='1')throw Error('exact_master_scope_required');
 const db=new pg.Client({connectionString:process.env.PRODUCTION_DATABASE_URL,ssl:{rejectUnauthorized:true}});await db.connect();
 try{
  await verifyCodeAdminOwnerRegistration(db);
  const registered=(await db.query('SELECT definition FROM "'+pin.schema+'".govt_platform_hierarchy_policy WHERE id=$1',[definition.id])).rows;
  if(registered.length!==1||JSON.stringify(JSON.parse(registered[0].definition))!==JSON.stringify(definition))throw Error('registered_master_requirement_required');
  const rootId=await resolveCodeAdminControlTenant(db);
  const users=(await db.query("SELECT id::text AS id,email,tenant_id::text AS tenant_id FROM public.users WHERE roles='code_admin' AND LOWER(status)='active' LIMIT 10")).rows;
  const found=users.filter(u=>createHash('sha256').update(u.email.trim().toLowerCase()).digest('hex')===owner.emailSha256);
  if(found.length!==1||found[0].tenant_id!==rootId)throw Error('master_owner_binding_required');
  const result=await ensureMasterHierarchy(db,{rootId,ownerId:found[0].id,apply:process.argv[2]==='--apply'});
  console.log('MASTER_TENANT_HIERARCHY '+JSON.stringify({...result,verified:process.argv[2]==='--verify',source:process.env.GITHUB_SHA}));
 }finally{await db.end();}
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(()=>{console.error('MASTER_TENANT_HIERARCHY_FAILED');process.exitCode=1;});
