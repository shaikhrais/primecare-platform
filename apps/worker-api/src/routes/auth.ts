// Governance - Category: middleware | Purpose: Dynamic helper to resolve user details from email or role token
import { Hono } from 'hono'

export const authRouter = new Hono()

// Dynamic helper to resolve user details from email or role token
function getUserDetails(emailOrToken: string) {
  const identifier = emailOrToken.toLowerCase().trim()
  
  let role = 'psw'
  let firstName = 'Jane'
  let lastName = 'Doe'
  let email = 'psw@demo.primecare.com'
  let tenantId = 'primecare_hq'

  if (identifier.includes('ceo')) {
    role = 'ceo'
    firstName = 'John'
    lastName = 'CEO'
    email = 'ceo@demo.primecare.com'
  } else if (identifier.includes('coo')) {
    role = 'coo'
    firstName = 'Charles'
    lastName = 'COO'
    email = 'coo@demo.primecare.com'
  } else if (identifier.includes('admin')) {
    role = 'admin'
    firstName = 'Jane'
    lastName = 'Admin'
    email = 'admin@demo.primecare.com'
  } else if (identifier.includes('client')) {
    role = 'client'
    firstName = 'Alice'
    lastName = 'Patient'
    email = 'client@demo.primecare.com'
  } else if (identifier.includes('mohammed') || identifier.includes('super')) {
    role = 'super_admin'
    firstName = 'Mohammed'
    lastName = 'SuperAdmin'
    email = 'itpro.mohammed@gmail.com'
  }

  return {
    token: `mock-jwt-token-${role}`,
    role: role,
    roles: role, // Root level roles mapping for _loadStoredAuth SSO
    userId: `mock-user-id-${role}`, // Root level userId mapping for _loadStoredAuth SSO
    tenantId: tenantId,
    activeRole: role,
    user: {
      id: `mock-user-id-${role}`,
      firstName: firstName,
      lastName: lastName,
      roles: [role],
      tenantId: tenantId,
      preferredLanguage: 'en',
      email: email,
    }
  }
}

// POST /login: Authenticate credentials
authRouter.post('/login', async (c) => {
  const body = await c.req.json()
  const email = body.email || 'psw@demo.primecare.com'
  
  const userDetails = getUserDetails(email)
  return c.json(userDetails)
})

// GET /me: Silent session validation (Google-Style Seamless SSO Handshake)
authRouter.get('/me', async (c) => {
  const authHeader = c.req.header('Authorization')
  
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return c.json(
      {
        status: 'error',
        message: 'Unauthorized: No active session token provided.'
      },
      401
    )
  }

  const token = authHeader.split(' ')[1]
  if (!token || !token.startsWith('mock-jwt-token-')) {
    return c.json(
      {
        status: 'error',
        message: 'Unauthorized: Invalid session token.'
      },
      401
    )
  }

  // Extract the role from the token
  const userDetails = getUserDetails(token)
  return c.json(userDetails)
})
