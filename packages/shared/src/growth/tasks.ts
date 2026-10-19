import {registry,GrowthPolicy,keys,integer,text,uuid,timestamp,fail,type Actor} from './contract';
export function taskActions(actor:Actor,task:{owner_id:unknown;status:unknown;escalated_at:unknown}){
 const g=(registry.permissions as Record<string,{create:boolean}>)[actor.roles];
 if(!g?.create||task.status!=='open')return [];
 if(registry.taskPolicy.managerRoles.includes(actor.roles))return [...registry.taskPolicy.managerActions.filter(a=>a!=='resolve_escalation'||task.escalated_at),...registry.taskPolicy.ownerActions];
 const staff=GrowthPolicy.staff(actor);return staff?.commands.includes('task-actions:POST')&&String(task.owner_id)===actor.id?registry.taskPolicy.ownerActions:[];
}
export function taskActionBody(v:Record<string,unknown>){
 const action=String(v.action),extra=action==='reassign'?['ownerId']:action==='reschedule'?['dueAt']:action==='priority'?['priority']:[];
 keys(v,['action','version','evidence',...extra]);
 if(![...registry.taskPolicy.managerActions,...registry.taskPolicy.ownerActions].includes(action)||!text(v.evidence,500))fail(400);
 const version=integer(v.version,2147483646);if(!version)fail(400);
 if(action==='reassign'&&!uuid(v.ownerId)||action==='priority'&&!registry.taskPolicy.priorities.includes(String(v.priority)))fail(400);
 if(action==='reschedule')timestamp(v.dueAt);
 return {...v,action,version,evidence:String(v.evidence).trim(),ownerId:v.ownerId,dueAt:v.dueAt,priority:v.priority};
}
