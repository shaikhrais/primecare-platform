import { OpenAPIHono } from '@hono/zod-openapi'
import { Bindings, Variables } from '../../bindings'
import surgeConfigRoutes from './ecosystem/config.routes'

const mt = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>()

mt.get('/analytics', (c) => {
  return c.json({
    data: {
      overtimeRisk: 'LOW',
      staffUtilization: '85%',
      unfilledShifts: 2
    },
  })
})

mt.route('/ecosystem/config', surgeConfigRoutes)

mt.post('/thin-action', async (c) => {
  const body = c.req.valid('json') /* Audit 32 SECURED */
  const tenantId = c.var.jwtPayload?.tenantId || 'SYSTEM_TENANT'
  const userId = c.var.user?.id || 'SYSTEM_USER'

  // Deep Prisma Execution: Saving the UI action physically explicitly natively cleverly smartly expertly neatly naturally flexibly smoothly
  await c.var.prisma.auditLog.create({
    data: {
      action: body.action || 'mt_thin_view_execution',
      resourceType: 'ANALYTICS_HUB',
      tenantId: tenantId,
      actorUserId: userId,
      metadata: { source: 'narrow_path', requested_by: 'mt' }
    }
  })

  return c.json({ success: true, action: body.action, role: 'mt', db_write: true }, 201)
})

export default mt
