import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';

const DashboardMetricsSchema = z.object({
  kpis: z.array(z.object({
    title: z.string(),
    value: z.string(),
    status: z.string(),
    trend: z.string(),
  })),
  recentActivity: z.array(z.object({
    title: z.string(),
    subtitle: z.string(),
    timestamp: z.string(),
    icon: z.string(),
    color: z.string(),
  })),
  charts: z.array(z.any()),
  insights: z.array(z.object({
    title: z.string(),
    description: z.string(),
    type: z.string(),
    impact: z.string(),
  })),
  isOfflineFallback: z.boolean().optional(),
});

const getDashboardMetricsRoute = createRoute({
  method: 'get',
  path: '/dashboard-metrics',
  request: {
    query: z.object({
      route: z.string(),
    }),
  },
  responses: {
    200: {
      content: {
        'application/json': {
          schema: DashboardMetricsSchema,
        },
      },
      description: 'Retrieve dashboard metrics for a specific route',
    },
  },
});

const getClinicalIntelligenceRoute = createRoute({
  method: 'get',
  path: '/clinical-intelligence',
  request: {
    query: z.object({
      route: z.string(),
    }),
  },
  responses: {
    200: {
      content: {
        'application/json': {
          schema: z.object({
            blueprints: z.array(z.any()),
          }),
        },
      },
      description: 'Retrieve clinical intelligence blueprints',
    },
  },
});

export function registerDashboardRoutes(app: OpenAPIHono<any>) {
  app.openapi(getDashboardMetricsRoute, async (c) => {
    const route = c.req.query('route');
    // For now, return real structure but we can hydrate from DB later
    return c.json({
      kpis: [
        { title: 'System Health', value: '99.9%', status: 'positive', trend: 'stable' },
        { title: 'Pending Tasks', value: '12', status: 'neutral', trend: 'down' },
      ],
      recentActivity: [
        { title: 'Deployment Success', subtitle: 'v4.0.0 released', timestamp: 'Just now', icon: 'rocket', color: 'blue' },
      ],
      charts: [],
      insights: [
        { title: 'Performance Peak', description: 'API response time is optimal.', type: 'performance', impact: 'positive' }
      ],
    });
  });

  app.openapi(getClinicalIntelligenceRoute, async (c) => {
    return c.json({
      blueprints: [
        {
          componentType: 'stat_card_grid',
          dataPayload: [
            { label: 'Patient Volume', value: 'High', status: 'WARNING' },
            { label: 'Staffing Level', value: 'Optimal', status: 'SUCCESS' },
          ],
        },
      ],
    });
  });
}
