const fs = require('fs');
const path = require('path');

const domainsBaseDir = path.join(__dirname, 'src', 'domains');
if (!fs.existsSync(domainsBaseDir)) fs.mkdirSync(domainsBaseDir, { recursive: true });

const domains = [
  'intake',
  'care-plans',
  'compliance',
  'training',
  'support',
  'franchise',
  'reporting'
];

const constructNamespace = (name) => name.replace(/-./g, x=>x[1].toUpperCase());

domains.forEach(domain => {
  const domainDir = path.join(domainsBaseDir, domain);
  if (!fs.existsSync(domainDir)) {
    fs.mkdirSync(domainDir, { recursive: true });
  }

  const namespace = constructNamespace(domain); // e.g. "carePlans"

  const routesContent = `
import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary } from './${domain}.handlers';

export const ${namespace}Routes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['${namespace.toUpperCase()}'],
  description: 'Fetching standard payload for ${domain} domain',
  responses: {
    200: {
      description: '${domain} domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

${namespace}Routes.openapi(summaryRoute, handleGetSummary);
`;

  const moduleContent = `
import { OpenAPIHono } from '@hono/zod-openapi';
import { ${namespace}Routes } from './${domain}.routes';

const app = new OpenAPIHono();

app.route('/', ${namespace}Routes);

export default app;
`;

  const handlersContent = `
import { Context } from 'hono';

export const handleGetSummary = async (c: Context) => {
  return c.json({ status: '${domain.toUpperCase()} domain operational' });
};
`;

  fs.writeFileSync(path.join(domainDir, `${domain}.routes.ts`), routesContent.trim() + '\n');
  fs.writeFileSync(path.join(domainDir, `${domain}.handlers.ts`), handlersContent.trim() + '\n');
  fs.writeFileSync(path.join(domainDir, `${domain}.module.ts`), moduleContent.trim() + '\n');

  console.log(`✅ Scaffolded ${domain} Domain`);
});

console.log('Phase 2 Execution Scaffold Script Complete.');
