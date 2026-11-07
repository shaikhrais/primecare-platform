import {CareClient} from './client';
import type {CareOwnership} from './ownership';
type Receipt={path:string;body:any;result:any};

/** One transport per live route, including child remounts. Uncertain retry keys
 * remain in CareClient. Acknowledgements survive failed/filtered refreshes only
 * until a rendered authorized snapshot reflects the actual returned record. */
export class LiveCareClient extends CareClient {
 private readonly receipts=new Map<string,Receipt>();
 constructor(gateway:string,token:string,private readonly owner:CareOwnership){super(gateway,token);owner.onDispose(()=>this.receipts.clear());}
 async request(path='',body?:unknown){
  if(!this.owner.current())throw Error('Care renderer is no longer current');
  const key=path+JSON.stringify(body),mutation=!!body&&!(path==='/schedules'&&(body as {action?:string}).action==='preview');
  if(mutation&&this.receipts.has(key))return this.receipts.get(key)!.result;
  const result=await super.request(path,body);
  // This is the actual server acknowledgement, not a new authorization or save.
  if(mutation)this.receipts.set(key,{path,body,result});
  return result;
 }
 confirmSnapshot(data:any):void {
  if(!this.owner.current())return;
  const rows=(value:any):any[]=>Array.isArray(value)?value:[];
  // Versions are positive integers in the care response contract. Coercion or
  // invalid numeric evidence must never release an acknowledged command.
  const validVersion=(value:unknown):value is number=>typeof value==='number'&&Number.isSafeInteger(value)&&value>0;
  const reflectedVersion=(observed:unknown,acknowledged:unknown)=>validVersion(observed)&&validVersion(acknowledged)&&observed>=acknowledged;
  for(const [key,{path,body,result}] of this.receipts){
   if(!result||typeof result!=='object')continue;
   const version=(record:any)=>record&&reflectedVersion(record.version,result.version);
   const includes=(records:any)=>rows(records).some(record=>record.id===result.id&&version(record));
   let reflected=false;
   if(path==='/staffing')reflected=includes(data.staffing?.records);
   else if(path==='/followups')reflected=includes(data.followups?.records);
   else if(path==='/handovers'){
    reflected=result.acknowledged?rows(data.detail?.handovers?.records).some(record=>record.id===result.id&&version(record)&&rows(record.receipts).some(receipt=>receipt.actor_id===data.identity?.userId)):includes(data.detail?.handovers?.records)||includes(data.handovers?.records);
   }else if(path==='/cases'||/^\/cases\/[^/]+\/actions$/.test(path))reflected=includes(data.cases)||data.detail?.id===result.id&&version(data.detail);
   else if(path==='/clearances')reflected=rows(data.people).some(person=>person.id===body.staffId&&reflectedVersion(person.clearance_version,result.version));
   else if(path==='/time-records')reflected=rows(data.timesheets?.records).some(record=>record.case_id===result.caseId&&version(record))||data.detail?.id===result.caseId&&version(data.detail.timeRecord?.report);
   else if(path==='/schedules'){
    reflected=body.action==='create'?rows(data.schedules?.series).some(series=>series.id===result.id):body.action==='cancel_occurrence'&&rows(data.schedules?.series).some(series=>rows(series.occurrences).some(visit=>visit.id===result.visitId&&visit.status==='cancelled'));
   }
   if(reflected)this.receipts.delete(key);
  }
 }
}
