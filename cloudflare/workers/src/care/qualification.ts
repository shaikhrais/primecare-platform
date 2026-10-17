import {clinicalRole} from '../../../../packages/shared/src/care/contract';
export function eligible(staff:any,now=new Date()){
 return !!staff&&clinicalRole(staff.roles)&&staff.profile_approved===true&&staff.induction===true&&staff.retraining===false&&staff.clearance_status==='active'&&staff.clearance_role===staff.roles&&String(staff.expires_on)>=now.toISOString().slice(0,10);
}
