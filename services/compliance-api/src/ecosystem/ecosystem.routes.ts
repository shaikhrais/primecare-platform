import { z } from 'zod';
import { createRoute, OpenAPIHono } from '@hono/zod-openapi';
import type { Bindings, Variables } from '@primecare/contracts';

export const ecosystemModule = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const EcosystemProtocolSchema = z.object({
  id: z.string(),
  scenarioName: z.string(),
  triggerEvent: z.string(),
  severity: z.string(),
  isActive: z.boolean(),
  resolutions: z.array(z.object({
    id: z.string(),
    actionType: z.string(),
    escalateToRoleId: z.string().nullable(),
    uiOverrideKey: z.string().nullable(),
  }))
});

// GET /v1/system/ecosystem/protocols
// Pushes the exact situational logic down to the devices, empowering offline-native apps to physically know how to survive hardware outages without the Cloudflare host online.
const getProtocolsRoute = createRoute({
  method: 'get',
  path: '/protocols',
  tags: ['Ecosystem'],
  summary: 'Retrieve all active Crisis Protocols natively.',
  responses: {
    200: { 
      description: 'Success', 
      content: { 'application/json': { schema: z.array(EcosystemProtocolSchema) } } 
    }
  }
});

ecosystemModule.openapi(getProtocolsRoute, async (c) => {
  const db = c.get('prisma');
  const protocols = await db.crisisProtocol.findMany({
    where: { isActive: true },
    include: { 
        resolutions: { 
            orderBy: { orderIndex: 'asc' } 
        } 
    }
  });

  return c.json(protocols, 200);
});

// POST /v1/system/ecosystem/global-state
// The absolute God-Mode toggle. Allows the GM or Scrum Master to send a 'CODE_BLACK' forcing all local mobile devices to switch behaviors synchronously.
const setGlobalStateRoute = createRoute({
  method: 'post',
  path: '/global-state',
  tags: ['Ecosystem'],
  summary: 'Override the Global Macro State synchronously.',
  request: {
    body: {
      content: { 
          'application/json': { 
              schema: z.object({ stateMacro: z.string(), isActive: z.boolean() }) 
          } 
      }
    }
  },
  responses: { 
      200: { description: 'State Updated', content: { 'application/json': { schema: z.object({ success: z.boolean() }) } } } 
  }
});

ecosystemModule.openapi(setGlobalStateRoute, async (c) => {
  const { stateMacro, isActive } = c.req.valid('json');
  const db = c.get('prisma');
  
  await db.ecosystemStateOverride.upsert({
    where: { globalStateMacro: stateMacro },
    update: { isActive, activatedAt: isActive ? new Date() : null },
    create: { globalStateMacro: stateMacro, isActive, activatedAt: isActive ? new Date() : null }
  });
  
  return c.json({ success: true }, 200);
});

// GET /v1/system/ecosystem/roles
// Transmits the complex node-graph of Who can physically render Which flutter screens locally.
const getRolesRoute = createRoute({
  method: 'get',
  path: '/roles',
  tags: ['Ecosystem'],
  responses: { 
      200: { description: 'Platform Roles Array', content: { 'application/json': { schema: z.any() } } } 
  }
});

ecosystemModule.openapi(getRolesRoute, async (c) => {
  const db = c.get('prisma');
  const roles = await db.platformRole.findMany({ 
      include: { screenAccess: true } 
  });
  return c.json(roles, 200);
});
