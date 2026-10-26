import {PostgresRegisteredCommunicationEndpointPolicy} from './endpoint-policy.ts';
import {PostgresCommunicationSession} from './session.ts';
import type {Actor,RecordState,AccessPolicy} from '../../../../packages/shared/src/communications/service-base.ts';
import definition from '../../../../tools/governance-production/external-call-registration.json' with {type:'json'};
export class ExternalCallPolicy extends PostgresRegisteredCommunicationEndpointPolicy implements AccessPolicy{
 async assert(actor:Actor,action:string,state:RecordState|null){const op=definition.operations.find(o=>o.key===action);if(!op||op.authentication!=='native-session-csrf'||!state||state.tenantId!==actor.tenantId||state.ownerId!==actor.id||state.kind!=='external_call')throw Error('Forbidden');await this.authorizeRegistered(actor,null,op.method,op.path,'EXTERNAL_'+op.key.replaceAll('.','_').toUpperCase());}
 async assignee(){throw Error('Forbidden');}
}
export class ExternalCallSessions extends PostgresCommunicationSession{
 async current(hash:string){if(!/^[a-f0-9]{64}$/.test(hash))throw Error('Forbidden');const {rows}=await this.database.query("SELECT u.id::text AS id,u.tenant_id::text AS tenant_id FROM auth_sessions s JOIN users u ON u.id=s.user_id JOIN tenants t ON t.id=u.tenant_id WHERE s.token_hash=$1 AND s.expires_at>NOW() AND LOWER(u.status)='active' AND LOWER(t.status)='active' LIMIT 2",[hash]);return this.actorFromRows(rows,new Request('https://internal.invalid/'));}
}
