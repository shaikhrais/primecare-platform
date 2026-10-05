import { mkdirSync, writeFileSync, readFileSync } from 'node:fs';

const sourcePolicy = JSON.parse(readFileSync(new URL('../cloudflare/workers/src/auth-source-policy.json',import.meta.url),'utf8')).login;

const services = ['auth', 'client', 'provider', 'visit', 'notes', 'billing', 'scheduling',
  'notification', 'verification', 'compliance', 'governance', 'franchise-reporting'];
const output = process.argv[2] || '.cloudflare-workers';
mkdirSync(output, { recursive: true });

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
    observability: { enabled: true },
    vars: { SERVICE_NAME: service, ...(service === 'auth' ? {EMAIL_FROM:'noreply@15minutes-email.com',EMAIL_ALLOWED_SENDER:'noreply@15minutes-email.com'} : {}) },
    ...(service === 'auth' ? {send_email:[{name:'EMAIL',allowed_sender_addresses:['noreply@15minutes-email.com']}]} : {}),
  }, null, 2)}\n`);
}

writeFileSync(`${output}/gateway.jsonc`, `${JSON.stringify({
  name: 'primecare-api-gateway',
  main: '../cloudflare/workers/src/gateway.ts',
  compatibility_date: '2026-09-27',
  workers_dev: true,
  observability: { enabled: true },
  services: services.map((service) => ({
    binding: service.replaceAll('-', '_').toUpperCase(), service: `primecare-${service}-api`,
  })),
}, null, 2)}\n`);
