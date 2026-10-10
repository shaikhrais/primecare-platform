import {Client} from 'pg';
import bcrypt from 'bcryptjs';
import {randomUUID,randomBytes,createHash} from 'node:crypto';
import {readFile,writeFile} from 'node:fs/promises';
import path from 'node:path';
const target=process.env.NATIVE_PLATFORM;
if(!['windows','android','ios','macos','linux'].includes(target))throw new Error('Invalid native target');
const file=path.join(process.env.RUNNER_TEMP,'primecare-native',target,'qa-fixture.json');
const db=new Client({connectionString:process.env.PRODUCTION_DATABASE_URL,connectionTimeoutMillis:10000});
await db.connect();
try {
 if(process.argv[2]==='create'){
  const tenant=randomUUID(),user=randomUUID(),email=`native-${target}-${randomUUID()}@example.invalid`,password=randomBytes(24).toString('base64url');
  const fixture={tenant,user,email,password};
  // Save manifest before any database mutation so finally cleanup can always recover its IDs.
  await writeFile(file,JSON.stringify(fixture));
  await db.query('BEGIN');
  try{
   await db.query("INSERT INTO tenants(id,name,slug,status,updated_at,allowed_vpn_ranges,cors_allowed_origins,cors_allowed_methods,cors_allowed_headers) VALUES($1,'Temporary native auth QA tenant',$2,'active',NOW(),'','[]'::jsonb,'[]'::jsonb,'[]'::jsonb)",[tenant,'native-auth-'+tenant]);
   await db.query("INSERT INTO users(id,email,tenant_id,roles,password_hash,status,updated_at) VALUES($1,$2,$3,'client',$4,'active',NOW())",[user,email,tenant,await bcrypt.hash(password,12)]);
   await db.query('COMMIT');
  }catch(error){await db.query('ROLLBACK');throw error;}
  console.log('::add-mask::'+email);console.log('::add-mask::'+password);
  await writeFile(path.join(path.dirname(file),'qa-defines.json'),JSON.stringify({AUTH_API_URL:'https://primecare-api-gateway.itpro-mohammed.workers.dev/v1/auth',QA_EMAIL:email,QA_PASSWORD:password}));
  console.log('Temporary native QA account created.');
 }else if(process.argv[2]==='cleanup'){
  let f;try{f=JSON.parse(await readFile(file,'utf8'));}catch(e){if(e.code==='ENOENT'){console.log('No native fixture created.');}else throw e;}
  if(f){
   if(!f.email.startsWith(`native-${target}-`)||!f.email.endsWith('@example.invalid'))throw new Error('Unexpected fixture identity');
   await db.query('BEGIN');
   try{
    const owned=await db.query('SELECT id FROM users WHERE id=$1 AND tenant_id=$2 AND email=$3',[f.user,f.tenant,f.email]);
    if(owned.rows.length){await db.query('DELETE FROM auth_sessions WHERE user_id=$1',[f.user]);await db.query('DELETE FROM users WHERE id=$1 AND tenant_id=$2',[f.user,f.tenant]);}
    await db.query('DELETE FROM tenants WHERE id=$1 AND slug=$2',[f.tenant,'native-auth-'+f.tenant]);
    await db.query('DELETE FROM auth_rate_limits WHERE subject_hash=$1',[createHash('sha256').update('login:'+f.email).digest('hex')]);
    await db.query('COMMIT');console.log('Temporary native QA account and tenant removed.');
   }catch(error){await db.query('ROLLBACK');throw error;}
  }
 }else throw new Error('Unknown fixture operation');
}finally{await db.end();}
