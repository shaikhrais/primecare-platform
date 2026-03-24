import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

app.openapi(createRoute({
    method: 'get',
    path: '/',
    responses: { 200: { description: 'RN Patients List', content: { 'application/json': { schema: z.any() } } } }
}), async (c) => {
    const user = c.var.user;
    if (!user) return c.json({ error: 'Unauthorized' }, 401);

    const patients = await c.var.prisma.clientProfile.findMany({
        where: { tenantId: user.tenantId },
        orderBy: { fullName: 'asc' }
    });

    return c.json(patients, 200);
});

export default app;
