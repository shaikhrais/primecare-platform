import {projectReferenceId} from './reference-read-projection';
import {accountId} from './account-read-projection';
import {summaryRows} from './summary-results';
import {pageRows,recordRows,scopedActor,boundRow,resultRows,requiredRow} from './database-results';
import {projectRecordTimestamp,validRecordTimestamp} from './record-date-validation';
import {sourceLimitAllowed} from './source-limit-result';
import {json,withDb,tokenFrom,sha256,type Env} from './auth';
import generatedRegistry from './self-records-registry.json';
type RecordDefinition={path:string;table:string;item:string;collection?:string;fields:string[];types:Record<string,string|string[]>;dateFields:string[];singleton?:boolean;summaryField?:string;tenantThroughUser?:boolean;ownerField?:string;orderField?:string};
const registry:RecordDefinition[]=generatedRegistry;
const exactCount=(value:unknown,message:string)=>{if(typeof value!=='number'||!Number.isSafeInteger(value)||value<0)throw Error(message);return value;};
/** Direct account ownership is derived exclusively from the active session.
 * SQL identifiers come from the generated governance projection, never input. */
export async function selfRecords(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null>{
  if(env.SERVICE_NAME!=='auth')return null;
  const record=registry.find(r=>path===r.path||!r.singleton&&path.startsWith(r.path+'/')&&!path.slice(r.path.length+1).includes('/'));
  if(!record)return null;
  const suffix=path===record.path?null:path.slice(record.path.length+1),summary=suffix==='summary'&&!!record.summaryField,detail=suffix!==null&&!summary,paged=!record.singleton&&!detail;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(request.method!=='GET'){safe.set('allow','GET');return json({error:'Method not allowed'},405,safe);}
  const params=new URL(request.url).searchParams,keys=paged?['limit','offset']:[],limit=params.get('limit')??'25',offset=params.get('offset')??'0';
  if(request.body!==null||[...params.keys()].some(k=>!keys.includes(k)||params.getAll(k).length!==1)||!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000||detail&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(suffix!))return json({error:'Invalid query, identifier or body'},400,safe);
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)return json({error:'No session'},401,safe);
  try{
    if(env.WORKSPACE_SOURCE_LIMIT&&!sourceLimitAllowed(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('self-records:'+(request.headers.get('cf-connecting-ip')??'unknown'))}))){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
    return await withDb(env,async db=>{
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try{
        const actor=scopedActor((await db.query("SELECT u.id,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token)])).rows);
        if(!actor)return json({error:'Invalid session'},401,safe);
        if(!actor.tenant_id||request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id))return json({error:'Forbidden'},403,safe);
        const values=[String(actor.id),String(actor.tenant_id)],prefix=record.tenantThroughUser?'r.':'';
        // Records without tenant_id derive scope from the owning user relation,
        // and bind that relationship again in every record query.
        const scope=record.tenantThroughUser?' FROM '+record.table+' r JOIN users owner ON owner.id::text=r.'+(record.ownerField??'user_id')+'::text WHERE r.'+(record.ownerField??'user_id')+'::text=$1 AND owner.tenant_id::text=$2':' FROM '+record.table+' WHERE '+(record.ownerField??'user_id')+'::text=$1 AND tenant_id::text=$2';
        const identifier=(field:string)=>/[A-Z]/.test(field)?'"'+field+'"':field;
        const fields=record.fields.map(field=>prefix+identifier(field)).join(',');
        const valid=(field:string,value:unknown)=>{
          const type=record.types[field],allowed=Array.isArray(type)?type:[type];
          if(value===null)return allowed.includes('null');
          if(record.dateFields.includes(field))return validRecordTimestamp(value);
          if(allowed.includes('string')&&field.endsWith('_id')){projectReferenceId(value);return true;}
          return allowed.includes('integer')?typeof value==='number'&&Number.isSafeInteger(value):allowed.includes('boolean')?typeof value==='boolean':allowed.includes('string')&&typeof value==='string';
        };
        const project=(row:Record<string,unknown>)=>{if(record.fields.includes('id'))accountId(row.id);return Object.fromEntries(record.fields.map(field=>{if(!valid(field,row[field]))throw Error('Invalid account record');return [field,record.dateFields.includes(field)?projectRecordTimestamp(row[field]):row[field]];}));};
        if(summary){
          const field=record.summaryField!,groupField=prefix+identifier(field);
          const total=exactCount(requiredRow((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT '+groupField+scope+' GROUP BY '+groupField+') groups',values)).rows).count,'Invalid account summary count');
          const rows=(await db.query('SELECT '+groupField+',COUNT(*)::int AS count'+scope+' GROUP BY '+groupField+' ORDER BY '+groupField+' NULLS LAST LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          const groups=summaryRows(pageRows(rows,Number(limit),Number(offset),total),Number(limit),[field]).map(row=>{if(!valid(field,row[field])||typeof row.count!=='number'||!Number.isSafeInteger(row.count)||row.count<0)throw Error('Invalid account summary');return {[field]:row[field],count:row.count};});
          return json({groups,pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(record.singleton){
          const rows=resultRows((await db.query('SELECT '+fields+scope+' LIMIT 2',values)).rows,1);
          if(!rows.length)return json({error:'Profile not found'},404,safe);
          if(rows.length!==1)return json({error:'Account data unavailable'},503,safe);
          return json({[record.item]:project(rows[0])},200,safe);
        }
        if(detail){const row=boundRow((await db.query('SELECT '+fields+scope+' AND '+prefix+'id::text=$3',[...values,suffix])).rows,suffix);return row?json({[record.item]:project(row)},200,safe):json({error:'Record not found'},404,safe);}
        const total=exactCount(requiredRow((await db.query('SELECT COUNT(*)::int AS count'+scope,values)).rows).count,'Invalid account record count');
        const rows=(await db.query('SELECT '+fields+scope+' ORDER BY '+prefix+(record.orderField??'created_at')+' DESC,'+prefix+'id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
        return json({[record.collection!]:recordRows(pageRows(rows,Number(limit),Number(offset),total),Number(limit)).map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
      }finally{await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Account data unavailable'},503,safe);}
}
