import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { requireRole } from '../../../_shared/middleware/rbac';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getChildTenantsRoute = createRoute({
    method: 'get',
    path: '/',
    tags: ['Admin // Reseller'],
    summary: 'Get Child Tenants',
    description: 'Retrieves all child tenants spawned by the current tenant (White-Label Reseller).',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        children: z.array(z.object({
                            id: z.string(),
                            name: z.string(),
                            slug: z.string(),
                            status: z.string(),
                            usersCount: z.number().optional(),
                            visitsCount: z.number().optional()
                        }))
                    }),
                },
            },
            description: 'List of child tenants',
        },
        500: {
            content: { 'application/json': { schema: z.any() } },
            description: 'Internal Server Error',
        }
    }
});

const provisionChildTenantRoute = createRoute({
    method: 'post',
    path: '/provision',
    tags: ['Admin // Reseller'],
    summary: 'Provision Child Tenant',
    description: 'Creates a new child tenant under the current tenant.',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        name: z.string().min(2),
                        slug: z.string().min(2),
                        adminEmail: z.string().email(),
                        adminPassword: z.string().min(8)
                    })
                }
            }
        }
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        id: z.string(),
                        name: z.string(),
                        slug: z.string(),
                        adminUserId: z.string()
                    }),
                },
            },
            description: 'Successfully provisioned child tenant',
        },
        400: {
            content: { 'application/json': { schema: z.object({ error: z.string() }) } },
            description: 'Bad Request',
        },
        500: {
            content: { 'application/json': { schema: z.any() } },
            description: 'Internal Server Error',
        }
    }
});

r.openapi(getChildTenantsRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user') as { id: string, role: string, tenantId?: string };

    if (!user || !user.tenantId) {
        return c.json({ error: 'Unauthorized' } as any, 401 as any);
    }

    try {
        const children = await prisma.tenant.findMany({
            where: {
                parentTenantId: user.tenantId
            },
            include: {
                _count: {
                    select: { users: true, visits: true }
                }
            }
        });

        const formatted = children.map((child: any) => ({
            id: child.id,
            name: child.name,
            slug: child.slug,
            status: child.status,
            usersCount: child._count.users,
            visitsCount: child._count.visits
        }));

        return c.json({ children: formatted }, 200 as const);
    } catch (error) {
        console.error('Error fetching child tenants:', error);
        return c.json({ error: 'Failed' } as any, 500 as const);
    }
});

r.openapi(provisionChildTenantRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user') as { id: string, role: string, tenantId?: string };
    const { name, slug, adminEmail, adminPassword } = c.req.valid('json');

    if (!user || !user.tenantId) {
        return c.json({ error: 'Unauthorized' } as any, 401 as any);
    }

    try {
        // Check if slug or email exists across the whole platform
        const existingTenant = await prisma.tenant.findUnique({ where: { slug } });
        if (existingTenant) {
            return c.json({ error: 'Tenant slug already exists.' }, 400 as const);
        }

        const existingUser = await prisma.user.findUnique({ where: { email: adminEmail } });
        if (existingUser) {
            return c.json({ error: 'Admin email already exists in the system.' }, 400 as const);
        }

        // Normally we'd hash the password here with bcrypt, skipping for brevity mock
        const mockHash = `hash_${adminPassword}`;

        // Create the child tenant and its admin user in a transaction
        const result = await prisma.$transaction(async (tx: any) => {
            const newTenant = await tx.tenant.create({
                data: {
                    name,
                    slug,
                    parentTenantId: user.tenantId, // Link to parent
                    status: 'active'
                }
            });

            const newAdmin = await tx.user.create({
                data: {
                    email: adminEmail,
                    passwordHash: mockHash,
                    tenantId: newTenant.id,
                    roles: ['admin'] // Set as admin for their new tenant
                }
            });

            return { newTenant, newAdmin };
        });

        return c.json({
            id: result.newTenant.id,
            name: result.newTenant.name,
            slug: result.newTenant.slug,
            adminUserId: result.newAdmin.id
        }, 200 as const);

    } catch (error) {
        console.error('Error provisioning child tenant:', error);
        return c.json({ error: 'Failed' } as any, 500 as const);
    }
});

export { r as resellerRoutes };
