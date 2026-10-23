import Twilio from 'twilio/lib/rest/Twilio.js';
import {twilioSid} from './twilio-webhook.mjs';
import {salesDigest} from './sales-call-quality.ts';

/** Read-only classic Intelligence adapter. Configured custom JSON operator must emit
 * {rubricDigest,points:[{id,status,evidence:[{quote}]}]} for the pinned rubric.
 * Host must authenticate/authorize current call scope before calling read(). No recording,
 * transcription creation, configuration changes, phone calls or model actions occur here.
 */
export function createTwilioSalesQualitySource({accountSid,apiKeySid,apiKeySecret,serviceSid,operatorSid,rubricDigest,operatorConfigDigest,httpClient}){
 if(!twilioSid('AC',accountSid)||!twilioSid('SK',apiKeySid)||!twilioSid('GA',serviceSid)||!twilioSid('LY',operatorSid)||typeof apiKeySecret!=='string'||apiKeySecret.length!==32||!/^[a-fA-F0-9]{32}$/.test(apiKeySecret)||typeof rubricDigest!=='string'||rubricDigest.length!==64||!/^[a-f0-9]{64}$/.test(rubricDigest)||typeof operatorConfigDigest!=='string'||operatorConfigDigest.length!==64||!/^[a-f0-9]{64}$/.test(operatorConfigDigest)||httpClient!==undefined&&typeof httpClient?.request!=='function')throw Error('Sales analysis configuration required');
 const client=new Twilio(apiKeySid,apiKeySecret,{accountSid,autoRetry:false,maxRetries:0,timeout:10000,...(httpClient?{httpClient}:{})});
 function bounded(value,max){if(new TextEncoder().encode(JSON.stringify(value)).length>max)throw Error('Provider result bounds');return value;}
 function decimal(value){if(typeof value!=='number'&&(typeof value!=='string'||!/^\d+(?:\.\d+)?$/.test(value)))throw Error('Provider number invalid');const n=Number(value);if(!Number.isFinite(n))throw Error('Provider number invalid');return n;}
 return Object.freeze({async read(scope,expectedRubricDigest){
  // Capture primitives before awaiting; callers cannot mutate the recording, speaker or digest.
  const {callId,recordingSid,transcriptSid,agentChannel,captureApproved}=scope??{};
  if(!twilioSid('CA',callId)||!twilioSid('RE',recordingSid)||!twilioSid('GT',transcriptSid)||![1,2].includes(agentChannel)||captureApproved!==true||expectedRubricDigest!==rubricDigest)throw Error('Sales analysis unavailable');
  try{
   const operator=await client.intelligence.v2.customOperators(operatorSid).fetch();
   const configHash=await salesDigest(bounded(operator.config,32768));
   if(operator.sid!==operatorSid||operator.accountSid!==accountSid||configHash!==operatorConfigDigest)throw Error('Operator configuration changed');
   const recording=await client.recordings(recordingSid).fetch();
   if(recording.sid!==recordingSid||recording.accountSid!==accountSid||recording.callSid!==callId||recording.status!=='completed'||recording.channels!==2)throw Error('Canonical recording required');
   // Conference channel 2 mixes participants; it is not a reliable agent/customer channel.
   if(recording.conferenceSid||!['DialVerb','OutboundAPI','StartCallRecordingAPI'].includes(recording.source))throw Error('Two-party call recording required');
   const transcript=client.intelligence.v2.transcripts(transcriptSid),header=await transcript.fetch();
   if(header.sid!==transcriptSid||header.accountSid!==accountSid||header.serviceSid!==serviceSid||header.status!=='completed'||header.channel?.media_properties?.source_sid!==recordingSid)throw Error('Canonical transcript required');
   const duration=decimal(header.duration),recordingDuration=decimal(recording.duration);
   // Metadata durations are seconds; allow one second for rounding, not a shortened recording.
   if(duration<=0||recordingDuration<=0||duration>28800||recordingDuration>28800||Math.abs(duration-recordingDuration)>1)throw Error('Incomplete transcript duration');
   // Fetch one beyond each bound so SDK pagination cannot silently produce a partial score.
   const sentences=await transcript.sentences.list({limit:4001,pageSize:500,redacted:true});
   if(!sentences.length||sentences.length>4000)throw Error('Transcript bounds');bounded(sentences,1048576);
   const results=await transcript.operatorResults.list({limit:101,pageSize:100,redacted:true});
   if(results.length>100)throw Error('Operator bounds');bounded(results,524288);
   const matches=results.filter(r=>r.operatorSid===operatorSid);
   if(matches.length!==1||matches[0].transcriptSid!==transcriptSid||matches[0].operatorType!=='json')throw Error('Pinned operator required');
   const output=matches[0].jsonResults;
   if(!output||typeof output!=='object'||Array.isArray(output)||output.rubricDigest!==rubricDigest||!Array.isArray(output.points))throw Error('Custom operator result unavailable');
   const points=output.points.map(p=>{
    if(!p||!Array.isArray(p.evidence)||p.evidence.length>5)throw Error('Invalid evidence');
    return {id:p.id,status:p.status,evidence:p.evidence.map(e=>{
     const matches=sentences.filter(s=>s.mediaChannel===agentChannel&&s.transcript===e?.quote);
     if(matches.length!==1)throw Error('Ambiguous or invented quote');
     return {sentenceId:matches[0].sid,quote:e.quote};
    })};
   });
   return structuredClone({operatorId:operatorSid,rubricDigest,provenance:{accountSid,serviceSid,recordingSid,operatorConfigDigest},points,transcript:{id:transcriptSid,complete:true,duration,sentences:sentences.map(s=>{
    if(!twilioSid('GX',s.sid)||![1,2].includes(s.mediaChannel))throw Error('Speaker mapping required');
    const confidence=s.confidence===null||s.confidence===undefined||s.confidence===''?null:decimal(s.confidence);
    return {id:s.sid,speaker:s.mediaChannel===agentChannel?'agent':'customer',text:s.transcript,start:decimal(s.startTime),end:decimal(s.endTime),confidence};
   })}});
  }catch{throw Error('Sales analysis unavailable');}
 }});
}
