import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { matchOverrideRoute, waitlistSyncRoute, sosAckRoute, homeStatsRoute, dispatchMapRoute, matchingEngineRoute, listSosRoute, sosDispatchRoute, masterScheduleRoute, shiftBroadcastRoute, fleetPingRoute } from './coordinator-route-defs';
import { handleSosDispatch, handleMasterSchedule, handleShiftBroadcast, handleMatchOverride, handleWaitlistSync, handleSosAck, handleListSos, handleHomeStats, handleDispatchMap, handleMatchingEngine, handleFleetPing } from './coordinator-handlers';

const coordinator = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

coordinator.openapi(sosDispatchRoute as any, handleSosDispatch);
coordinator.openapi(masterScheduleRoute as any, handleMasterSchedule);
coordinator.openapi(shiftBroadcastRoute as any, handleShiftBroadcast);
coordinator.openapi(matchOverrideRoute as any, handleMatchOverride);
coordinator.openapi(waitlistSyncRoute as any, handleWaitlistSync);
coordinator.openapi(sosAckRoute as any, handleSosAck);
coordinator.openapi(listSosRoute as any, handleListSos);
coordinator.openapi(homeStatsRoute as any, handleHomeStats);
coordinator.openapi(dispatchMapRoute as any, handleDispatchMap);
coordinator.openapi(matchingEngineRoute as any, handleMatchingEngine);
coordinator.openapi(fleetPingRoute as any, handleFleetPing);

export default coordinator;
