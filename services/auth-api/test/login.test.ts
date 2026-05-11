import { describe, it, expect, vi } from 'vitest';
import { Hono } from 'hono';
import loginRoute from '../src/auth/routes/login';

// Mock password hasher and other utilities used by login-handlers
vi.mock('@primecare/infrastructure', async () => {
    const actual: any = await vi.importActual('@primecare/infrastructure');
    return {
        ...actual,
        comparePassword: vi.fn(async (pw, hash) => pw === 'admin123' && hash === 'hashed_admin123'),
        isLegacyHash: vi.fn(() => false),
        logAudit: vi.fn(),
        authRateLimit: async (c: any, next: any) => await next()
    };
});

describe('Login Endpoint Factory Tests', () => {
    it('Should successfully authenticate with valid credentials', async () => {
        const app = new Hono();
        
        // Setup middleware to inject Prisma & Environment
        app.use('*', async (c, next) => {
            c.env = { JWT_SECRET: 'test_secret' };
            c.set('prisma', {
                user: {
                    findUnique: vi.fn().mockResolvedValue({
                        id: 'user_1',
                        email: 'itpro.mohammed@gmail.com',
                        passwordHash: 'hashed_admin123',
                        tenantId: 'system',
                        roles: ['super_admin'],
                        status: 'active'
                    })
                }
            });
            await next();
        });

        // Mount the router
        app.route('/v1/auth', loginRoute);

        const res = await app.request('/v1/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({
                email: 'itpro.mohammed@gmail.com',
                password: 'admin123'
            })
        });

        expect(res.status).toBe(200);
        const data = await res.json();
        expect(data).toHaveProperty('token');
        expect(data.user.email).toBe('itpro.mohammed@gmail.com');
    });

    it('Should return 401 with invalid credentials', async () => {
        const app = new Hono();
        
        // Setup middleware with missing user
        app.use('*', async (c, next) => {
            c.env = { JWT_SECRET: 'test_secret' };
            c.set('prisma', {
                user: {
                    findUnique: vi.fn().mockResolvedValue(null)
                }
            });
            await next();
        });

        app.route('/v1/auth', loginRoute);

        const res = await app.request('/v1/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: JSON.stringify({
                email: 'notfound@primecare.ca',
                password: 'wrongpassword'
            })
        });

        expect(res.status).toBe(401);
        const data = await res.json();
        expect(data.error).toBe('Invalid credentials');
    });
});
