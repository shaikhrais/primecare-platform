import type {Actor} from '../../../../packages/shared/src/communications/service-base.ts';
import {VoiceTaskBase} from './voice-tasks.ts';
export type CallbackRequest={reason:'appointment_help'|'general';windowStartsAt:string;windowEndsAt:string};
export type BookingRequest={serviceId:string;slotId:string;slotVersion:number;startsAt:string};
export type RescheduleRequest={appointmentId:string;expectedVersion:number;slotId:string;slotVersion:number;startsAt:string};
/** Bind to registered existing request services. Each write must independently
 * resolve the current native actor and enforce ownership, availability, expected
 * version, exact slot/time correspondence and stable idempotency in a transaction.
 * No user, tenant, contact number, provider URL or confirmed-booking status may
 * be taken from model arguments. No endpoint is supplied by default.
 */
export interface ReceptionAppointmentPorts {
 requestCallback(actor:Actor,input:CallbackRequest,idempotencyKey:string):Promise<void>;
 requestBooking(actor:Actor,input:BookingRequest,idempotencyKey:string):Promise<void>;
 requestReschedule(actor:Actor,input:RescheduleRequest,idempotencyKey:string):Promise<void>;
}
function exact(args:unknown,keys:string[]):Record<string,unknown>{
 if(!args||typeof args!=='object'||Array.isArray(args)||Object.keys(args).sort().join(',')!==[...keys].sort().join(','))throw Error('Invalid reception task');
 return args as Record<string,unknown>;
}
function id(value:unknown):asserts value is string {if(typeof value!=='string'||! /^[A-Za-z0-9][A-Za-z0-9_-]{0,99}$/.test(value))throw Error('Invalid record reference');}
function version(value:unknown):asserts value is number {if(!Number.isSafeInteger(value)||Number(value)<1||Number(value)>=Number.MAX_SAFE_INTEGER)throw Error('Expected version required');}
function instant(value:unknown):asserts value is string {if(typeof value!=='string'||! /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$/.test(value)||!Number.isFinite(Date.parse(value))||new Date(value).toISOString()!==value||Date.parse(value)<=Date.now())throw Error('Future UTC time required');}
export function validateCallbackRequest(input:unknown):CallbackRequest{const a=exact(input,['reason','windowStartsAt','windowEndsAt']);if(a.reason!=='appointment_help'&&a.reason!=='general')throw Error('Invalid callback reason');instant(a.windowStartsAt);instant(a.windowEndsAt);if(a.windowStartsAt>=a.windowEndsAt)throw Error('Invalid callback window');return {reason:a.reason,windowStartsAt:a.windowStartsAt,windowEndsAt:a.windowEndsAt};}
export class ReceptionCallbackTask extends VoiceTaskBase {
 readonly api:ReceptionAppointmentPorts['requestCallback'];
 constructor(api:ReceptionAppointmentPorts['requestCallback']){super('reception.callback.request',1);if(typeof api!=='function')throw Error('Callback API required');this.api=api;}
 validate(input:unknown):CallbackRequest{return validateCallbackRequest(input);}
 describe(args:Record<string,unknown>){const a=this.validate(args);return `Request a receptionist callback for ${a.reason==='appointment_help'?'appointment help':'a general enquiry'} between ${a.windowStartsAt} and ${a.windowEndsAt} (UTC), using your account contact details.`;}
 async execute(actor:Actor,args:Record<string,unknown>,key:string){const a=this.validate(args);await this.api(actor,a,key);}
}
export class AppointmentBookingTask extends VoiceTaskBase {
 readonly api:ReceptionAppointmentPorts['requestBooking'];
 constructor(api:ReceptionAppointmentPorts['requestBooking']){super('appointment.booking.request',1);if(typeof api!=='function')throw Error('Booking request API required');this.api=api;}
 validate(input:unknown){const a=exact(input,['serviceId','slotId','slotVersion','startsAt']);id(a.serviceId);id(a.slotId);version(a.slotVersion);instant(a.startsAt);return {serviceId:a.serviceId,slotId:a.slotId,slotVersion:a.slotVersion,startsAt:a.startsAt};}
 describe(args:Record<string,unknown>){const a=this.validate(args);return `Request an appointment for service ${a.serviceId}, slot ${a.slotId} at ${a.startsAt} (UTC), availability version ${a.slotVersion}. This is a booking request, subject to availability.`;}
 async execute(actor:Actor,args:Record<string,unknown>,key:string){const a=this.validate(args);await this.api(actor,a,key);}
}
export class AppointmentRescheduleTask extends VoiceTaskBase {
 readonly api:ReceptionAppointmentPorts['requestReschedule'];
 constructor(api:ReceptionAppointmentPorts['requestReschedule']){super('appointment.reschedule.request',1);if(typeof api!=='function')throw Error('Reschedule request API required');this.api=api;}
 validate(input:unknown){const a=exact(input,['appointmentId','expectedVersion','slotId','slotVersion','startsAt']);id(a.appointmentId);id(a.slotId);version(a.expectedVersion);version(a.slotVersion);instant(a.startsAt);return {appointmentId:a.appointmentId,expectedVersion:a.expectedVersion,slotId:a.slotId,slotVersion:a.slotVersion,startsAt:a.startsAt};}
 describe(args:Record<string,unknown>){const a=this.validate(args);return `Request moving your appointment ${a.appointmentId}, current version ${a.expectedVersion}, to slot ${a.slotId} at ${a.startsAt} (UTC), availability version ${a.slotVersion}. This is a reschedule request, subject to availability.`;}
 async execute(actor:Actor,args:Record<string,unknown>,key:string){const a=this.validate(args);await this.api(actor,a,key);}
}
export function createReceptionAppointmentTasks(ports:ReceptionAppointmentPorts){
 if(!ports||['requestCallback','requestBooking','requestReschedule'].some(key=>typeof (ports as any)[key]!=='function'))throw Error('Registered reception API bindings required');
 return Object.freeze([new ReceptionCallbackTask(ports.requestCallback.bind(ports)),new AppointmentBookingTask(ports.requestBooking.bind(ports)),new AppointmentRescheduleTask(ports.requestReschedule.bind(ports))]);
}
