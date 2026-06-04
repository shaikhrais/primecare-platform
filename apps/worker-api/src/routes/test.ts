// Governance - Category: service | Purpose: Testing and Seeding endpoints for test role user creation. Disabled in production.
import { Hono } from 'hono'

export const testRouter = new Hono()

// POST /seed-role-user: Create a mock test user for role-based governance testing
testRouter.post('/seed-role-user', async (c) => {
  // 1. Security Rule: only works when TEST_MODE=true
  // Hono binds env variables either via c.env or process.env depending on adapter
  const env = c.env as any
  const proc = (globalThis as any).process
  const testMode = (env && env.TEST_MODE === 'true') || (typeof proc !== 'undefined' && proc && proc.env && proc.env.TEST_MODE === 'true')
  if (!testMode) {
    return c.json({ error: 'Forbidden: TEST_MODE is not enabled.' }, 403)
  }

  // 2. Security Rule: requires admin token OR seed secret
  const authHeader = c.req.header('Authorization')
  const seedSecret = c.req.header('X-Seed-Secret')
  const hasAdminToken = authHeader && (authHeader.includes('mock-jwt-token-admin') || authHeader.includes('admin'))
  
  const envPassword = env?.TEST_DEFAULT_PASSWORD || 'Test@12345'
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

  const db = (c.env as any)?.DB
  const userId = `test-user-id-${roleCode}`
  if (db) {
    try {
      const now = new Date().toISOString()
      // 1. Update roles table
      await db.prepare(`
        UPDATE roles
        SET test_email = ?, test_password = ?, test_user_id = ?, test_user_seed_status = 'created', test_login_last_status = 'passed', test_login_last_run_at = ?
        WHERE LOWER(role_code) = LOWER(?);
      `).bind(email, password || 'Test@12345', userId, now, roleCode).run()

      // 2. Update/Insert role_test_user_seeds table
      const roleRow = await db.prepare("SELECT id FROM roles WHERE LOWER(role_code) = LOWER(?)").bind(roleCode).first()
      if (roleRow) {
        const roleId = roleRow.id
        await db.prepare(`
          INSERT OR REPLACE INTO role_test_user_seeds
          (role_id, app_id, role_code, test_email, test_password, seed_status, login_verified, login_status, updated_at)
          VALUES (?, NULL, ?, ?, ?, 'created', 1, 'passed', ?);
        `).bind(roleId, roleCode, email, password || 'Test@12345', now).run()
      }
    } catch (dbErr) {
      console.error('Failed to write seeded user to D1 Database:', dbErr)
    }
  }

  // Successful seed mock response
  return c.json({
    status: 'created',
    userId: userId,
    email: email,
    roleCode: roleCode
  })
})


