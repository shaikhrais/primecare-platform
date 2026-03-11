import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const erpRoutes = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const getInventoryRoute = createRoute({
    method: 'get',
    path: '/inventory',
    summary: 'Get Supply Chain Inventory',
    description: 'Returns a ledger of all warehouse SKUs and reorder levels.',
    tags: ['Admin', 'ERP', 'Logistics'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        items: z.any()
                    }),
                },
            },
            description: 'Success',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() })
                }
            },
            description: 'Internal Server Error'
        }
    },
});

erpRoutes.openapi(getInventoryRoute, async (c) => {
    const prisma = c.get('prisma');
    try {
        const inventory = await prisma.inventoryItem.findMany({
            take: 100,
            orderBy: { name: 'asc' }
        });

        // The exact UI schema needed for SupplyChainHub
        const mappedInventory = inventory.map((item: any) => ({
            id: item.id,
            sku: item.sku,
            name: item.name,
            category: item.category,
            quantity: item.quantity,
            reorderPoint: item.reorderPoint,
            unitPrice: item.unitPrice
        }));

        return c.json({ items: mappedInventory }, 200);
    } catch (error) {
        console.error('Failed to fetch inventory:', error);
        return c.json({ error: 'Failed to fetch inventory' }, 500);
    }
});

const getPurchaseOrdersRoute = createRoute({
    method: 'get',
    path: '/purchase-orders',
    summary: 'Get ERP Purchase Orders',
    description: 'Returns active POs from suppliers.',
    tags: ['Admin', 'ERP', 'Finance'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        orders: z.any()
                    }),
                },
            },
            description: 'Success',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() })
                }
            },
            description: 'Internal Server Error'
        }
    },
});

erpRoutes.openapi(getPurchaseOrdersRoute, async (c) => {
    const prisma = c.get('prisma');
    try {
        const orders = await prisma.purchaseOrder.findMany({
            include: {
                supplier: true
            },
            take: 50,
            orderBy: { createdAt: 'desc' }
        });

        const mappedOrders = orders.map((po: any) => ({
            id: po.id,
            poNumber: po.poNumber,
            supplier: po.supplier.name,
            status: po.status,
            totalAmount: po.totalAmount,
            date: new Date(po.createdAt).toLocaleDateString()
        }));

        return c.json({ orders: mappedOrders }, 200);
    } catch (error) {
        console.error('Failed to fetch purchase orders:', error);
        return c.json({ error: 'Failed to fetch purchase orders' }, 500);
    }
});

export default erpRoutes;
