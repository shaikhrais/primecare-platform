import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { PrismaClient } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';

const dashboardRouter = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const KpiSchema = z.object({
  title: z.string(),
  value: z.string(),
  subtitle: z.string().optional(),
  trend: z.string().optional(),
  status: z.enum(['success', 'warning', 'danger', 'info']).default('info'),
});

const AuditLogSchema = z.object({
  title: z.string(),
  subtitle: z.string(),
  timestamp: z.string(),
  icon: z.string(),
  color: z.string(),
});

const DashboardMetricsSchema = z.object({
  kpis: z.array(KpiSchema),
  recentActivity: z.array(AuditLogSchema),
});

const getMetricsRoute = createRoute({
  method: 'get',
  path: '/metrics',
  responses: {
    200: {
      content: { 'application/json': { schema: DashboardMetricsSchema } },
      description: 'Role-specific dashboard metrics',
    },
  },
});

dashboardRouter.openapi(getMetricsRoute, async (c) => {
  const prisma = new PrismaClient({ datasourceUrl: c.env.DATABASE_URL as string }).$extends(withAccelerate());
  const userRole = c.get('user')?.role || 'guest';
  const tenantId = c.get('jwtPayload')?.tenantId;

  // Generic Mock Logic (can be expanded with role-specific DB queries)
  let kpis: z.infer<typeof KpiSchema>[] = [
      { title: 'System Uptime', value: '99.9%', subtitle: 'Stable', status: 'success' },
      { title: 'Active Users', value: '1,242', subtitle: 'Globally', status: 'info' },
      { title: 'Open Tickets', value: '14', subtitle: 'Queue: Low', status: 'warning' },
      { title: 'API Latency', value: '42ms', subtitle: 'Edge Optimised', status: 'success' },
  ];

  if (userRole.includes('admin') || userRole === 'ceo' || userRole === 'cto' || userRole === 'coo' || userRole === 'scrum_master') {
    const userCount = await prisma.user.count({ where: { tenantId } });
    kpis = [
      { title: 'Total Revenue', value: '$14.2M', subtitle: '+12% vs last month', status: 'success' },
      { title: 'Global Uptime', value: '99.9%', subtitle: 'Node Cluster: OK', status: 'success' },
      { title: 'Total Staff', value: userCount.toString(), subtitle: 'Across all regions', status: 'info' },
      { title: 'Security Score', value: '98/100', subtitle: 'A+ Federated', status: 'success' },
    ];
    if (userRole === 'ceo') {
        kpis[0] = { title: 'Net Profit Margin', value: '18.4%', subtitle: 'Target: 17.5%', status: 'success' };
    }
  } else if (userRole === 'compliance_manager' || userRole === 'training_director' || userRole === 'training_coordinator') {
    kpis = [
      { title: 'Audit Readiness', value: '98%', subtitle: 'High Compliance', status: 'success' },
      { title: 'Incident Reports', value: '2', subtitle: 'Pending Review', status: 'warning' },
      { title: 'Training Rate', value: '92%', subtitle: 'Across all staff', status: 'info' },
      { title: 'Certifications', value: '142', subtitle: 'Active Regulated', status: 'success' },
    ];
  } else if (userRole === 'franchise_owner' || userRole === 'operations_manager' || userRole.includes('gm')) {
    kpis = [
      { title: 'Net Profit', value: '$840K', subtitle: 'Q3 Aggregated', status: 'success' },
      { title: 'Staff Retention', value: '94%', subtitle: 'Top Tier', status: 'success' },
      { title: 'Client Growth', value: '+12%', subtitle: 'MoM Referral', status: 'info' },
      { title: 'Ops Score', value: '92/100', subtitle: 'Efficiency High', status: 'success' },
    ];
  } else if (userRole === 'scheduler') {
    kpis = [
      { title: 'Shift Coverage', value: '99.2%', subtitle: 'Target: 100%', status: 'success' },
      { title: 'Unassigned', value: '4', subtitle: 'Urgent Action', status: 'warning' },
      { title: 'Travel Costs', value: '$1.2K', subtitle: 'Optimization: High', status: 'info' },
      { title: 'Urgent Fills', value: '12', subtitle: 'Last 24h', status: 'info' },
    ];
  } else if (userRole.includes('client') || userRole.includes('family')) {
    kpis = [
      { title: 'Next Visit', value: 'Today @ 14:00', subtitle: 'RN Arthur Dent', status: 'success' },
      { title: 'Care Progress', value: 'On Track', subtitle: 'Stage 2 Healing', status: 'success' },
      { title: 'Medication', value: '4 Prescribed', subtitle: 'Refills: OK', status: 'info' },
      { title: 'Vitals Status', value: 'Stable', subtitle: 'Pulse: 72 bpm', status: 'success' },
    ];
  } else if (userRole.includes('finance') || userRole === 'cfo' || userRole === 'billing_admin') {
    kpis = [
      { title: 'EBITDA Margin', value: '24.2%', subtitle: 'Target: 22%', status: 'success' },
      { title: 'Payroll Due', value: '$2.4M', subtitle: 'Process in 2d', status: 'warning' },
      { title: 'Accounts Recv', value: '$4.1M', subtitle: '34 Overdue', status: 'danger' },
      { title: 'Liquidity', value: 'High', subtitle: 'Cash: $6.1M', status: 'success' },
    ];
  } else if (userRole === 'head_of_marketing') {
    kpis = [
      { title: 'Total Marketing ROI', value: '5.2x', subtitle: 'Global Aggregated', status: 'success' },
      { title: 'Brand Sentiment', value: '92/100', subtitle: 'Positive (Twitter/FB)', status: 'success' },
      { title: 'Campaign Engagement', value: '42K', subtitle: 'Reach: 1.2M', status: 'info' },
      { title: 'Share of Voice', value: '24%', subtitle: 'Competitor Avg: 18%', status: 'success' },
    ];
  } else if (userRole.includes('marketing') || userRole.includes('community')) {
    kpis = [
      { title: 'Active Campaigns', value: '8', subtitle: '4 Local, 4 Regional', status: 'info' },
      { title: 'Local Engagement', value: '1,421', subtitle: 'Last 7 Days', status: 'success' },
      { title: 'Lead Quality', value: 'High', subtitle: '84% Qualification', status: 'success' },
      { title: 'Budget Util.', value: '62%', subtitle: 'Stable Pace', status: 'info' },
    ];
  } else if (userRole.includes('sales') || userRole.includes('partnership') || userRole.includes('expansion')) {
    kpis = [
      { title: 'Active Leads', value: '142', subtitle: '8 High Priority', status: 'info' },
      { title: 'Conversion Rate', value: '18%', subtitle: 'Target: 20%', status: 'warning' },
      { title: 'New Proposals', value: '7', subtitle: 'Awaiting signature', status: 'info' },
      { title: 'Pipeline Value', value: '$1.4M', subtitle: 'Q3 Forecast', status: 'success' },
    ];
    if (userRole.includes('expansion')) {
        kpis[0] = { title: 'Total Territories', value: '24', subtitle: '6 in Pipeline', status: 'info' };
        kpis[1] = { title: 'Market Score', value: '82%', subtitle: 'High Readiness', status: 'success' };
        kpis[3] = { title: 'Pipeline Value', value: '$12.4M', subtitle: 'Expansion ROI', status: 'success' };
    }
  } else if (userRole.includes('support') || userRole.includes('hr')) {
    kpis = [
      { title: 'Ticket Queue', value: '12', subtitle: '4 Urgent', status: 'warning' },
      { title: 'Resolution Time', value: '2.4h', subtitle: 'Avg response: 15m', status: 'success' },
      { title: 'Pending Onboard', value: '8', subtitle: 'RN/PSW check', status: 'info' },
      { title: 'System Health', value: '99%', subtitle: 'Stable', status: 'success' },
    ];
  } else if (userRole.includes('rn') || userRole.includes('psw') || userRole.includes('clinical') || userRole.includes('rpn') || userRole.includes('therapist')) {
    kpis = [
      { title: 'Active Patients', value: '18', subtitle: 'High compliance', status: 'success' },
      { title: 'Meds Pending', value: '4', subtitle: 'Urgent', status: 'warning' },
      { title: 'Task Completion', value: '92%', subtitle: 'Goal: 95%', status: 'info' },
      { title: 'Incident Logs', value: '0', subtitle: 'Safe env', status: 'success' },
    ];
  }

  const recentActivity = [
    { title: 'Platform Audit', subtitle: 'System integrity verified', timestamp: '12m ago', icon: 'verified', color: 'teal' },
    { title: 'Role Sync', subtitle: 'Registry mapping updated', timestamp: '2h ago', icon: 'lock', color: 'indigo' },
    { title: 'Auto-Backup', subtitle: 'R2 bucket sync success', timestamp: '5h ago', icon: 'cloud_done', color: 'blueGrey' },
  ];

  return c.json({ kpis, recentActivity });
});

export default dashboardRouter;
