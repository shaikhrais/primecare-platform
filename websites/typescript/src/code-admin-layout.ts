import {BaseMediaLook} from './media-look';
const esc=(v:string)=>v.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
/** Fixed visual zones; supplied screen content retains its existing controls/policies. */
export function codeAdminPage({title,description,view,content}:{title:string;description:string;view:string;content:string}):string{
 const media=new BaseMediaLook();
 return `<div class="code-admin-page" data-cy="code-admin-page" data-view="${esc(view)}"><header class="code-admin-page-header"><p class="code-admin-breadcrumb">PrimeCare <span aria-hidden="true">/</span> ${esc(title)}</p><div class="code-admin-title-row"><span class="media-heading-icon">${media.icon(view==='account'?'people':view==='training'?'calendar':'home')}</span><div><h1 data-cy="code-admin-page-title">${esc(title)}</h1><p>${esc(description)}</p></div></div></header><div class="code-admin-page-body" data-cy="code-admin-page-body">${content}</div></div>`;
}
/** Group only already-visible links; never synthesizes a permission or destination. */
export function codeAdminNavigation(markup:string,locale:string):string{
 const labels=locale==='fr'?['Organisation','Activités','Outils','Mon compte']:locale==='es'?['Organización','Operaciones','Herramientas','Mi cuenta']:['Organization','Business','Tools','My account'];
 const groups:string[][]=[[],[],[],[]];const template=document.createElement('template');template.innerHTML=markup;
 for(const node of Array.from(template.content.children)){
  const id=(node as HTMLElement).dataset.section;
  const group=id==='account'?3:node.hasAttribute('data-cy')&&['look-nav','platform-nav-vapi','platform-nav-calls'].includes(node.getAttribute('data-cy')!)||['training','text'].includes(id??'')?2:['operations','bundle','reports','audit','territories'].includes(id??'')||node.getAttribute('data-cy')==='platform-growth-link'?1:0;
  groups[group].push(node.outerHTML);
 }
 return groups.map((items,i)=>items.length?`<section class="code-admin-nav-group"><h2>${esc(labels[i])}</h2>${items.join('')}</section>`:'').join('');
}
