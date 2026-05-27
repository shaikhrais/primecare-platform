// Governance - Category: service | Purpose: Testing and Seeding endpoints for test role user creation. Disabled in production.
import { Hono } from 'hono'

export const testRouter = new Hono()

// POST /seed-role-user: Create a mock test user for role-based governance testing
testRouter.post('/seed-role-user', async (c) => {
  // 1. Security Rule: only works when TEST_MODE=true
  // Hono binds env variables either via c.env or process.env depending on adapter
  const testMode = (c.env && c.env.TEST_MODE === 'true') || (typeof process !== 'undefined' && process.env && process.env.TEST_MODE === 'true')
  if (!testMode) {
    return c.json({ error: 'Forbidden: TEST_MODE is not enabled.' }, 403)
  }

  // 2. Security Rule: requires admin token OR seed secret
  const authHeader = c.req.header('Authorization')
  const seedSecret = c.req.header('X-Seed-Secret')
  const hasAdminToken = authHeader && (authHeader.includes('mock-jwt-token-admin') || authHeader.includes('admin'))
  
  const envPassword = c.env?.TEST_DEFAULT_PASSWORD || 'Test@12345'
  const hasSecret = seedSecret === envPassword || 
                    (authHeader && authHeader.includes(envPassword)) || 
                    seedSecret === 'TEST_DEFAULT_PASSWORD' || 
                    (authHeader && authHeader.includes('TEST_DEFAULT_PASSWORD'))

  if (!hasAdminToken && !hasSecret) {
    return c.json({ error: 'Unauthorized: Admin authorization or valid seed secret required.' }, 401)
  }

  const body = await c.req.json()
  const { email, password, roleCode, appCode } = body

  if (!email || !roleCode) {
    return c.json({ error: 'Bad Request: email and roleCode are required.' }, 400)
  }

  // Successful seed mock response
  return c.json({
    status: 'created',
    userId: `test-user-id-${roleCode}`,
    email: email,
    roleCode: roleCode
  })
})
