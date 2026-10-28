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
  if(node.tagName==='A'&&!node.querySelector('.media-icon'))node.insertAdjacentHTML('afterbegin',new BaseMediaLook().icon(id==='vapi'||id==='calls'?'phone':'link'));

  const group=id==='account'?3:node.hasAttribute('data-cy')&&['look-nav','platform-nav-vapi','platform-nav-calls'].includes(node.getAttribute('data-cy')!)||['training','text'].includes(id??'')?2:['operations','bundle','reports','audit','territories'].includes(id??'')||node.getAttribute('data-cy')==='platform-growth-link'?1:0;
  groups[group].push(node.outerHTML);
 }
 return groups.map((items,i)=>items.length?`<section class="code-admin-nav-group"><h2>${esc(labels[i])}</h2>${items.join('')}</section>`:'').join('');
}

export function codeAdminDescription(view:string,locale:string):string{
 const copy=locale==='fr'?['Sélectionnez une organisation, gérez les accès et ouvrez vos espaces de travail.','Vos paramètres personnels et votre sécurité.','Découvrez les organisations, les personnes et les tâches, étape par étape.','Consultez les informations et les tâches disponibles pour votre rôle.']:locale==='es'?['Seleccione una organización, gestione el acceso y abra sus áreas de trabajo.','Su configuración personal y seguridad.','Conozca las organizaciones, las personas y las tareas paso a paso.','Revise la información y las tareas disponibles para su rol.']:['Select an organization, manage access, and open your work areas.','Your personal settings and security.','Learn about organizations, people, and daily tasks, one step at a time.','Review the information and tasks available to your role.'];
 return copy[view==='tenants'?0:view==='account'?1:view==='training'?2:3];
}
