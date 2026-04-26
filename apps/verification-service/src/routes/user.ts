import { UserService } from '@primecare/infrastructure';

export function registerUserRoutes(app: any) {
    const userService = new UserService();

    /**
     * POST/PATCH /v1/user/preferences
     * Updates user preferences (e.g. language).
     */
    const updatePreferences = async (c: any) => {
        try {
            const body = await c.req.json();
            const language = body.preferredLanguage || body.language;
            
            if (!language) {
                return c.json({ error: 'Language is required' }, 400);
            }

            // In a real app, we get userId from auth context
            const user = c.get('user') as any;
            const userId = user?.id || body.userId;
            
            if (!userId) {
                // If still missing, check by email
                if (body.email) {
                   const prisma = c.get('prisma');
                   const foundUser = await prisma.user.findUnique({ where: { email: body.email } });
                   if (foundUser) {
                       const updated = await userService.updatePreferredLanguage(prisma, foundUser.id, language);
                       return c.json({
                           success: true,
                           preferredLanguage: updated.preferredLanguage
                       });
                   }
                }
                return c.json({ error: 'User ID is required' }, 401);
            }

            const prisma = c.get('prisma');
            const updatedUser = await userService.updatePreferredLanguage(prisma, userId, language);

            return c.json({
                success: true,
                preferredLanguage: updatedUser.preferredLanguage
            });
        } catch (e: any) {
            console.error('[User.Preferences] Update Error:', e.message);
            return c.json({ error: 'Internal server error' }, 500);
        }
    };

    app.post('/v1/user/preferences', updatePreferences);
    app.patch('/v1/user/preferences', updatePreferences);

    /**
     * GET /v1/user/preferences
     * Retrieves user preferences.
     */
    app.get('/v1/user/preferences', async (c: any) => {
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

            return c.json({
                success: true,
                preferredLanguage: dbUser.preferredLanguage
            });
        } catch (e: any) {
            console.error('[User.Preferences] Get Error:', e.message);
            return c.json({ error: 'Internal server error' }, 500);
        }
    });
}
