import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /v1/activities/:role
app.openapi(createRoute({
  method: 'get',
  path: '/{role}',
  
  request: { params: z.object({ role: z.string() }) },
  responses: { 200: { description: 'Activity List', content: { 'application/json': { schema: z.any() } } }, 401: { description: 'Unauthorized' } }
}), async (c) => {
  const { role } = c.req.valid('param');
  const user = c.var.user;
  
  if (!user) return c.json({ error: 'Unauthorized' }, 401);

  // Auto-generate seeded tracking data instantly if zero records exist preventing blank matrices organically
  let items = await (c.var.prisma as any).dailyActivity.findMany({
    where: { role, userId: user.id },
    orderBy: { createdAt: 'desc' }
  });

  if (items.length === 0) {
    // Generate native default activities replacing UI hardcoded representations
    const newItems = [
      { role, userId: user.id, tenantId: (user as any).tenantId, title: 'Initialize System Matrix', description: 'Backend sync executed generating node natively.', status: 'PENDING', dueDate: new Date() },
      { role, userId: user.id, tenantId: (user as any).tenantId, title: 'Validate Database Handshake', description: 'Confirm telemetry pipeline tracking arrays seamlessly.', status: 'PENDING', dueDate: new Date() }
    ];
    await (c.var.prisma as any).dailyActivity.createMany({ data: newItems });
    items = await (c.var.prisma as any).dailyActivity.findMany({ where: { role, userId: user.id }, orderBy: { createdAt: 'desc' }  });
  }

  return c.json(items, 200);
});

// PATCH /v1/activities/:id
app.openapi(createRoute({
  method: 'patch',
  path: '/{id}',
  
  request: { 
    params: z.object({ id: z.string() }),
    body: { content: { 'application/json': { schema: z.object({ status: z.string() }) } } }
  },
  responses: { 200: { description: 'Updated', content: { 'application/json': { schema: z.any() } } }, 401: { description: 'Unauthorized' } }
}), async (c) => {
  const { id } = c.req.valid('param');
  const { status } = c.req.valid('json');
  const user = c.var.user;
  
  if (!user) return c.json({ error: 'Unauthorized' }, 401);

  const updated = await (c.var.prisma as any).dailyActivity.update({
    where: { id, userId: user.id },
    data: { status }
  });

  return c.json(updated, 200);
});


// POST /v1/activities
app.openapi(createRoute({
  method: 'post',
  path: '/',
  
  request: { 
    body: { content: { 'application/json': { schema: z.object({ title: z.string(), description: z.string(), role: z.string() }) } } }
  },
  responses: { 200: { description: 'Created', content: { 'application/json': { schema: z.any() } } }, 401: { description: 'Unauthorized' } }
}), async (c) => {
  const { title, description, role } = c.req.valid('json');
  const user = c.var.user;
  if (!user) return c.json({ error: 'Unauthorized' }, 401);

  const newTask = await (c.var.prisma as any).dailyActivity.create({
    data: { role, userId: user.id, tenantId: (user as any).tenantId, title, description, status: 'PENDING', dueDate: new Date() }
  });

  return c.json(newTask, 200);
});

// POST /v1/activities/dispatch
app.openapi(createRoute({
  method: 'post',
  path: '/dispatch',
  summary: 'Drag and Drop Visits Dispatch',
  request: { 
    body: { content: { 'application/json': { schema: z.object({ visitId: z.string(), providerId: z.string(), scheduledTime: z.string() }) } } }
  },
  responses: { 200: { description: 'Dispatched', content: { 'application/json': { schema: z.any() } } }, 401: { description: 'Unauthorized' } }
}), async (c) => {
  const { visitId, providerId, scheduledTime } = c.req.valid('json');
  const user = c.var.user;
  if (!user) return c.json({ error: 'Unauthorized' }, 401);

  const updatedVisit = await (c.var.prisma as any).visit.update({
    where: { id: visitId },
    data: { 
        assignedProviderId: providerId, 
        requestedStartAt: new Date(scheduledTime),
        status: 'scheduled'
    }
  });

  return c.json(updatedVisit, 200);
});

export default app;
