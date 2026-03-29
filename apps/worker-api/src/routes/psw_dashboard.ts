import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';


const pswDashboardRouter = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Timesheets
pswDashboardRouter.openapi({
  method: 'get',
  path: '/timesheets/:userId',
  responses: { 200: { description: 'Timesheets' } }
}, async (c) => {
  const prisma = new PrismaClient({ datasourceUrl: c.env.DATABASE_URL as string }).$extends(withAccelerate());
  const userId = c.req.param('userId');
  try {
    const timesheets = await prisma.timesheet.findMany({
      where: { psw: { userId } },
      include: { items: true },
      orderBy: { createdAt: "desc" },
      take: 5,
    });
    return c.json({ success: true, data: timesheets });
  } catch (error) {
    return c.json({ success: false, error: (error as Error).message }, 500);
  }
});

// Earnings
pswDashboardRouter.openapi({
  method: 'get',
  path: '/earnings/:userId',
  responses: { 200: { description: 'Earnings' } }
}, async (c) => {
  const prisma = new PrismaClient({ datasourceUrl: c.env.DATABASE_URL as string }).$extends(withAccelerate());
  const userId = c.req.param('userId');
  try {
    const payouts = await prisma.payout.findMany({
      where: { psw: { userId } },
      orderBy: { createdAt: "desc" },
      take: 10,
    });
    return c.json({ success: true, data: payouts });
  } catch (error) {
    return c.json({ success: false, error: (error as Error).message }, 500);
  }
});

// Inbox
pswDashboardRouter.openapi({
  method: 'get',
  path: '/inbox/:userId',
  responses: { 200: { description: 'Inbox' } }
}, async (c) => {
  const prisma = new PrismaClient({ datasourceUrl: c.env.DATABASE_URL as string }).$extends(withAccelerate());
  const userId = c.req.param('userId');
  try {
    const threads = await prisma.messageThread.findMany({
      where: { OR: [{ psw: { userId } }] },
      include: { messages: { orderBy: { createdAt: "desc" }, take: 1 } },
      take: 20,
    });
    return c.json({ success: true, data: threads });
  } catch (error) {
    return c.json({ success: false, error: (error as Error).message }, 500);
  }
});

// Tasks (My List)
pswDashboardRouter.openapi({
  method: 'get',
  path: '/tasks/:userId',
  responses: { 200: { description: 'Tasks' } }
}, async (c) => {
  const prisma = new PrismaClient({ datasourceUrl: c.env.DATABASE_URL as string }).$extends(withAccelerate());
  const userId = c.req.param('userId');
  try {
    const tasks = await prisma.staffTask.findMany({
      where: { assigneeId: userId },
      orderBy: { dueDate: "asc" },
      take: 20,
    });
    return c.json({ success: true, data: tasks });
  } catch (error) {
    return c.json({ success: false, error: (error as Error).message }, 500);
  }
});

export default pswDashboardRouter;
