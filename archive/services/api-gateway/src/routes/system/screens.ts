import { Hono } from 'hono'
import { PrismaClient } from '@primecare/database'
import { Bindings, Variables } from '@primecare/shared-types'
import { prismaMiddleware } from '@primecare/infrastructure'

const screensRouter = new Hono<{ Bindings: Bindings, Variables: Variables }>()

screensRouter.get('/', prismaMiddleware(), async (c) => {
  const prisma = c.get('prisma') as any
  
  if (!prisma) {
      return c.json({ success: false, error: 'Database unavailable' }, 503)
  }

  try {
    // Fetch all active screens explicitly configured in the database
    const screens = await prisma.platformScreen.findMany({
      orderBy: { orderIndex: 'asc' },
      select: {
        name: true,
        route: true,
        status: true,
        role: {
          select: {
            name: true
          }
        }
      }
    })
    
    return c.json({
      success: true,
      data: screens
    })
  } catch (error) {
    console.error('[System.Screens] Fetch Error:', error)
    return c.json({ success: false, error: 'Failed to fetch Dynamic Routing Matrix' }, 500)
  }
})

export { screensRouter }
