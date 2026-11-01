import {validateDashboardResponseScope} from './projection.mjs';
function text(raw,max=500){if(typeof raw!=='string'||!raw.trim()||raw.length>max)throw Error('invalid_record');return raw;}
function rows(raw){if(!Array.isArray(raw)||raw.length>100)throw Error('invalid_records');return raw;}
/** Search filters only the bounded response. It does not imply a complete tenant-wide search. */
export function projectRecordPage(kind,raw,scope,query=''){
 if(!['activity','search'].includes(kind))throw Error('invalid_page');
 if(typeof query!=='string'||query.length>100)throw Error('invalid_query');
 validateDashboardResponseScope(raw,scope);
 const base={kind,dataset:scope.dataset,synthetic:raw.synthetic,sourceApiId:16578,bounded:true};
 const views=Array.isArray(raw.allowedViews)?raw.allowedViews:[];
 if(kind==='activity'){
  if(!views.includes('audit'))return {...base,status:'denied',rows:[]};
  const result=rows(raw.events).map(event=>{
   const title=text(event?.action,200),detail=text(event?.created_at,100);
   const date=new Date(detail);
   if(!/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{1,3})?Z$/.test(detail)||!Number.isFinite(date.getTime())||date.toISOString().slice(0,19)!==detail.slice(0,19))throw Error('invalid_record');
   return {type:'activity',title,detail};
  });
  return {...base,status:result.length?'ready':'empty',rows:result};
 }
 if(!views.includes('tasks')&&!views.includes('workflows'))return {...base,status:'denied',rows:[]};
 const result=[];
 if(views.includes('tasks'))for(const item of rows(raw.tasks))result.push({type:'task',title:text(item?.title),detail:text(item?.id,200)});
 if(views.includes('workflows'))for(const item of rows(raw.workflows))result.push({type:'workflow',title:text(item?.title),detail:text(item?.flow_id,200)});
 const search=query.toLowerCase();
 const filtered=result.filter(row=>(row.title+' '+row.detail).toLowerCase().includes(search));
 return {...base,status:filtered.length?'ready':'empty',rows:filtered};
}
