import { UserService } from '@primecare/infrastructure';

export class UserController {
  private static userService = new UserService();

  static async updatePreferences(c: any) {
    try {
      const body = await c.req.json();
      const language = body.preferredLanguage || body.language;
      
      if (!language) {
        return c.json({ error: 'Language is required' }, 400);
      }

      const user = c.get('user') as any;
      const userId = user?.id || body.userId;
      const prisma = c.get('prisma');
      
      if (!userId) {
        if (body.email) {
          const foundUser = await prisma.user.findUnique({ where: { email: body.email } });
          if (foundUser) {
            const updated = await this.userService.updatePreferredLanguage(prisma, foundUser.id, language);
            return c.json({ success: true, preferredLanguage: updated.preferredLanguage });
          }
        }
        return c.json({ error: 'User ID is required' }, 401);
      }

      const updatedUser = await this.userService.updatePreferredLanguage(prisma, userId, language);
      return c.json({ success: true, preferredLanguage: updatedUser.preferredLanguage });
    } catch (e: any) {
      console.error('[User.Preferences] Update Error:', e.message);
      return c.json({ error: 'Internal server error' }, 500);
    }
  }

  static async getPreferences(c: any) {
    try {
      const user = c.get('user') as any;
      const email = c.req.query('email');
      const prisma = c.get('prisma');
      let dbUser;

      if (user?.id) {
        dbUser = await prisma.user.findUnique({ where: { id: user.id } });
      } else if (email) {
        dbUser = await prisma.user.findUnique({ where: { email: email } });
      }

      if (!dbUser) {
        return c.json({ error: 'User not found' }, 404);
      }

      return c.json({ success: true, preferredLanguage: dbUser.preferredLanguage });
    } catch (e: any) {
      console.error('[User.Preferences] Get Error:', e.message);
      return c.json({ error: 'Internal server error' }, 500);
    }
  }
}
