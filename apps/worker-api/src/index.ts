import { Hono } from 'hono'
import { cors } from 'hono/cors'

// Define the Cloudflare Environment Bindings
type Bindings = {
  DB: D1Database
  // Add other bindings here
}

const app = new Hono<{ Bindings: Bindings }>()

app.use('*', cors())

app.get('/', (c) => {
  return c.text('PrimeCare Worker API is running!')
})

app.get('/health', (c) => c.json({ status: 'ok', version: '1.0.0' }))

// Registering route modules
import { franchiseRouter } from './routes/franchise'
import { clinicalRouter } from './routes/clinical'
import { supportRouter } from './routes/support'
import { businessDevRouter } from './routes/business_dev'
import { billingRouter } from './routes/billing'
import { executiveRouter } from './routes/executive'
import { usersRouter } from './routes/users'
import { authRouter } from './routes/auth'
import { shiftsRouter } from './routes/shifts'
import { premiumRouter } from './routes/premium'

app.route('/api/v1/franchise', franchiseRouter)
app.route('/api/v1/clinical', clinicalRouter)
app.route('/api/v1/support', supportRouter)
app.route('/api/v1/business-dev', businessDevRouter)
app.route('/api/v1/billing', billingRouter)
app.route('/api/v1/executive', executiveRouter)
app.route('/api/v1/users', usersRouter)
app.route('/api/v1/auth', authRouter)
app.route('/api/v1/shifts', shiftsRouter)
app.route('/api/v1/premium', premiumRouter)

export default app
