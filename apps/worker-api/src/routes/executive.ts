import { Hono } from 'hono'
import { successResponse } from '../utils/apiUtils'

export const executiveRouter = new Hono()

// CFO Route
executiveRouter.get('/cfo/metrics', async (c) => {
  return c.json(successResponse({
    ebitda: 1200000.00,
    cashFlow: 350000.00,
    revenueGrowthYOY: 14.5,
    profitMargin: 22.4
  }, 'CFO Metrics Retrieved Successfully'))
})

// COO Route
executiveRouter.get('/coo/metrics', async (c) => {
  return c.json(successResponse({
    activeFacilities: 45,
    overallUtilizationRate: 88.2,
    criticalIncidents: 2,
    staffingFulfillment: 94.5
  }, 'COO Metrics Retrieved Successfully'))
})

// CISO Route
executiveRouter.get('/ciso/metrics', async (c) => {
  return c.json(successResponse({
    activeThreats: 0,
    complianceScore: 99.8,
    vulnerabilitiesPatched: 124,
    failedLoginAttempts: 45
  }, 'CISO Metrics Retrieved Successfully'))
})
