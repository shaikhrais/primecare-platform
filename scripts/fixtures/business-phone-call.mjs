import {PhoneOtpCallAuthorizationService} from '../../cloudflare/workers/src/business-tasks/call-authorization.ts';
import {VoiceTaskService} from '../../cloudflare/workers/src/business-tasks/voice-tasks.ts';
import {SpokenVoiceTaskConfirmationService} from '../../cloudflare/workers/src/business-tasks/voice-spoken-confirmations.ts';
import {AppointmentBookingTask} from '../../cloudflare/workers/src/business-tasks/voice-reception-tasks.ts';
export const accountSid='AC'+'a'.repeat(32),callSid='CA'+'b'.repeat(32),sharedNumber='+15550001000',phone='+15550002000',verificationSid='VE'+'c'.repeat(32);
export const actor={id:'alice',tenantId:'tenant-a'};
export const args=()=>({serviceId:'psw-service',slotId:'slot-a',slotVersion:1,startsAt:new Date(Date.now()+86400000).toISOString()});
export function fixture(ports={}){
 const grants=new Map(),proofs=new Map(),intents=new Map();let sends=0,checks=0,writes=0,denied=false,providerFail=false,taskFail=false;
 const call={sid:callSid,accountSid,to:sharedNumber,from:'+15550009999',direction:'inbound',status:'in-progress'};
 const account={actor:{...actor},reference:'4277',directoryVersion:1,phone,contactVersion:1};
 const store={async run(){throw Error('unused');},async read(){throw Error('unused');},async inbox(){throw Error('unused');}};
 const policy={async assert(a,action,state){if(denied||a.id!==actor.id||a.tenantId!==actor.tenantId||state.tenantId!==a.tenantId)throw Error('Policy denied');},async assignee(){throw Error('No assignment');}};
 const grantRepo=ports.grants??{async begin(row){if(grants.has(row.callSid))throw Error('Already started');grants.set(row.callSid,structuredClone({...row,attempts:0}));},async read(id){return structuredClone(grants.get(id)??null);},async sent(id,sid){Object.assign(grants.get(id),{state:'pending',verificationSid:sid});},async claimCheck(id){const row=grants.get(id);if(row.state!=='pending'||row.attempts>=5)return false;row.attempts++;row.state='checking';return true;},async checked(id,approved,sessionId,expiresAt){const row=grants.get(id);Object.assign(row,{state:approved?'verified':'pending',sessionId:approved?sessionId:null,...(approved?{expiresAt}:{})});},async unknown(id){const row=grants.get(id);if(row)Object.assign(row,{state:'unknown',sessionId:null});}};
 const proofRepo=ports.proofs??{async prepare(p){const old=proofs.get(p.callSid);if(old&&old.expiresAt>Date.now()&&!['declined','consumed'].includes(old.state))throw Error('Pending');proofs.set(p.callSid,structuredClone(p));},async read(id){return structuredClone(proofs.get(id)??null);},async decide(p,method){const row=proofs.get(p.callSid);if(row.state!=='prepared'||row.challengeId!==p.challengeId)return false;Object.assign(row,{state:method?'approved':'declined',method,approvedAt:method?Date.now():null});return true;},async consume(p){const row=proofs.get(p.callSid);if(row.state!=='approved'||row.challengeId!==p.challengeId)return false;row.state='consumed';return true;}};
 const intentRepo=ports.intents??{async create(i){intents.set(i.id,structuredClone(i));},async read(id){return structuredClone(intents.get(id)??null);},async claim(id,digest){const row=intents.get(id);if(row.status!=='proposed'||row.digest!==digest)return false;row.status='executing';return true;},async finish(id,status){intents.get(id).status=status;}};
 const authPorts={calls:{async fetch(){return {...call};}},accounts:ports.accounts??{async resolve(reference){return reference===account.reference?structuredClone(account):null;}},provider(){return {async start(){sends++;if(providerFail)throw Error('Uncertain send');return {verificationSid,status:'pending'};},async check(sid,code){checks++;if(sid!==verificationSid)throw Error('Wrong receipt');return {approved:code==='123456'};}};}};
 const authorization=new PhoneOtpCallAuthorizationService(store,policy,grantRepo,authPorts,{accountSid,sharedNumber});
 const confirmations=new SpokenVoiceTaskConfirmationService(store,policy,authorization,intentRepo,proofRepo);
 const booking=new AppointmentBookingTask(async(a,input,key)=>{if(taskFail)throw Error('Timeout');writes++;if(ports.book)await ports.book(a,input,key);});
 const tasks=new VoiceTaskService(store,policy,intentRepo,confirmations,[booking]);
 return {store,policy,authorization,confirmations,tasks,call,account,authPorts,grantRepo,proofRepo,intentRepo,grants,proofs,intents,deny(){denied=true;},failProvider(){providerFail=true;},failTask(){taskFail=true;},get sends(){return sends;},get checks(){return checks;},get writes(){return writes;}};
}
