import { mkdirSync, writeFileSync } from 'node:fs';

const services = {
  auth: 'auth_api', client: 'client_api', provider: 'provider_api', visit: 'visit_api',
  notes: 'notes_api', billing: 'billing_api', scheduling: 'scheduling_api',
  notification: 'notification_api', verification: 'verification_api',
  compliance: 'compliance_api', governance: 'governance_api',
  'franchise-reporting': 'franchise_reporting_api',
};
const output = process.argv[2] || '.cloudflare-generated';
mkdirSync(output, { recursive: true });

for (const [name, directory] of Object.entries(services)) {
  const config = {
    $schema: '../node_modules/wrangler/config-schema.json',
    name: `primecare-${name}-api`,
    main: '../cloudflare/containers/src/service.ts',
    compatibility_date: '2026-09-27',
    workers_dev: true,
    observability: { enabled: true },
    vars: { SERVICE_NAME: name },
    containers: [{
      class_name: 'ApiContainer',
      image: `../services/${directory}/Dockerfile`,
      image_build_context: '..',
      instance_type: 'lite',
      max_instances: 2,
      constraints: { regions: ['ENAM'] },
    }],
    durable_objects: { bindings: [{ name: 'API_CONTAINER', class_name: 'ApiContainer' }] },
    migrations: [{ tag: 'v1', new_sqlite_classes: ['ApiContainer'] }],
  };
  writeFileSync(`${output}/${name}.jsonc`, `${JSON.stringify(config, null, 2)}\n`);
}

const bindings = Object.keys(services).map(name => ({
  binding: name.replaceAll('-', '_').toUpperCase(),
  service: `primecare-${name}-api`,
}));
writeFileSync(`${output}/gateway.jsonc`, `${JSON.stringify({
  $schema: '../node_modules/wrangler/config-schema.json',
  name: 'primecare-api-gateway',
  main: '../cloudflare/containers/src/gateway.ts',
  compatibility_date: '2026-09-27',
  workers_dev: true,
  observability: { enabled: true },
  services: bindings,
}, null, 2)}\n`);

console.log(`Generated ${Object.keys(services).length + 1} Wrangler configurations in ${output}`);
