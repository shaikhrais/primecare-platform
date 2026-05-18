import { Hono } from 'hono'

export const franchiseRouter = new Hono()

franchiseRouter.get('/kpis/:officeId', async (c) => {
  const officeId = c.req.param('officeId')
  
  // Return placeholder metrics matching FranchiseKpi Prisma model
  return c.json({
    data: {
      officeId,
      totalRevenue: 250000,
      activeClients: 120,
      staffRetentionRate: 92.5,
      complianceScore: 98.0
    }
  })
})

franchiseRouter.get('/reports/:officeId', async (c) => {
  const officeId = c.req.param('officeId')
  
  return c.json({
    data: [
      { id: '1', title: 'Q1 Financial Summary', type: 'FINANCIAL', status: 'COMPLETED' },
      { id: '2', title: 'Monthly Staffing Audit', type: 'STAFFING', status: 'PENDING' }
    ]
  })
})
