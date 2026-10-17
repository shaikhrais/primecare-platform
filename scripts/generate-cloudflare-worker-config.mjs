import { mkdirSync, writeFileSync, readFileSync } from 'node:fs';

const sourcePolicy = JSON.parse(readFileSync(new URL('../cloudflare/workers/src/auth-source-policy.json',import.meta.url),'utf8')).login;
const visionPolicy = JSON.parse(readFileSync(new URL('../cloudflare/workers/src/look/provider-policy.json',import.meta.url),'utf8'));

const services = ['auth', 'client', 'provider', 'visit', 'notes', 'billing', 'scheduling',
  'notification', 'verification', 'compliance', 'governance', 'franchise-reporting'];
const emailServices = new Set(['auth', 'governance']);
const output = process.argv[2] || '.cloudflare-workers';
mkdirSync(output, { recursive: true });
if(process.env.LOOK_AI_SERVICE&&!/^[a-z0-9][a-z0-9-]{0,62}$/.test(process.env.LOOK_AI_SERVICE))throw Error('Invalid LOOK_AI_SERVICE');
if(process.env.LOOK_AI_MODEL&&!/^[a-zA-Z0-9._:-]{1,100}$/.test(process.env.LOOK_AI_MODEL))throw Error('Invalid LOOK_AI_MODEL');
writeFileSync(`${output}/look-ai.jsonc`, `${JSON.stringify({
  name:visionPolicy.serviceName,main:'../cloudflare/workers/src/look/vision-provider.ts',
  compatibility_date:visionPolicy.compatibilityDate,compatibility_flags:['nodejs_compat'],workers_dev:false,preview_urls:false,routes:[],
  observability:{enabled:false},vars:process.env.LOOK_AI_MODEL?{LOOK_AI_MODEL:process.env.LOOK_AI_MODEL}:{},
  durable_objects:{bindings:[{name:visionPolicy.jobBinding,class_name:visionPolicy.jobClass}]},
  migrations:[{tag:'vision-provider-v1',new_sqlite_classes:[visionPolicy.jobClass]}],
},null,2)}\n`);

for (const service of services) {
  writeFileSync(`${output}/${service}.jsonc`, `${JSON.stringify({
    name: `primecare-${service}-api`,
    main: '../cloudflare/workers/src/service.ts',
    compatibility_date: '2026-09-27',
    compatibility_flags: ['nodejs_compat'],
    workers_dev: true,
    ...(service === 'auth' ? {ratelimits:[{name:'AUTH_SOURCE_LIMIT',namespace_id:sourcePolicy.namespaceId,
      simple:{limit:sourcePolicy.maxAttempts,period:sourcePolicy.windowSeconds}},
      {name:'WORKSPACE_SOURCE_LIMIT',namespace_id:'2026100402',simple:{limit:120,period:60}}]} : {}),
    ...(service === 'provider' ? {ratelimits:[{name:'WORKSPACE_SOURCE_LIMIT',namespace_id:'2026100404',simple:{limit:120,period:60}}]} : {}),
    ...(service === 'client' ? {ratelimits:[{name:'WORKSPACE_SOURCE_LIMIT',namespace_id:'2026100403',simple:{limit:120,period:60}}]} : {}),
    ...(service === 'governance' ? {ratelimits:[{name:'WORKSPACE_SOURCE_LIMIT',namespace_id:'2026100401',
      simple:{limit:120,period:60}}]} : {}),
    ...(service === 'governance' && process.env.LOOK_AI_SERVICE ? {services:[{binding:'LOOK_AI',service:process.env.LOOK_AI_SERVICE}]} : {}),
    observability: { enabled: true },
    vars: { SERVICE_NAME: service, ...(emailServices.has(service) ? {EMAIL_FROM:'noreply@15minutes-email.com',EMAIL_ALLOWED_SENDER:'noreply@15minutes-email.com'} : {}) },
    ...(emailServices.has(service) ? {send_email:[{name:'EMAIL',allowed_sender_addresses:['noreply@15minutes-email.com']}]} : {}),
  }, null, 2)}\n`);
}

writeFileSync(`${output}/gateway.jsonc`, `${JSON.stringify({
  name: 'primecare-api-gateway',
  compatibility_flags: ['nodejs_compat'],
  main: '../cloudflare/workers/src/gateway.ts',
  compatibility_date: '2026-09-27',
  workers_dev: true,
  observability: { enabled: true },
  services: services.map((service) => ({
    binding: service.replaceAll('-', '_').toUpperCase(), service: `primecare-${service}-api`,
  })),
}, null, 2)}\n`);
