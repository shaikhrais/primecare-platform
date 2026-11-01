import {bindReadPage,type ReadPageSession} from './dashboard-pages';
import type {RecordPageProjection} from '../../shared/src/dashboard-pages/record-pages.mjs';
/** Read-only bounded records. Host owns transport, search input and authenticated session lifecycle. */
export function renderRecordPage(root:HTMLElement,projection:RecordPageProjection,labels:Record<string,string>){
 const label=(key:string)=>{const value=labels[key];if(!value?.trim())throw Error('missing_label');return value;};
 const doc=root.ownerDocument,section=doc.createElement('section'),title=doc.createElement('h2'),status=doc.createElement('p');
 section.dataset.cy='dashboard-pages-'+projection.kind;title.textContent=label(projection.kind);
 status.setAttribute('role',projection.status==='denied'?'alert':'status');status.textContent=label(projection.status);section.append(title,status);
 if(projection.status!=='denied'){
  const dataset=doc.createElement('p'),bounded=doc.createElement('p'),list=doc.createElement('ul');
  dataset.textContent=label(projection.synthetic?'demo':'live');bounded.textContent=label('bounded');section.append(dataset,bounded);
  for(const row of projection.rows){const item=doc.createElement('li'),name=doc.createElement('strong'),detail=doc.createElement('p');name.textContent=row.title;detail.textContent=row.detail;item.append(name,detail);list.append(item);}
  section.append(list);
 }
 root.replaceChildren(section);return ()=>{if(section.parentNode===root)section.remove();};
}

export function bindRecordPage(root:HTMLElement,session:ReadPageSession<RecordPageProjection>,labels:Record<string,string>){
 return bindReadPage(root,session,projection=>{renderRecordPage(root,projection,labels);},labels);
}
