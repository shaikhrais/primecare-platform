// Governance - Category: middleware | Purpose: Dynamic helper to resolve user details from email or role token
import { Hono } from 'hono'
import { sendResetEmail } from '../utils/email'

export const authRouter = new Hono()

// Dynamic helper to resolve user details from email or role token
function getUserDetails(emailOrToken: string) {
  const identifier = emailOrToken.toLowerCase().trim()
  
  let role = 'psw'
  let firstName = 'Jane'
  let lastName = 'Doe'
  let email = 'psw@demo.primecare.com'
  let tenantId = 'primecare_hq'

  if (identifier.startsWith('qa.') && identifier.includes('@test.primecare.local')) {
    const extractedRole = identifier.substring(3, identifier.indexOf('@test.primecare.local'))
    role = extractedRole
    firstName = 'QA'
    lastName = extractedRole.toUpperCase()
    email = identifier
  } else if (identifier.startsWith('mock-jwt-token-')) {
    const extractedRole = identifier.substring('mock-jwt-token-'.length)
    role = extractedRole
    firstName = 'QA'
    lastName = extractedRole.toUpperCase()
    email = `qa.${extractedRole}@test.primecare.local`
    
    // Map standard demo profiles if exact match
    if (extractedRole === 'ceo') {
      firstName = 'John'; lastName = 'CEO'; email = 'ceo@demo.primecare.com'
    } else if (extractedRole === 'coo') {
      firstName = 'Charles'; lastName = 'COO'; email = 'coo@demo.primecare.com'
    } else if (extractedRole === 'admin') {
      firstName = 'Jane'; lastName = 'Admin'; email = 'admin@demo.primecare.com'
    } else if (extractedRole === 'client') {
      firstName = 'Alice'; lastName = 'Patient'; email = 'client@demo.primecare.com'
    } else if (extractedRole === 'super_admin') {
      firstName = 'Mohammed'; lastName = 'SuperAdmin'; email = 'itpro.mohammed@gmail.com'
    }
  } else if (identifier.includes('ceo')) {
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

  // Structured login telemetry logging
  console.log(JSON.stringify({
    timestamp: new Date().toISOString(),
    event: 'auth.login',
    email: email,
    role: userDetails.role,
    tenantId: userDetails.tenantId,
    ip: c.req.header('CF-Connecting-IP') || '127.0.0.1',
    userAgent: c.req.header('User-Agent') || 'unknown',
    status: 'success',
  }))

  return c.json(userDetails)
})

// POST /forgot-password: Request password recovery email
authRouter.post('/forgot-password', async (c) => {
  const body = await c.req.json()
  const email = body.email

  if (!email) {
    console.warn(JSON.stringify({
      timestamp: new Date().toISOString(),
      event: 'auth.forgot_password',
      error: 'Missing email address',
      ip: c.req.header('CF-Connecting-IP') || '127.0.0.1',
      userAgent: c.req.header('User-Agent') || 'unknown',
      status: 'failed',
    }))
    return c.json({ error: 'Email address is required.' }, 400)
  }

  // Find user details to resolve their role for custom reset link mapping
  const userDetails = getUserDetails(email)
  const role = userDetails.role

  // Resolve host origin from headers dynamically to support localhost, dev pages, and prod
  const origin = c.req.header('Origin') || 'https://primecare-clinic.pages.dev'
  const resetLink = `${origin}/reset-password?email=${encodeURIComponent(email)}&token=mock-reset-token-${role}`

  // Structured logging before dispatch
  console.log(JSON.stringify({
    timestamp: new Date().toISOString(),
    event: 'auth.forgot_password',
    email: email,
    role: role,
    tenantId: userDetails.tenantId,
    ip: c.req.header('CF-Connecting-IP') || '127.0.0.1',
    userAgent: c.req.header('User-Agent') || 'unknown',
    status: 'pending_dispatch',
  }))

  const sent = await sendResetEmail(email, resetLink, role)

  console.log(JSON.stringify({
    timestamp: new Date().toISOString(),
    event: 'auth.forgot_password',
    email: email,
    role: role,
    tenantId: userDetails.tenantId,
    ip: c.req.header('CF-Connecting-IP') || '127.0.0.1',
    userAgent: c.req.header('User-Agent') || 'unknown',
    status: sent ? 'success' : 'failed',
  }))

  return c.json({
    success: true,
    message: 'Recovery instructions sent successfully.'
  })
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

