import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../';
import { AdminClientService } from './clients.service';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ClientSchema = z.object({
    email: z.string().email(),
    fullName: z.string(),
    phone: z.string().optional(),
    address: z.string(),
    emergencyContact: z.string().optional(),
    medicalNotes: z.string().optional(),
});

/ List Clients
r.get('/', async (c) => {
    const prisma = c.get('prisma');
    const service = new AdminClientService(prisma);
    const clients = await service.listClients();
    return c.json(clients);
});

/ Create Client
const createClientRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Admit a new Client',
    tags: ['Admin Clients'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: ClientSchema,
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Client created successfully',
        },
    },
});

r.openapi(createClientRoute, async (c) => {
    const prisma = c.get('prisma');
    const data = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;
    const service = new AdminClientService(prisma);

    const client = await service.createClient({
        ...data,
        tenantId
    });

    return c.json(client, 201);
});

export default r;
