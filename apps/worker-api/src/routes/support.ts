import { Hono } from 'hono'

export const supportRouter = new Hono()

supportRouter.get('/tickets', async (c) => {
  return c.json({
    data: [
      { id: 'T-1000', title: 'Login Issue', status: 'OPEN', priority: 'HIGH' },
      { id: 'T-1001', title: 'Cannot access billing', status: 'IN_PROGRESS', priority: 'MEDIUM' }
    ]
  })
})

supportRouter.get('/metrics', async (c) => {
  return c.json({
    data: {
      openTickets: 12,
      resolvedToday: 45,
      averageResolutionTimeHours: 2.5
    }
  })
})
