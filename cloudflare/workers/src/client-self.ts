import {json,withDb,tokenFrom,sha256,type Env} from './auth';
import recordRegistry from './client-records-registry.json';

/** Ownership comes from the registered client_profiles.user_id relationship,
 * never from caller-supplied profile identifiers or presentation grants. */
export async function clientSelf(request:Request,env:Env,path:string,headers:HeadersInit):Promise<Response|null> {
  const recordSummary=recordRegistry.find(r=>r.summaryBatch>0&&path===r.path+'/summary');
  const record=recordSummary??recordRegistry.find(r=>path===r.path||path.startsWith(r.path+'/')&&path!==r.path+'/summary'&&!path.slice(r.path.length+1).includes('/'));
  const recordId=record&&!recordSummary&&path!==record.path?path.slice(record.path.length+1):null;
  const invoiceSummary=path==='/invoices/summary';
  const invoiceMatch=!invoiceSummary?/^\/invoices\/([^/]+)$/.exec(path):null;
  const visitSummary=path==='/visits/summary';
  const visitMatch=!visitSummary?/^\/visits\/([^/]+)$/.exec(path):null;
  const statusSummary=path==='/bookings/summary';
  const bookingMatch=!statusSummary?/^\/bookings\/([^/]+)$/.exec(path):null;
  const requestSummary=path==='/booking-requests/summary';
  const paymentMatch=/^\/invoices\/([^/]+)\/payments(?:\/([^/]+))?$/.exec(path);
  const paymentSummary=paymentMatch?.[2]==='summary';
  const requestMatch=!requestSummary?/^\/booking-requests\/([^/]+)$/.exec(path):null;
  if(env.SERVICE_NAME!=='client'||!record&&!paymentMatch&&!requestSummary&&!requestMatch&&!bookingMatch&&!visitMatch&&!invoiceMatch&&!invoiceSummary&&!statusSummary&&!visitSummary&&!['/home/profile','/invoices','/bookings','/visits','/booking-requests'].includes(path))return null;
  const safe=new Headers(headers);safe.set('cache-control','no-store');
  if(request.method!=='GET'){safe.set('allow','GET');return json({error:'Method not allowed'},405,safe);}
  const params=new URL(request.url).searchParams,keys=paymentMatch?(paymentMatch[2]&&!paymentSummary?[]:['limit','offset']):record?(recordId===null?['limit','offset']:[]):(requestSummary||visitSummary||statusSummary||invoiceSummary||['/invoices','/bookings','/visits','/booking-requests'].includes(path))?['limit','offset']:[];
  const limit=params.get('limit')??'25',offset=params.get('offset')??'0';
  if(request.body!==null||[...params.keys()].some(k=>!keys.includes(k)||params.getAll(k).length!==1)||!/^[1-9]\d{0,2}$/.test(limit)||Number(limit)>100||!/^\d{1,6}$/.test(offset)||Number(offset)>100000)return json({error:'Invalid query or body'},400,safe);
  if(bookingMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(bookingMatch[1]))return json({error:'Invalid booking identifier'},400,safe);
  if(visitMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(visitMatch[1]))return json({error:'Invalid visit identifier'},400,safe);
  if(invoiceMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(invoiceMatch[1]))return json({error:'Invalid invoice identifier'},400,safe);
  if(requestMatch&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(requestMatch[1]))return json({error:'Invalid booking request identifier'},400,safe);
  if(recordId!==null&&!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(recordId))return json({error:'Invalid record identifier'},400,safe);
  if(paymentMatch&&[paymentMatch[1],paymentMatch[2]].filter(Boolean).some(id=>!/^[A-Za-z0-9][A-Za-z0-9_-]{0,199}$/.test(id!)))return json({error:'Invalid payment identifier'},400,safe);
  const token=request.headers.has('authorization')?tokenFrom(request):null;if(!token)return json({error:'No session'},401,safe);
  try{
    if(env.WORKSPACE_SOURCE_LIMIT&&!(await env.WORKSPACE_SOURCE_LIMIT.limit({key:await sha256('client-self:'+(request.headers.get('cf-connecting-ip')??'unknown'))})).success){safe.set('retry-after','60');return json({error:'Too many requests'},429,safe);}
    return await withDb(env,async db=>{
      await db.query('BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY');
      try{
        const actor=(await db.query("SELECT u.id,u.tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' LIMIT 1",[await sha256(token)])).rows[0];
        if(!actor)return json({error:'Invalid session'},401,safe);
        if(!actor.tenant_id||(request.headers.has('x-tenant-id')&&request.headers.get('x-tenant-id')!==String(actor.tenant_id)))return json({error:'Forbidden'},403,safe);
        const profiles=(await db.query('SELECT id,full_name,city,province,postal_code,updated_at FROM client_profiles WHERE user_id::text=$1 AND tenant_id::text=$2 LIMIT 2',[String(actor.id),String(actor.tenant_id)])).rows;
        if(!profiles.length)return json({error:'Client profile not found'},404,safe);
        if(profiles.length!==1)return json({error:'Client data unavailable'},503,safe);
        const p=profiles[0];
        if(path==='/home/profile')return json({profile:{id:String(p.id),full_name:p.full_name,city:p.city,province:p.province,postal_code:p.postal_code,updated_at:p.updated_at}},200,safe);
        const values=[String(p.id),String(actor.tenant_id)];
        if(paymentMatch){
          const paymentValues=[...values,paymentMatch[1]];
          const invoice=(await db.query('SELECT id FROM invoices WHERE client_id::text=$1 AND tenant_id::text=$2 AND id::text=$3',paymentValues)).rows[0];
          if(!invoice)return json({error:'Invoice not found'},404,safe);
          // Payment has no tenant column: every data query rebinds the invoice
          // relationship to the same owned client and tenant within this snapshot.
          const scope=' FROM payments pay JOIN invoices i ON i.id=pay.invoice_id WHERE i.client_id::text=$1 AND i.tenant_id::text=$2 AND i.id::text=$3';
          if(paymentSummary){
            const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT pay.status'+scope+' GROUP BY pay.status) groups',paymentValues)).rows[0].count);
            const rows=(await db.query('SELECT pay.status,COUNT(*)::int AS count'+scope+' GROUP BY pay.status ORDER BY pay.status NULLS LAST LIMIT $4 OFFSET $5',[...paymentValues,Number(limit),Number(offset)])).rows;
            const groups=rows.map(row=>{if((row.status!==null&&typeof row.status!=='string')||!Number.isSafeInteger(row.count)||row.count<0)throw Error('Invalid payment summary');return {status:row.status,count:row.count};});
            if(!Number.isSafeInteger(total)||total<0)throw Error('Invalid payment count');
            return json({groups,pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
          }
          const fields='pay.id,pay.amount::text AS amount,pay.status,pay.created_at,pay.updated_at';
          const project=(row:Record<string,unknown>)=>{
            if(typeof row.id!=='string'||(row.amount!==null&&(typeof row.amount!=='string'||! /^-?\d+(?:\.\d+)?$/.test(row.amount)))||(row.status!==null&&typeof row.status!=='string')||![row.created_at,row.updated_at].every(v=>(typeof v==='string'||v instanceof Date)&&Number.isFinite(new Date(v as string).getTime())))throw Error('Invalid payment data');
            return {id:row.id,amount:row.amount,status:row.status,created_at:row.created_at,updated_at:row.updated_at};
          };
          if(paymentMatch[2]){
            const row=(await db.query('SELECT '+fields+scope+' AND pay.id::text=$4',[...paymentValues,paymentMatch[2]])).rows[0];
            return row?json({payment:project(row)},200,safe):json({error:'Payment not found'},404,safe);
          }
          const total=Number((await db.query('SELECT COUNT(*)::int AS count'+scope,paymentValues)).rows[0].count);
          if(!Number.isSafeInteger(total)||total<0)throw Error('Invalid payment count');
          const rows=(await db.query('SELECT '+fields+scope+' ORDER BY pay.created_at DESC,pay.id DESC LIMIT $4 OFFSET $5',[...paymentValues,Number(limit),Number(offset)])).rows;
          return json({payments:rows.map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(requestSummary){
          const filter='client_id::text=$1 AND tenant_id::text=$2';
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT status FROM booking_requests WHERE '+filter+' GROUP BY status) groups',values)).rows[0].count);
          const rows=(await db.query('SELECT status,COUNT(*)::int AS count FROM booking_requests WHERE '+filter+' GROUP BY status ORDER BY status NULLS LAST LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          const groups=rows.map(row=>{if((row.status!==null&&typeof row.status!=='string')||!Number.isSafeInteger(row.count)||row.count<0)throw Error('Invalid booking request summary');return {status:row.status,count:row.count};});
          if(!Number.isSafeInteger(total)||total<0)throw Error('Invalid booking request count');
          return json({groups,pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(record){
          // Table and column identifiers come only from the generated, governed
          // projection catalog. Request input is confined to bound values.
          const column=(name:string)=>/[A-Z]/.test(name)?'"'+name+'"':name;
          const fields=record.fields.map(column).join(','),filter=(record.ownerField??'client_id')+'::text=$1 AND tenant_id::text=$2';
          const project=(row:Record<string,unknown>)=>Object.fromEntries(record.fields.map(field=>{
            const types=(record.types as Record<string,string|string[]>)[field],allowed=Array.isArray(types)?types:[types],value=row[field];
            const valid=value===null?allowed.includes('null'):record.dateFields.includes(field)?(typeof value==='string'||value instanceof Date)&&Number.isFinite(new Date(value as string).getTime()):allowed.includes('integer')?typeof value==='number'&&Number.isSafeInteger(value):allowed.includes('number')?typeof value==='number'&&Number.isFinite(value):allowed.includes('string')&&typeof value==='string';
            if(!valid)throw Error('Invalid record data');
            return [field,field==='id'?String(value):value];
          }));
          const count=(rows:Record<string,unknown>[])=>{const value=rows[0]?.count;if(typeof value!=='number'||!Number.isSafeInteger(value)||value<0)throw Error('Invalid record count');return value;};
          if(recordSummary){
            const field=record.summaryField,sqlField=column(field);
            const total=count((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT '+sqlField+' FROM '+record.table+' WHERE '+filter+' GROUP BY '+sqlField+') groups',values)).rows);
            const rows=(await db.query('SELECT '+sqlField+',COUNT(*)::int AS count FROM '+record.table+' WHERE '+filter+' GROUP BY '+sqlField+' ORDER BY '+sqlField+' NULLS LAST LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
            const groups=rows.map(row=>{
              if(row[field]!==null&&typeof row[field]!=='string'||!Number.isSafeInteger(row.count)||row.count<0)throw Error('Invalid summary data');
              return {[field]:row[field],count:row.count};
            });
            if(!Number.isSafeInteger(total)||total<0)throw Error('Invalid summary count');
            return json({groups,pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
          }
          if(recordId!==null){
            const row=(await db.query('SELECT '+fields+' FROM '+record.table+' WHERE '+filter+' AND id::text=$3',[...values,recordId])).rows[0];
            return row?json({[record.item]:project(row)},200,safe):json({error:'Record not found'},404,safe);
          }
          const total=count((await db.query('SELECT COUNT(*)::int AS count FROM '+record.table+' WHERE '+filter,values)).rows);
          const rows=(await db.query('SELECT '+fields+' FROM '+record.table+' WHERE '+filter+' ORDER BY '+column(record.orderField)+' DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({[record.collection]:rows.map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(path==='/booking-requests'||requestMatch){
          const fields='id,service_type,preferred_date,preferred_time,status,created_at,updated_at';
          const project=(r:Record<string,unknown>)=>({id:String(r.id),service_type:r.service_type,preferred_date:r.preferred_date,preferred_time:r.preferred_time,status:r.status,created_at:r.created_at,updated_at:r.updated_at});
          const filter='client_id::text=$1 AND tenant_id::text=$2';
          if(requestMatch){
            const row=(await db.query('SELECT '+fields+' FROM booking_requests WHERE '+filter+' AND id::text=$3',[...values,requestMatch[1]])).rows[0];
            return row?json({request:project(row)},200,safe):json({error:'Booking request not found'},404,safe);
          }
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM booking_requests WHERE '+filter,values)).rows[0].count);
          const rows=(await db.query('SELECT '+fields+' FROM booking_requests WHERE '+filter+' ORDER BY created_at DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({requests:rows.map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(visitSummary){
          const filter='client_id::text=$1 AND tenant_id::text=$2';
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT status FROM visits WHERE '+filter+' GROUP BY status) groups',values)).rows[0].count);
          const rows=(await db.query('SELECT status,COUNT(*)::int AS count FROM visits WHERE '+filter+' GROUP BY status ORDER BY status NULLS LAST LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({groups:rows.map(g=>({status:g.status,count:g.count})),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(path==='/visits'||visitMatch){
          const fields='id,service_id,requested_start_at,duration_minutes,status,priority,updated_at';
          const project=(v:Record<string,unknown>)=>({id:String(v.id),service_id:String(v.service_id),requested_start_at:v.requested_start_at,duration_minutes:v.duration_minutes,status:v.status,priority:v.priority,updated_at:v.updated_at});
          const filter='client_id::text=$1 AND tenant_id::text=$2';
          if(visitMatch){
            const visit=(await db.query('SELECT '+fields+' FROM visits WHERE '+filter+' AND id::text=$3',[...values,visitMatch[1]])).rows[0];
            return visit?json({visit:project(visit)},200,safe):json({error:'Visit not found'},404,safe);
          }
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM visits WHERE '+filter,values)).rows[0].count);
          const rows=(await db.query('SELECT '+fields+' FROM visits WHERE '+filter+' ORDER BY requested_start_at DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({visits:rows.map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(statusSummary){
          const filter='client_id::text=$1 AND tenant_id::text=$2';
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT status FROM bookings WHERE '+filter+' GROUP BY status) groups',values)).rows[0].count);
          const rows=(await db.query('SELECT status,COUNT(*)::int AS count FROM bookings WHERE '+filter+' GROUP BY status ORDER BY status NULLS LAST LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({groups:rows.map(g=>({status:g.status,count:g.count})),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        if(path==='/bookings'||bookingMatch){
          const fields='id,start_at,end_at,service_type,priority,status,recurrence_rule';
          const project=(b:Record<string,unknown>)=>({id:String(b.id),start_at:b.start_at,end_at:b.end_at,service_type:b.service_type,priority:b.priority,status:b.status,recurrence_rule:b.recurrence_rule});
          const filter='client_id::text=$1 AND tenant_id::text=$2';
          if(bookingMatch){
            const booking=(await db.query('SELECT '+fields+' FROM bookings WHERE '+filter+' AND id::text=$3',[...values,bookingMatch[1]])).rows[0];
            return booking?json({booking:project(booking)},200,safe):json({error:'Booking not found'},404,safe);
          }
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM bookings WHERE '+filter,values)).rows[0].count);
          const rows=(await db.query('SELECT '+fields+' FROM bookings WHERE '+filter+' ORDER BY start_at DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({bookings:rows.map(project),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        const invoiceFields='id,status,currency,subtotal::text AS subtotal,tax::text AS tax,total::text AS total,created_at,updated_at';
        const invoiceProject=(i:Record<string,unknown>)=>({id:String(i.id),status:i.status,currency:i.currency,subtotal:i.subtotal,tax:i.tax,total:i.total,created_at:i.created_at,updated_at:i.updated_at});
        const invoiceFilter='client_id::text=$1 AND tenant_id::text=$2';
        if(invoiceMatch){
          const invoice=(await db.query('SELECT '+invoiceFields+' FROM invoices WHERE '+invoiceFilter+' AND id::text=$3',[...values,invoiceMatch[1]])).rows[0];
          return invoice?json({invoice:invoiceProject(invoice)},200,safe):json({error:'Invoice not found'},404,safe);
        }
        if(invoiceSummary){
          const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM (SELECT currency,status FROM invoices WHERE '+invoiceFilter+' GROUP BY currency,status) groups',values)).rows[0].count);
          const groups=(await db.query('SELECT currency,status,COUNT(*)::int AS "invoiceCount",SUM(subtotal)::text AS subtotal,SUM(tax)::text AS tax,SUM(total)::text AS total FROM invoices WHERE '+invoiceFilter+' GROUP BY currency,status ORDER BY currency,status LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
          return json({groups:groups.map(g=>({currency:g.currency,status:g.status,invoiceCount:g.invoiceCount,subtotal:g.subtotal,tax:g.tax,total:g.total})),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
        }
        const filter='client_id::text=$1 AND tenant_id::text=$2';
        const total=Number((await db.query('SELECT COUNT(*)::int AS count FROM invoices WHERE '+filter,values)).rows[0].count);
        const rows=(await db.query('SELECT id,status,currency,subtotal::text AS subtotal,tax::text AS tax,total::text AS total,created_at,updated_at FROM invoices WHERE '+filter+' ORDER BY created_at DESC,id DESC LIMIT $3 OFFSET $4',[...values,Number(limit),Number(offset)])).rows;
        return json({invoices:rows.map(i=>({id:String(i.id),status:i.status,currency:i.currency,subtotal:i.subtotal,tax:i.tax,total:i.total,created_at:i.created_at,updated_at:i.updated_at})),pagination:{limit:Number(limit),offset:Number(offset),total,hasMore:Number(limit)+Number(offset)<total}},200,safe);
      }finally{await db.query('ROLLBACK');}
    });
  }catch{return json({error:'Client data unavailable'},503,safe);}
}
