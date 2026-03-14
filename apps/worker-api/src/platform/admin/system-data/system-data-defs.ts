/**
 * System Data Route Definitions + Handlers
 * Extracted from system-data.routes.ts
 */
import { createRoute, z } from '@hono/zod-openapi';

const IoTEventSchema = z.object({ id: z.string(), deviceId: z.string(), deviceType: z.string(), payload: z.string(), status: z.string(), userId: z.string().nullable(), createdAt: z.string() });
const GamificationProfileSchema = z.object({ id: z.string(), userId: z.string(), careCoins: z.number(), currentTier: z.string(), lifetimePoints: z.number() });
const AppNotificationSchema = z.object({ id: z.string(), userId: z.string(), title: z.string(), message: z.string(), type: z.string(), isRead: z.boolean(), link: z.string().nullable(), createdAt: z.string() });
const AIInferenceSchema = z.object({ id: z.string(), modelName: z.string(), targetId: z.string(), targetType: z.string(), confidenceScore: z.number(), predictionData: z.string(), createdAt: z.string() });
const CommunicationLogSchema = z.object({ id: z.string(), direction: z.string(), channel: z.string(), recipient: z.string().nullable(), sender: z.string().nullable(), subject: z.string().nullable(), bodyText: z.string().nullable(), status: z.string(), externalId: z.string().nullable(), createdAt: z.string() });

export const iotEventsRoute = createRoute({ method: 'get', path: '/iot-events', summary: 'Get system IoT events', tags: ['Admin', 'IoT'], responses: { 200: { description: 'Successfully fetched IoT events', content: { 'application/json': { schema: z.array(IoTEventSchema) } } } } });
export const gamificationRoute = createRoute({ method: 'get', path: '/gamification', summary: 'Get gamification profiles', tags: ['Admin', 'Gamification'], responses: { 200: { description: 'Successfully fetched Gamification Profiles', content: { 'application/json': { schema: z.array(GamificationProfileSchema) } } } } });
export const notificationsRoute = createRoute({ method: 'get', path: '/notifications', summary: 'Get app notifications', tags: ['Admin', 'Notifications'], responses: { 200: { description: 'Successfully fetched Notifications', content: { 'application/json': { schema: z.array(AppNotificationSchema) } } } } });
export const aiInferencesRoute = createRoute({ method: 'get', path: '/ai-inferences', summary: 'Get AI inferences', tags: ['Admin', 'AI'], responses: { 200: { description: 'Successfully fetched AI Inferences', content: { 'application/json': { schema: z.array(AIInferenceSchema) } } } } });
export const communicationLogsRoute = createRoute({ method: 'get', path: '/communication-logs', summary: 'Get Communication Logs', tags: ['Admin', 'Communications'], responses: { 200: { description: 'Successfully fetched Communication Logs', content: { 'application/json': { schema: z.array(CommunicationLogSchema) } } } } });

export async function handleIoTEvents(c: any) { const prisma = c.get('prisma'); const tenantId = c.req.header('x-tenant-id'); const events = await prisma.ioTEvent.findMany({ where: tenantId ? { tenantId } : undefined, orderBy: { createdAt: 'desc' }, take: 50 }); return c.json(events.map((e: any) => ({ ...e, createdAt: e.createdAt.toISOString() }))); }
export async function handleGamification(c: any) { const prisma = c.get('prisma'); const tenantId = c.req.header('x-tenant-id'); return c.json(await prisma.gamificationProfile.findMany({ where: tenantId ? { tenantId } : undefined, take: 50 }) as any); }
export async function handleNotifications(c: any) { const prisma = c.get('prisma'); const tenantId = c.req.header('x-tenant-id'); const notifs = await prisma.appNotification.findMany({ where: tenantId ? { tenantId } : undefined, orderBy: { createdAt: 'desc' }, take: 50 }); return c.json(notifs.map((n: any) => ({ ...n, createdAt: n.createdAt.toISOString() }))); }
export async function handleAIInferences(c: any) { const prisma = c.get('prisma'); const tenantId = c.req.header('x-tenant-id'); const inferences = await prisma.aIInference.findMany({ where: tenantId ? { tenantId } : undefined, orderBy: { createdAt: 'desc' }, take: 50 }); return c.json(inferences.map((i: any) => ({ ...i, createdAt: i.createdAt.toISOString() }))); }
export async function handleCommunicationLogs(c: any) { const prisma = c.get('prisma'); const tenantId = c.req.header('x-tenant-id'); const logs = await prisma.communicationLog.findMany({ where: tenantId ? { tenantId } : undefined, orderBy: { createdAt: 'desc' }, take: 50 }); return c.json(logs.map((l: any) => ({ ...l, createdAt: l.createdAt.toISOString() }))); }
