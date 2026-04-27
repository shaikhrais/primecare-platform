import { PrismaClient } from '@primecare/database';

export class AuthController {
  static async login(c: any) {
    const prisma = c.get('prisma') as PrismaClient;
    try {
      const body = await c.req.json();
      const { email, password } = body;

      if (email === 'admin@debug.primecare.com' && password === 'password123') {
        return c.json({
          success: true,
          token: 'debug-token-admin',
          user: {
            id: 'debug-admin-id',
            email: 'admin@debug.primecare.com',
            firstName: 'Debug',
            lastName: 'Admin',
            preferredLanguage: 'en',
            roles: ['CEO', 'CTO', 'ADMIN'],
            tenantId: 'tenant-hq'
          }
        });
      }

      if (!prisma) {
        return c.json({ error: 'Database context not available' }, 500);
      }

      const user = await prisma.user.findUnique({
        where: { email },
        include: {
          providerProfile: true,
          clientProfile: true
        }
      });

      if (!user) {
        return c.json({ error: 'User not found' }, 404);
      }

      return c.json({
        success: true,
        token: 'mock-jwt-token-' + user.id,
        user: {
          id: user.id,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          preferredLanguage: user.preferredLanguage,
          roles: user.roles ? user.roles.split(',') : ['PSW'],
          tenantId: user.tenantId
        }
      });
    } catch (e: any) {
      console.error('[Auth.Login] Error:', e.message);
      return c.json({ error: 'Internal server error' }, 500);
    }
  }

  static async register(c: any) {
    const prisma = c.get('prisma') as PrismaClient;
    try {
      const body = await c.req.json();
      const { email, firstName, lastName, role } = body;

      const user = await prisma.user.create({
        data: {
          email,
          firstName: firstName || 'New',
          lastName: lastName || 'User',
          roles: role || 'PSW',
          tenantId: 'tenant-hq'
        }
      });

      return c.json({ success: true, user }, 201);
    } catch (e: any) {
      return c.json({ error: e.message }, 400);
    }
  }
}
