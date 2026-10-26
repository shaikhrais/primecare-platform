const names=['auth','client','provider','visit','notes','billing','scheduling','notification','verification','compliance','governance','franchise-reporting'];
/** Preserve the known gateway surface. Unknown bindings or entrypoints require
 * reconciliation instead of being dropped by a generated deployment config. */
export function nativeContactGatewayServices(settings,config){
 const expected=names.map(s=>({name:s.replaceAll('-','_').toUpperCase(),service:'primecare-'+s+'-api'}));
 const optional=[{name:'EXTERNAL_CALLS',service:'primecare-external-calls-api'},{name:'VOICE_CONTACT',service:'primecare-voice-contact-api'},{name:'INTERNAL_CALLS',service:'primecare-internal-calls-api'}].filter(e=>e.name!==config.gatewayBinding);
 const allowed=b=>{if(b.type==='secret_text'&&b.name==='JWT_SECRET')return true;if(b.type!=='service'||b.environment&&b.environment!=='production'||b.entrypoint)return false;return b.name===config.gatewayBinding?b.service===config.workerName:[...expected,...optional].some(e=>e.name===b.name&&e.service===b.service);};
 const bindings=settings?.bindings;
 if(!Array.isArray(bindings)||bindings.some(b=>!allowed(b))||expected.some(e=>bindings.filter(b=>b.name===e.name&&b.service===e.service&&b.type==='service').length!==1)||bindings.filter(b=>b.name===config.gatewayBinding).length>1||bindings.filter(b=>b.name==='JWT_SECRET').length>1||optional.some(e=>bindings.filter(b=>b.name===e.name).length>1))throw Error('gateway_settings_changed_preserved');
 return [...[...expected,...optional.filter(e=>bindings.some(b=>b.name===e.name))].map(b=>({binding:b.name,service:b.service})),{binding:config.gatewayBinding,service:config.workerName}];
}
export function assertOwnedNativeContactTarget(settings,config){
 if(settings===null)return;
 const allowed=['VOICE_CONTACT_OWNER','VOICE_CONTACT_SOURCE','VOICE_CONTACT_ORIGIN','VOICE_GATEWAY_ORIGIN','VOICE_CONTACT_CONTRACT_SHA','VOICE_CONTACT_ACCESS_SHA','VOICE_CONTACT_LIMIT','DB_URL','TWILIO_ACCOUNT_SID','TWILIO_API_KEY_SID','TWILIO_API_KEY_SECRET','TWILIO_VERIFY_SERVICE_SID'];
 if(!Array.isArray(settings?.bindings)||settings.bindings.find(b=>b.name==='VOICE_CONTACT_OWNER')?.text!==config.owner||settings.bindings.some(b=>!allowed.includes(b.name))||new Set(settings.bindings.map(b=>b.name)).size!==settings.bindings.length)throw Error('existing_worker_preserved');
}
