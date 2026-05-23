// Governance - Category: middleware | Purpose: Core implementation file for the Clinical platform logic.
import { Hono } from 'hono'

export const clinicalRouter = new Hono()

clinicalRouter.get('/metrics/:officeId', async (c) => {
  const officeId = c.req.param('officeId')
  
  return c.json({
    data: {
      officeId,
      patientCount: 350,
      averageWaitTimeMins: 14.5,
      criticalIncidents: 0
    }
  })
})

clinicalRouter.get('/patients/:officeId', async (c) => {
  const officeId = c.req.param('officeId')
  
  return c.json({
    data: [
      { id: '101', name: 'John Doe', status: 'STABLE', lastVisit: new Date().toISOString() },
      { id: '102', name: 'Jane Smith', status: 'CRITICAL', lastVisit: new Date().toISOString() }
    ]
  })
})
