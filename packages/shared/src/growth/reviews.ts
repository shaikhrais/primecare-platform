import registry from './registry.json';
import {GrowthPolicy,fail,integer,keys,type Actor} from './contract';
export type ReviewAction='submit'|'withdraw'|'approve'|'request_changes'|'reject';
export type ReviewState='draft'|'pending_review'|'approved'|'changes_requested'|'rejected';
export function reviewBody(v:Record<string,unknown>){
 keys(v,['action','version','evidence']);
 const version=integer(v.version,2147483647);
 if(version<1||!registry.reviewPolicy.actions.includes(String(v.action))||typeof v.evidence!=='string'||!v.evidence.trim()||v.evidence.length>1000||/[\u0000-\u0008\u000b\u000c\u000e-\u001f\u007f]/.test(v.evidence))fail(400);
 return {action:v.action as ReviewAction,version,evidence:String(v.evidence).trim()};
}
export function reviewActions(actor:Actor,owner:string,state:ReviewState):ReviewAction[]{
 const grant=(registry.permissions as Record<string,{view:boolean;create:boolean}>)[actor.roles],staff=GrowthPolicy.staff(actor);
 if(!grant?.view||!grant.create||staff&&!staff.commands.includes('reviews:POST'))return [];
 const submitter=registry.ownerPolicy.submissionRoles.includes(actor.roles),reviewer=registry.reviewPolicy.roles.includes(actor.roles),selfAllowed=owner!==actor.id||registry.reviewPolicy.selfReviewRoles.includes(actor.roles);
 if(state==='draft')return owner===actor.id||submitter?['submit']:[];
 if(state!=='pending_review')return [];
 return [...(owner===actor.id||submitter?['withdraw' as const]:[]),...(reviewer&&selfAllowed?['approve' as const,'request_changes' as const,'reject' as const]:[])];
}
export function reviewNext(action:ReviewAction):ReviewState{
 return {submit:'pending_review',withdraw:'draft',approve:'approved',request_changes:'changes_requested',reject:'rejected'}[action] as ReviewState;
}
