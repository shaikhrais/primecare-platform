import { Hono } from 'hono'
import { PrismaClient } from '../../generated/client'
import { withPrisma } from '../../middleware/prisma'

const screensRouter = new Hono()

screensRouter.get('/', withPrisma, async (c) => {
  const prisma = c.get('prisma') as PrismaClient
  
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
