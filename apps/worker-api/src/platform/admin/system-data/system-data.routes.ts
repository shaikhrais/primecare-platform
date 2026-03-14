import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { iotEventsRoute, gamificationRoute, notificationsRoute, aiInferencesRoute, communicationLogsRoute, handleIoTEvents, handleGamification, handleNotifications, handleAIInferences, handleCommunicationLogs } from './system-data-defs';

export const systemDataRoutes = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

systemDataRoutes.openapi(iotEventsRoute, handleIoTEvents);
systemDataRoutes.openapi(gamificationRoute, handleGamification);
systemDataRoutes.openapi(notificationsRoute, handleNotifications);
systemDataRoutes.openapi(aiInferencesRoute, handleAIInferences);
systemDataRoutes.openapi(communicationLogsRoute, handleCommunicationLogs);
