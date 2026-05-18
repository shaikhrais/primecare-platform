import { Hono } from 'hono'

export const billingRouter = new Hono()

billingRouter.get('/overview', async (c) => {
  return c.json({
    data: {
      pendingInvoices: 154,
      totalUnpaid: 125000.00,
      claimsInProcessing: 89,
      revenueCollectedMTD: 450000.00
    }
  })
})

billingRouter.get('/claims/recent', async (c) => {
  return c.json({
    data: [
      { id: 'C-9901', patientName: 'John Doe', amount: 1500.00, status: 'PROCESSING', date: new Date().toISOString() },
      { id: 'C-9902', patientName: 'Jane Smith', amount: 3200.00, status: 'DENIED', date: new Date().toISOString() },
      { id: 'C-9903', patientName: 'Alice Johnson', amount: 800.00, status: 'APPROVED', date: new Date().toISOString() }
    ]
  })
})
