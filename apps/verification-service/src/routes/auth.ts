import { AuthController } from '../controllers/auth.controller';

export function registerAuthRoutes(app: any) {
  app.post('/v1/auth/login', (c: any) => AuthController.login(c));
  app.post('/v1/auth/register', (c: any) => AuthController.register(c));
}
