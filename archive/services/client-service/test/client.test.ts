import { describe, it, expect, vi } from 'vitest';
import { Hono } from 'hono';
import { Variables, Bindings } from '@primecare/contracts';
import { requireAuth } from '@primecare/security';

describe('Client Service Basic Tests', () => {
    it('should have a working mock environment', async () => {
        const app = new Hono<{ Bindings: Bindings, Variables: Variables }>();
        app.get('/', (c) => c.json({ status: 'ok' }));

        const res = await app.request('/');
        const data = await res.json();
        
        expect(res.status).toBe(200);
        expect(data).toEqual({ status: 'ok' });
    });

    it('should reject unauthorized access', async () => {
        const app = new Hono<{ Bindings: Bindings, Variables: Variables }>();
        
        app.use('*', requireAuth('secret'));
        app.get('/protected', (c) => c.json({ data: 'secret' }));

        const res = await app.request('/protected');
        // Because we haven't provided an auth interceptor or token, it should be 401
        expect(res.status).toBe(401);
    });
});
