import {supportingPageStatus} from '../../shared/src/dashboard-pages/supporting-pages.mjs';
const kinds=['invoice','pricing','authentication','coming-soon','maintenance','error'] as const;
export type SupportingPageKind=typeof kinds[number];
/** A registered host supplies localized text; no auth, billing or service mutation. */
export function renderSupportingPage(root:HTMLElement,kind:SupportingPageKind,labels:Record<string,string>){
 if(!kinds.includes(kind))throw Error('invalid_page');
 const status=supportingPageStatus(kind);
 if(!labels[kind]?.trim()||!labels[status]?.trim())throw Error('missing_label');
 const section=root.ownerDocument.createElement('section'),title=root.ownerDocument.createElement('h2'),message=root.ownerDocument.createElement('p');
 section.dataset.cy='dashboard-pages-'+kind;title.textContent=labels[kind];message.textContent=labels[status];message.setAttribute('role','status');section.append(title,message);root.replaceChildren(section);
 return ()=>{if(section.parentNode===root)section.remove();};
}
