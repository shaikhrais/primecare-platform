import {registry,keys,integer,timestamp,text,fail} from './contract';

export function capacityBody(v:Record<string,unknown>,now=Date.now()){
 keys(v,['version','briefVersion','clientSlots','expiresAt','evidence']);
 const version=integer(v.version,2147483646),briefVersion=integer(v.briefVersion,2147483646),clientSlots=integer(v.clientSlots,registry.capacityPolicy.maxSlots),expiresAt=timestamp(v.expiresAt)!;
 if(!briefVersion||!text(v.evidence,500)||Date.parse(expiresAt)<=now||Date.parse(expiresAt)>now+registry.capacityPolicy.maxDays*86400000)fail(400);
 return {version,briefVersion,clientSlots,expiresAt,evidence:String(v.evidence).trim()};
}

export function campaignReadiness(campaign:any,brief:any,capacity:any,schemaReady:boolean,canManage:boolean,now=Date.now()){
 const approved=brief?.status==='approved'&&brief?.ownerApproved===true,applicable=brief?.pipeline!=='tenant';
 const schedule=!!brief&&Date.parse(brief.end+'T23:59:59.999Z')>=now;
 const current=!!(schemaReady&&approved&&capacity&&capacity.actor_active&&registry.capacityPolicy.roles.includes(capacity.actor_role)&&Number(capacity.brief_version)===Number(brief.version)&&capacity.client_slots>0&&new Date(capacity.expires_at).getTime()>now);
 const gates=[{key:'brief',ok:approved},{key:'budget',ok:BigInt(String(campaign.budget_cents))>BigInt(String(campaign.spend_cents??0))},{key:'schedule',ok:schedule},{key:'capacity',applicable,ok:!applicable||current},{key:'provider',ok:false}];
 return {gates,capacity:capacity?{version:capacity.version,briefVersion:capacity.brief_version,clientSlots:capacity.client_slots,expiresAt:capacity.expires_at,actorId:capacity.actor_id}:null,schemaReady,canConfirm:schemaReady&&canManage&&approved&&applicable&&schedule,readyForProviderSetup:gates.slice(0,-1).every(g=>g.ok),canLaunch:false};
}
