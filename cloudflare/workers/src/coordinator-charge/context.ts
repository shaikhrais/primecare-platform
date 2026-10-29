import {fail,type Actor} from '../../../../packages/shared/src/care/contract';
import catalog from '../../../../packages/shared/src/coordinator-charge/catalog.json';
export type ChargeActor=Actor&{primaryRole?:string;chargeId?:string};
export async function chargeContext(db:any,actor:Actor,request:Request):Promise<ChargeActor>{
 const header=request.headers.get(catalog.header)||'';
 if(!header.startsWith('primecare:psw-coordinator'))return actor;
 const id=header.slice(catalog.headerPrefix.length);
 if(!header.startsWith(catalog.headerPrefix)||!/^[a-f0-9-]{36}$/i.test(id)||actor.roles!==catalog.primaryRole)fail(403,'Coordinator additional charge is not available for this account.');
 const row=(await db.query('SELECT id FROM psw_coordinator_charges WHERE id::text=$1 AND user_id::text=$2 AND tenant_id::text=$3 AND revoked_at IS NULL AND starts_at<=NOW() AND (ends_at IS NULL OR ends_at>NOW()) FOR SHARE',[id,actor.id,actor.tenant_id])).rows[0];
 if(!row)fail(403,'This coordinator additional charge has ended, expired or is not yet active. Return to Tenant Admin.');
 return {...actor,roles:catalog.effectiveRole,primaryRole:actor.roles,chargeId:id};
}
export async function chargeAudit(db:any,actor:ChargeActor,action:string,detail:Record<string,unknown>){
 if(!actor.chargeId)return;
 await db.query('INSERT INTO psw_coordinator_charge_events(id,tenant_id,charge_id,actor_id,primary_role,effective_role,action,detail) VALUES($1,$2,$3,$4,$5,$6,$7,$8)',[crypto.randomUUID(),actor.tenant_id,actor.chargeId,actor.id,actor.primaryRole,actor.roles,action,JSON.stringify(detail)]);
}
