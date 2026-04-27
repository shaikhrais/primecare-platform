import { UserController } from '../controllers/user.controller';

export function registerUserRoutes(app: any) {
    app.post('/v1/user/preferences', (c: any) => UserController.updatePreferences(c));
    app.patch('/v1/user/preferences', (c: any) => UserController.updatePreferences(c));
    app.get('/v1/user/preferences', (c: any) => UserController.getPreferences(c));
}
