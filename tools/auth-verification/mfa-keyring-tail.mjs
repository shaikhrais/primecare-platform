import {spawn} from 'node:child_process';
import {mkdirSync,readFileSync,writeFileSync} from 'node:fs';
import {pathToFileURL} from 'node:url';
import {mfaKeyringSource} from '../../scripts/mfa-keyring-source.mjs';

// Wrangler emits pretty JSON objects. Retain one bounded event at a time and
// never print raw events: unrelated logs can contain operational information.
export class TailObjects {
  constructor(accept){this.accept=accept;this.value='';this.depth=0;this.string=false;this.escape=false;}
  push(chunk){
    for(const ch of chunk){
      if(!this.depth){if(ch!=='{')continue;this.depth=1;this.value='{';continue;}
      this.value+=ch;if(this.value.length>2*1024*1024)throw Error('Tail event exceeds limit');
      if(this.string){if(this.escape)this.escape=false;else if(ch==='\\')this.escape=true;else if(ch==='"')this.string=false;continue;}
      if(ch==='"')this.string=true;else if(ch==='{')this.depth++;else if(ch==='}'&&!--this.depth){
        const value=this.value;this.value='';let event;try{event=JSON.parse(value);}catch{throw Error('Malformed tail event');}this.accept(event);
      }
    }
  }
}
const keys=(value,expected)=>value&&typeof value==='object'&&!Array.isArray(value)&&Object.keys(value).sort().join(',')===[...expected].sort().join(',');
export function keyringEvidence(event,expected){
  if(event?.scriptName!=='primecare-auth-api'||event?.event?.cron!=='*/5 * * * *'||event?.outcome!=='ok'||!Array.isArray(event.logs))return [];
  const receipts=[];
  for(const log of event.logs){
    if(!Array.isArray(log.message))continue;
    for(const message of log.message){
      if(typeof message!=='string')continue;
      const kind=message.startsWith('MFA_KEYRING_DRILL ')?'drill':message.startsWith('MFA_KEY_ROTATION_REPORT ')?'rotation':null;
      if(!kind)continue;let body;try{body=JSON.parse(message.slice(message.indexOf(' ')+1));}catch{continue;}
      if(body.source!==expected.source||body.verified!==true)continue;
      if(kind==='drill'&&keys(body,['source','verified','activeKeyId','fromKeyId','toKeyId'])&&body.activeKeyId===expected.activeKeyId&&body.fromKeyId==='mfa-v1'&&body.toKeyId==='mfa-v2')receipts.push({kind,...body});
      const counts=['rewrapped','expiredReplacementChallengesRemoved','remainingOldCredentials','remainingOldReplacementEnvelopes'];
      if(kind==='rotation'&&keys(body,['source','verified','fromKeyId','toKeyId',...counts])&&body.fromKeyId===expected.migrateFromKeyId&&body.toKeyId===expected.activeKeyId&&counts.every(key=>Number.isSafeInteger(body[key])&&body[key]>=0)&&body.rewrapped<=10&&body.expiredReplacementChallengesRemoved<=50)receipts.push({kind,...body});
    }
  }
  return receipts;
}
async function main(){
  const bin=process.argv[2];if(!bin)throw Error('Wrangler CLI path required');
  const policy=JSON.parse(readFileSync('cloudflare/workers/src/security/mfa-keyring-policy.json','utf8'));
  const expected={source:mfaKeyringSource(),activeKeyId:policy.activeKeyId,migrateFromKeyId:policy.migrateFromKeyId};
  let drill,rotation,settled=false;const output='test-results/mfa-keyring/receipt.json';mkdirSync('test-results/mfa-keyring',{recursive:true});
  await new Promise((resolve,reject)=>{
    const child=spawn(process.execPath,[bin,'tail','--config','.cloudflare-workers/auth.jsonc','--format','json','--sampling-rate','1'],{stdio:['ignore','pipe','ignore']});
    const finish=(error)=>{if(settled)return;settled=true;clearTimeout(deadline);child.kill('SIGTERM');error?reject(error):resolve();};
    const deadline=setTimeout(()=>finish(Error('No matching scheduled keyring proof before deadline')),14*60*1000);
    const parser=new TailObjects(event=>{
      for(const receipt of keyringEvidence(event,expected)){if(receipt.kind==='drill')drill=receipt;else rotation=receipt;}
      if(drill&&(!expected.migrateFromKeyId||rotation&&rotation.remainingOldCredentials===0&&rotation.remainingOldReplacementEnvelopes===0)){
        writeFileSync(output,JSON.stringify({source:process.env.GITHUB_SHA,keyringSource:expected.source,activeKeyId:expected.activeKeyId,migrateFromKeyId:expected.migrateFromKeyId,observedAt:new Date().toISOString(),actualBindingDrill:drill,rotation:rotation??null,oldKeyDeleted:false,independentApprovals:false},null,2)+'\n');finish();
      }
    });
    child.stdout.setEncoding('utf8');child.stdout.on('data',chunk=>{try{parser.push(chunk);}catch{finish(Error('Invalid keyring tail stream'));}});
    child.on('error',()=>finish(Error('Unable to start keyring verification')));child.on('exit',()=>{if(!settled)finish(Error('Keyring tail ended without matching proof'));});
  });
  console.log('Verified scheduled keyring bindings and required migration counts; receipt saved.');
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href)main().catch(()=>{console.error('MFA keyring live verification failed; no proof recorded.');process.exitCode=1;});
