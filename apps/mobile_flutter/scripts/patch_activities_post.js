const fs = require('fs');
const path = require('path');
const activitiesPath = path.join(__dirname, '..', '..', 'worker-api', 'src', 'activities', 'activities.routes.ts');

let code = fs.readFileSync(activitiesPath, 'utf8');

const postRoute = `
// POST /v1/activities
app.openapi(createRoute({
  method: 'post',
  path: '/',
  middleware: [requireAuth()] as const,
  request: { 
    body: { content: { 'application/json': { schema: z.object({ title: z.string(), description: z.string(), role: z.string() }) } } }
  },
  responses: { 200: { description: 'Created', content: { 'application/json': { schema: z.any() } } } }
}), async (c) => {
  const { title, description, role } = c.req.valid('json');
  const user = c.var.user;
  if (!user) return c.json({ error: 'Unauthorized' }, 401);

  const newTask = await c.var.prisma.dailyActivity.create({
    data: { role, userId: user.id, tenantId: user.tenantId, title, description, status: 'PENDING', dueDate: new Date() }
  });

  return c.json(newTask, 200);
});

export default app;`;

code = code.replace('export default app;', postRoute);
fs.writeFileSync(activitiesPath, code);
console.log("POST route dynamically injected into Hono Worker routing tree organically.");
