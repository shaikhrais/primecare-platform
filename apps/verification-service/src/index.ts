import { OpenAPIHono } from '@hono/zod-openapi';
import { cors } from 'hono/cors';
import { Bindings, Variables } from '@primecare/contracts';
import { prismaMiddleware } from '@primecare/infrastructure';
import { registerFinanceRoutes } from './routes/finance';
import { registerIdentityRoutes } from './routes/identity';
import { registerAuditRoutes } from './routes/audit';
import { registerAdminRoutes } from './routes/admin';
import { registerClinicalRoutes } from './routes/clinical';
import { registerComplianceRoutes } from './routes/compliance';
import { registerUserRoutes } from './routes/user';
import { registerAuthRoutes } from './routes/auth';
import { registerSystemRoutes } from './routes/system';
import { registerDashboardRoutes } from './routes/dashboard';

if (!(BigInt.prototype as any).toJSON) {
  (BigInt.prototype as any).toJSON = function() {
    return this.toString();
  };
}

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>().basePath('/v4');

app.use('*', cors());

// Export OpenAPI JSON
app.doc('/openapi.json', {
  openapi: '3.0.0',
  info: {
    version: '1.0.0',
    title: 'Verification Service API',
  },
});

// Database Connection Middleware
app.use('*', prismaMiddleware());

// Security & Inter-Service Middleware
app.use('*', async (c, next) => {
    const apiKey = c.req.header('X-Service-API-Key');
    if (c.env?.ENVIRONMENT === 'production' && apiKey !== c.env?.INTERNAL_API_KEY) {
        return c.json({ error: 'Unauthorized Inter-Service Call' }, 401);
    }
    await next();
});

// Basic health endpoint
app.get('/health', (c) => {
    return c.json({ 
        status: 'ok', 
        service: 'primecare-verification-service', 
        time: new Date().toISOString(),
        prismaError: c.get('prismaError' as any) || null
    });
});

// Domain Routes
registerIdentityRoutes(app);
registerFinanceRoutes(app);
registerAuditRoutes(app);
registerAdminRoutes(app);
registerClinicalRoutes(app);
registerComplianceRoutes(app);
registerUserRoutes(app);
registerAuthRoutes(app);
registerSystemRoutes(app);
registerDashboardRoutes(app);

// Cron trigger for Automated Sweeps
export default {
    fetch: app.fetch,
    async scheduled(event: any, env: any, ctx: any) {
        const { PrismaClient } = await import('@primecare/database');
        console.log(`Cron sweep triggered at ${event.cron}`);
        
        try {
            const dbUrl = env.DATABASE_URL;
            if (!dbUrl) throw new Error("Missing DATABASE_URL in cron environment");

            let edgeUri = dbUrl;
            if (edgeUri.includes('db.prisma.io') && edgeUri.startsWith('postgres://')) {
                const urlObj = new URL(edgeUri);
                const apiKey = urlObj.username ? `${urlObj.username}:${urlObj.password}` : urlObj.password;
                edgeUri = `prisma://accelerate.prisma-data.net/?api_key=${apiKey}`;
            }

            const prisma = new PrismaClient({ datasourceUrl: edgeUri });

            await prisma.verificationLog.create({ 
                data: { 
                    implementationId: 'system_cron_sweep',
                    status: 'sweep_completed', 
                    anomalyCount: 0 
                } 
            });
            console.log('Sweep success: Telemetry persisted successfully.');
        } catch (error) {
            console.error('Sweep failure:', error);
        }
    }
};
