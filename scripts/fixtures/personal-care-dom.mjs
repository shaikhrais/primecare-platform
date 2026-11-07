import {fixture as careFixture, deferred, invalidate, m} from './care-live-dom.mjs';
import {seedPersonal} from '../../packages/shared/src/psw-personal/core.mjs';
export {deferred,invalidate,m};
export function fixture(options={}){
 const f=careFixture({query:'?experience=personal&dataset=live&tenant=fixture-tenant&enable-semantics=true',...options});
 f.info.identity.role='psw';
 f.personal={dataset:'live',personalWorkspace:true,workspaceKey:'fixture-personal',database:'PostgreSQL',synthetic:false,version:7,state:seedPersonal(),profile:{name:'Fixture Worker',role:'psw',qualified:true},team:[],windows:[],identity:{userId:'fixture-worker',role:'psw',tenantId:'fixture-tenant',organization:'Fixture tenant'},from:'2026-10-26',today:'2026-10-28'};
 f.personal.state.visits.forEach((v,i)=>v.caseId='case-'+i);
 f.respond=async(url,o)=>Response.json(url.includes('/personal')?(o.method==='POST'?{...f.personal,version:f.personal.version+1}:f.personal):url.includes('/workspace')?f.info:o.method==='POST'?{id:'saved-record',version:1}:f.care);
 f.dialog=()=>f.doc.querySelector('dialog');f.control=cy=>f.doc.querySelector('[data-cy="'+cy+'"]');
 return f;
}
