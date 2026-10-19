import {json,withDb,tokenFrom,sha256,parseBody,bodyFailure,type Env} from './auth';
import {privilegedActor} from './auth-projection';
import {optionalRow,requiredRow} from './database-results';
import defaults from './screen-text-defaults.json';

export type Locales = Record<string, Record<string,string>>;
export const screenTextDefaults = defaults as Record<string,Locales>;
const parameters=(s:string)=>[...s.matchAll(/\{([A-Za-z][A-Za-z0-9_]*)\}/g)].map(m=>m[1]).sort();
class Failure extends Error {constructor(readonly status:number,message:string){super(message);}}
const fail=(status:number,message:string):never=>{throw new Failure(status,message);};
const record=(v:unknown):v is Record<string,unknown>=>!!v&&typeof v==='object'&&!Array.isArray(v);

/** Only registered text keys can change. No markup, routes, policies or code are executed. */
export function validateScreenText(screen:string,value:unknown):{version:number;locales:Locales} {
 const baseline=Object.hasOwn(screenTextDefaults,screen)?screenTextDefaults[screen]:null;if(!baseline)fail(404,'Screen text not registered');
 if(!record(value))return fail(400,'Invalid catalog');
 if(Object.keys(value).sort().join(',')!=='locales,version'||!Number.isSafeInteger(value.version)||(value.version as number)<0||!record(value.locales))fail(400,'Invalid catalog');
 const locales=value.locales as Record<string,unknown>;
 if(Object.keys(locales).sort().join(',')!=='en,es,fr')fail(400,'en/es/fr required');
 const keys=Object.keys(baseline.en).sort();
 for(const language of ['en','es','fr']) {
  const entries=locales[language];if(!record(entries)||JSON.stringify(Object.keys(entries).sort())!==JSON.stringify(keys))fail(400,'Resource keys differ');
  for(const key of keys){const text=entries[key];if(typeof text!=='string'||!text.trim()||text.length>2000||/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/.test(text))fail(400,'Invalid resource text');
   if(JSON.stringify(parameters(text as string))!==JSON.stringify(parameters(baseline.en[key])))fail(400,'Interpolation parameters differ');}
 }
 if(new TextEncoder().encode(JSON.stringify(value)).length>48000)fail(413,'Catalog too large');
 return value as {version:number;locales:Locales};
}

export async function screenText(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
 if(env.SERVICE_NAME!=='governance'||!(path==='/screen-text'||path.startsWith('/screen-text/')))return null;
 const safe=new Headers(headers);safe.set('cache-control','no-store');safe.set('x-content-type-options','nosniff');
 try {
  const match=/^\/screen-text(?:\/([a-z][a-z0-9_]{0,79})(\/history)?)?$/.exec(path);if(!match)fail(404,'Route not found');
  const screen=match![1],history=!!match![2];if(screen&&!Object.hasOwn(screenTextDefaults,screen))fail(404,'Screen text not registered');
  if(new URL(request.url).search||request.headers.has('x-tenant-id'))fail(400,'Overrides and query parameters are not accepted');
  const write=request.method==='PUT';if(request.method!=='GET'&&!write||write&&(!screen||history))fail(405,'Method not allowed');
  if(request.method==='GET'&&request.body)fail(400,'Unexpected body');
  let input:ReturnType<typeof validateScreenText>|undefined;
  if(write){try{input=validateScreenText(screen,await parseBody(request));}catch(error){if(error instanceof Failure)throw error;return bodyFailure(error,'Invalid catalog',safe);}}
  return await withDb(env,async db=>{
   const authorize=async(lock=false)=>{
    const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)fail(401,'No session');
    const actor=privilegedActor((await db.query("SELECT u.id,u.roles,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active'"+(lock?' FOR SHARE OF u,s':' LIMIT 1'),[await sha256(token!)])).rows);
    if(!actor)fail(401,'Invalid session');if(actor!.roles!=='platform_admin'||!actor!.tenant_id)fail(403,'Platform administrator required');return actor!;
   };
   if(history){await authorize();const rows=(await db.query('SELECT version,actor_id,previous_locales,locales,created_at FROM screen_text_history WHERE screen_id=$1 ORDER BY version DESC LIMIT 50',[screen])).rows;return json({screen,history:rows},200,safe);}
   if(!write){
    if(!screen){const rows=(await db.query('SELECT screen_id,version FROM screen_text_catalogs')).rows;return json({screens:Object.keys(screenTextDefaults).sort().map(id=>({id,version:rows.find(r=>r.screen_id===id)?.version??0}))},200,safe);}
    const row=optionalRow((await db.query('SELECT version,locales FROM screen_text_catalogs WHERE screen_id=$1',[screen])).rows);
    if(row)validateScreenText(screen,{version:row.version,locales:row.locales});
    return json({screen,version:row?.version??0,locales:row?.locales??screenTextDefaults[screen]},200,safe);
   }
   let actor=await authorize();const rate=requiredRow((await db.query("INSERT INTO screen_text_write_rate(actor_id,attempts,window_start) VALUES($1,1,NOW()) ON CONFLICT(actor_id) DO UPDATE SET attempts=CASE WHEN screen_text_write_rate.window_start<NOW()-INTERVAL '1 minute' THEN 1 ELSE screen_text_write_rate.attempts+1 END,window_start=CASE WHEN screen_text_write_rate.window_start<NOW()-INTERVAL '1 minute' THEN NOW() ELSE screen_text_write_rate.window_start END RETURNING attempts",[actor.id])).rows).attempts;
   if(typeof rate!=='number'||!Number.isSafeInteger(rate))throw Error('Invalid rate state');if(rate>30){safe.set('retry-after','60');fail(429,'Too many edits');}
   await db.query('BEGIN');let committed=false;
   try {
    await db.query('SELECT pg_advisory_xact_lock(hashtextextended($1,0))',['screen_text:'+screen]);actor=await authorize(true);
    const prior=optionalRow((await db.query('SELECT version,locales FROM screen_text_catalogs WHERE screen_id=$1 FOR UPDATE',[screen])).rows);
    const version=prior?.version??0;if(version!==input!.version)fail(409,'Text changed; reload before saving');
    const next=requiredRow((await db.query('INSERT INTO screen_text_catalogs(screen_id,version,locales) VALUES($1,$2,$3) ON CONFLICT(screen_id) DO UPDATE SET version=EXCLUDED.version,locales=EXCLUDED.locales,updated_at=NOW() RETURNING version,locales',[screen,(version as number)+1,JSON.stringify(input!.locales)])).rows);
    await db.query('INSERT INTO screen_text_history(screen_id,version,actor_id,previous_locales,locales) VALUES($1,$2,$3,$4,$5)',[screen,next.version,actor.id,JSON.stringify(prior?.locales??screenTextDefaults[screen]),JSON.stringify(next.locales)]);
    await db.query('COMMIT');committed=true;return json({screen,version:next.version,locales:next.locales},200,safe);
   }finally{if(!committed)await db.query('ROLLBACK');}
  });
 }catch(error){if(error instanceof Failure)return json({error:error.message},error.status,safe);throw error;}
}
