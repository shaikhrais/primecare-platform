import {json,withDb,tokenFrom,sha256,type Env} from './auth';

const identifier=/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/;
const count=(value:unknown)=>{if(typeof value!=='number'||!Number.isSafeInteger(value)||value<0)throw Error('Invalid timesheet item count');return value;};
const timestamp=(value:unknown)=>{
  if(value instanceof Date){if(!Number.isFinite(value.getTime()))throw Error('Invalid timesheet item timestamp');return value.toISOString();}
  if(typeof value!=='string'||!/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{1,3})?Z$/.test(value)||!Number.isFinite(Date.parse(value)))throw Error('Invalid timesheet item timestamp');
  const result=new Date(value).toISOString();if(result.slice(0,19)!==value.slice(0,19))throw Error('Invalid timesheet item timestamp');return result;
};
const project=(row:Record<string,unknown>)=>{
  if(typeof row.id!=='string'||!identifier.test(row.id)||typeof row.minutes!=='number'||!Number.isInteger(row.minutes)||row.minutes< -2147483648||row.minutes>2147483647)throw Error('Invalid timesheet item');
  return {id:row.id,minutes:row.minutes,created_at:timestamp(row.created_at)};
};

/** Timesheet items inherit the existing owned-timesheet read boundary.
 * No visit identifier, patient data, reviewer identity or payroll approval is exposed. */
export async function providerTimesheetItems(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
  const summary=path==='/timesheet-items/summary';
  const detail=!summary?/^\/timesheet-items\/([^/]+)$/.exec(path):null;
  if(env.SERVICE_NAME!=='provider'||path!=='/timesheet-items'&&!summary&&!detail)return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(request.method!=='GET'){safe.set('allow','GET');return json({error:'Method not allowed'},405,safe);}
  const params=new URL(request.url).searchParams,allowed=detail?[]:['limit','offset'];
  const limit=params.get('limit')??'25',offset=params.get('offset')??'0';
  if(request.body!==null||[...params.keys()].some(key=>!allowed.includes(key)||params.getAll(key).length!==1)||!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000||detail&&!identifier.test(detail[1]))return json({error:'Invalid query or identifier'},400,safe);
  const token=request.headers.has('authorization')?tokenFrom(request):null;
  if(!token)return json({error:'No session'},401,safe);
  try{
    if(env.WORKSPACE_SOURCE_LIMIT&&!(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('provider-timesheet-items:'+(request.headers.get('cf-connecting-ip')??'unknown'))})).success){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
    return await withDb(env,async db=>{
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try{
        const actor=(await db.query("SELECT u.id,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token)])).rows[0];
        if(!actor)return json({error:'Invalid session'},401,safe);
        if(!actor.tenant_id||request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id))return json({error:'Forbidden'},403,safe);
        const profiles=(await db.query('SELECT id FROM provider_profiles WHERE user_id::text=$1 AND tenant_id::text=$2 LIMIT 2',[String(actor.id),String(actor.tenant_id)])).rows;
        if(!profiles.length)return json({error:'Provider profile not found'},404,safe);
        if(profiles.length!==1||typeof profiles[0].id!=='string'||!identifier.test(profiles[0].id))throw Error('Invalid owned provider profile');
        const values=[profiles[0].id,String(actor.tenant_id)];
        const scope=' FROM timesheet_items item JOIN timesheets sheet ON sheet.id=item.timesheet_id WHERE sheet.provider_id::text=$1 AND sheet.tenant_id::text=$2';
        if(summary){
          const total=count((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT sheet.status'+scope+' GROUP BY sheet.status) groups',values)).rows[0]?.count);
          const rows=(await db.query('SELECT sheet.status,COUNT(*)::int AS count,SUM(item.minutes)::text AS "totalMinutes"'+scope+' GROUP BY sheet.status ORDER BY sheet.status NULLS LAST LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          const groups=rows.map(row=>{
            if(row.status!==null&&typeof row.status!=='string'||typeof row.totalMinutes!=='string'||! /^-?\d+$/.test(row.totalMinutes))throw Error('Invalid timesheet item summary');
            return {status:row.status,count:count(row.count),totalMinutes:row.totalMinutes};
          });
          return json({groups,pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        const fields='item.id,item.minutes,item.created_at';
        if(detail){
          const rows=(await db.query('SELECT '+fields+scope+' AND item.id::text=$3',[...values,detail[1]])).rows;
          if(!rows.length)return json({error:'Timesheet item not found'},404,safe);
          if(rows.length!==1)throw Error('Ambiguous timesheet item');
          const item=project(rows[0]);if(item.id!==detail[1])throw Error('Timesheet item identity mismatch');
          return json({item},200,safe);
        }
        const total=count((await db.query('SELECT COUNT(*)::int AS count'+scope,values)).rows[0]?.count);
        const rows=(await db.query('SELECT '+fields+scope+' ORDER BY item.created_at DESC,item.id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
        return json({items:rows.map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
      }finally{await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Timesheet item data unavailable'},503,safe);}
}
