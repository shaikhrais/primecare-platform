import {services,minutes,validDate} from '../../../../packages/shared/src/psw-workspace/schedule-core.mjs';
const object=(v:any)=>v!==null&&typeof v==='object'&&!Array.isArray(v);
const text=(v:any)=>typeof v==='string';
const strings=(v:any)=>Array.isArray(v)&&v.every(text);
export const demoScope=(v:any)=>JSON.stringify([v?.dataset,v?.identity?.userId,v?.identity?.tenantId,v?.identity?.role,v?.canManage]);
/** Presentation integrity, including inactive pages; never server authorization. */
export function demoSnapshot(v:any){
 const bad=()=>{throw Error('Invalid demo workspace response. Refresh to confirm saved data.');};
 if(!object(v)||v.dataset!=='demo'||v.synthetic!==true||v.database!=='PostgreSQL'||!Number.isSafeInteger(v.version)||v.version<=0||typeof v.canManage!=='boolean'||typeof v.liveCareAvailable!=='boolean'||!object(v.identity)||!['userId','tenantId','role','organization'].every(k=>text(v.identity[k])&&v.identity[k])||!Array.isArray(v.scopes)||!v.scopes.every((s:any)=>object(s)&&text(s.id)&&text(s.name)))bad();
 const s=v.state;if(!object(s)||!['providers','clients','visits','waitlist','incidents','messages','availabilityRequests','audit','feedback','timesheet'].every(k=>Array.isArray(s[k])&&s[k].every(object))||!object(s.settings)||!Number.isFinite(s.settings.travelBuffer))bad();
 const shift=(s:any)=>object(s)&&['start','end','breakStart','breakEnd'].every(k=>Number.isFinite(minutes(s[k])));
 const unique=(a:any[])=>a.every(r=>text(r.id)&&r.id)&&new Set(a.map(r=>r.id)).size===a.length;
 if(!unique(s.providers)||!s.providers.length||!s.providers.some((p:any)=>p.id==='p1')||!unique(s.clients)||!unique(s.visits))bad();
 const providers=new Set(s.providers.map((p:any)=>p.id)),clients=new Set(s.clients.map((c:any)=>c.id));
 if(!s.providers.every((p:any)=>['name','initials','color','role'].every(k=>text(p[k]))&&strings(p.zones)&&shift(p.shift)&&(p.exceptions===undefined||object(p.exceptions)&&Object.values(p.exceptions).every(shift))))bad();
 if(!s.clients.every((c:any)=>['name','initials','zone','area','contact','plan','preferences'].every(k=>text(c[k]))&&providers.has(c.preferredProviderId)&&strings(c.tasks)&&strings(c.alerts)))bad();
 if(!s.visits.every((r:any)=>providers.has(r.providerId)&&clients.has(r.clientId)&&Object.hasOwn(services,r.service)&&validDate(r.date)&&Number.isFinite(minutes(r.start))&&Number.isFinite(r.duration)&&text(r.status)&&text(r.note)&&object(r.taskLog)&&Array.isArray(r.history)&&r.history.every((h:any)=>object(h)&&text(h.at)&&text(h.action))))bad();
 if(!s.waitlist.every((r:any)=>text(r.id)&&clients.has(r.clientId)&&Object.hasOwn(services,r.service)&&Number.isFinite(r.duration)&&Number.isFinite(minutes(r.from))&&Number.isFinite(minutes(r.to))&&text(r.note)))bad();
 if(!s.incidents.every((r:any)=>text(r.id)&&clients.has(r.clientId)&&(!r.providerId||providers.has(r.providerId))&&['type','facts','action','followup','status'].every(k=>text(r[k]))&&validDate(r.date)))bad();
 if(!s.messages.every((r:any)=>['id','from','to','subject','text','at'].every(k=>text(r[k]))))bad();
 if(!s.availabilityRequests.every((r:any)=>text(r.id)&&providers.has(r.providerId)&&validDate(r.date)&&text(r.reason)&&text(r.status)))bad();
 if(!s.feedback.every((r:any)=>['decision','comment','at'].every(k=>text(r[k])))||!s.audit.every((r:any)=>text(r.action)&&text(r.at)))bad();
 return v;
}
