import {mkdir,writeFile} from 'node:fs/promises';
import {pathToFileURL} from 'node:url';

// Names only in reports. Never emit values, prefixes, hashes or provider errors.
const required=Object.freeze([
 'PRODUCTION_DATABASE_URL','CLOUDFLARE_API_TOKEN','CLOUDFLARE_ACCOUNT_ID',
 'TWILIO_ACCOUNT_SID','TWILIO_AUTH_TOKEN','TWILIO_API_KEY_SID','TWILIO_API_KEY_SECRET',
 'TWILIO_VERIFY_SERVICE_SID','TWILIO_APPLICATION_SID','TWILIO_MESSAGING_SERVICE_SID','OPENAI_API_KEY',
 'VOICE_MODEL','VOICE_ORIGIN',
]);
export function voiceDeploymentConfiguration(environment){
 const missing=required.filter(name=>typeof environment[name]!=='string'||!environment[name].trim());
 return {sourceCommit:typeof environment.GITHUB_SHA==='string'&&/^[a-f0-9]{40}$/.test(environment.GITHUB_SHA)?environment.GITHUB_SHA:null,
  purpose:'Deployment configuration presence only; values and provider credentials are never exported.',
  configured:required.filter(name=>!missing.includes(name)),missing,configurationPresent:missing.length===0,
  runtimeMounted:false,liveCallVerified:false,numberRoutingChanged:false,providerWrites:false};
}
if(process.argv[1]&&import.meta.url===pathToFileURL(process.argv[1]).href){
 const report=voiceDeploymentConfiguration(process.env);
 await mkdir('test-results/voice-runtime',{recursive:true});
 await writeFile('test-results/voice-runtime/configuration.json',JSON.stringify(report,null,2)+'\n');
 console.log('VOICE_DEPLOYMENT_CONFIGURATION '+JSON.stringify(report));
 if(!report.configurationPresent)process.exitCode=1;
}
