import {registry,fail,identifier} from './contract';
import {keys,text,integer,timestamp,date} from '../growth/contract';

export function localToUtc(local:string,zone:string){
 if(!/^\d{4}-\d\d-\d\dT\d\d:\d\d$/.test(local))fail(400);
 date(local.slice(0,10));const [year,month,day,hour,minute]=local.match(/\d+/g)!.map(Number);
 if(hour>23||minute>59||!registry.schedulePolicy.timeZones.includes(zone))fail(400);
 const target=Date.UTC(year,month-1,day,hour,minute),fmt=new Intl.DateTimeFormat('en-CA',{timeZone:zone,year:'numeric',month:'2-digit',day:'2-digit',hour:'2-digit',minute:'2-digit',second:'2-digit',hourCycle:'h23'});
 const parts=(instant:number)=>Object.fromEntries(fmt.formatToParts(new Date(instant)).map(p=>[p.type,p.value]));
 const matches=new Set<number>();
 for(const delta of [-36,0,36]){
  const sample=target+delta*3600000,p=parts(sample),offset=Date.UTC(+p.year,+p.month-1,+p.day,+p.hour,+p.minute,+p.second)-sample,candidate=target-offset,q=parts(candidate);
  if(+q.year===year&&+q.month===month&&+q.day===day&&+q.hour===hour&&+q.minute===minute)matches.add(candidate);
 }
 if(matches.size!==1)fail(400,matches.size?'ambiguous_local_time':'invalid_local_time');
 return new Date([...matches][0]).toISOString();
}
export function scheduleBody(v:Record<string,unknown>){
 const action=String(v.action),p=registry.schedulePolicy;
 if(!p.actions.includes(action)||!text(v.note,2000))fail(400);
 if(action==='cancel_occurrence'){
  keys(v,['action','visitId','updatedAt','note']);if(!identifier(v.visitId))fail(400);return {...v,action,updatedAt:timestamp(v.updatedAt)};
 }
 keys(v,['action','sourceVisitId','localStart','timeZone','count','intervalWeeks','durationMinutes','note',...(action==='create'?['confirmed']:[])]);
 if(!identifier(v.sourceVisitId)||typeof v.localStart!=='string'||!p.timeZones.includes(String(v.timeZone))||action==='create'&&v.confirmed!==true)fail(400);
 const count=integer(v.count,p.maxOccurrences),intervalWeeks=integer(v.intervalWeeks,p.maxWeeksInterval),durationMinutes=integer(v.durationMinutes,p.maxDurationMinutes);
 if(!count||!intervalWeeks||durationMinutes<p.minDurationMinutes)fail(400);
 localToUtc(String(v.localStart),String(v.timeZone));
 const occurrences=[];for(let n=0;n<count;n++){
  const local=new Date(Date.parse(v.localStart+'Z')+n*intervalWeeks*7*86400000).toISOString().slice(0,16),startsAt=localToUtc(local,String(v.timeZone));
  if(Date.parse(startsAt)<=Date.now()||Date.parse(startsAt)+durationMinutes*60000>Date.now()+p.maxDaysAhead*86400000)fail(400);
  occurrences.push({localStart:local,startsAt,endsAt:new Date(Date.parse(startsAt)+durationMinutes*60000).toISOString()});
 }
 return {...v,action,count,intervalWeeks,durationMinutes,occurrences};
}
export function timeBody(v:Record<string,unknown>){
 const action=String(v.action);if(!registry.timePolicy.actions.includes(action)||!text(v.note,2000)||typeof v.caseId!=='string'||!/^[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}$/i.test(v.caseId))fail(400);
 keys(v,['action','caseId','version','note',...(action==='submit'?['actualStart','actualEnd','breakMinutes','attested']:action==='approve'?['checked']:[])]);
 const version=integer(v.version,registry.timePolicy.maxVersions-1);
 if(action==='approve'&&v.checked!==true)fail(400);
 if(action!=='submit')return {...v,action,version};
 const actualStart=timestamp(v.actualStart)!,actualEnd=timestamp(v.actualEnd)!,breakMinutes=integer(v.breakMinutes,registry.timePolicy.maxMinutes),elapsed=(Date.parse(actualEnd)-Date.parse(actualStart))/60000;
 if(v.attested!==true||elapsed<=0||elapsed>registry.timePolicy.maxMinutes||breakMinutes>=Math.floor(elapsed)||Date.parse(actualEnd)>Date.now()||Date.parse(actualStart)<Date.now()-366*86400000)fail(400);
 return {...v,action,version,actualStart,actualEnd,breakMinutes,netMinutes:Math.floor(elapsed)-breakMinutes};
}
