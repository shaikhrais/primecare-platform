import {navigationIcon} from './shell-icons';
import {BaseMediaLook} from './media-look';
const esc=(v:string)=>v.replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
/** Fixed visual zones; supplied screen content retains its existing controls/policies. */
export function codeAdminPage({title,description,view,content}:{title:string;description:string;view:string;content:string}):string{
 const media=new BaseMediaLook();
 return `<div class="code-admin-page" data-cy="code-admin-page" data-view="${esc(view)}"><header class="code-admin-page-header"><p class="code-admin-breadcrumb">PrimeCare <span aria-hidden="true">/</span> ${esc(title)}</p><div class="code-admin-title-row"><span class="media-heading-icon">${navigationIcon(view)}</span><div><h1 tabindex="-1" data-cy="code-admin-page-title">${esc(title)}</h1><p>${esc(description)}</p></div></div></header><div class="code-admin-page-body" data-cy="code-admin-page-body">${content}</div></div>`;
}
/** Group only already-visible links; never synthesizes a permission or destination. */
export function codeAdminNavigation(markup:string,locale:string):string{
 const names:Record<string,string[]>={en:['WORKSPACE','ACCESS & DATA','OPERATIONS','VOICE & TOOLS','SYSTEM'],fr:['ESPACE DE TRAVAIL','ACCÈS ET DONNÉES','OPÉRATIONS','VOIX ET OUTILS','SYSTÈME'],es:['ESPACIO DE TRABAJO','ACCESO Y DATOS','OPERACIONES','VOZ Y HERRAMIENTAS','SISTEMA']};
 const labels:Record<string,Record<string,string>>={en:{tenants:'Overview','tenant-selection':'Organizations',launch:'Setup & launch',onboarding:'Partner activation',accounts:'Accounts & roles',masters:'Reference records',documents:'Documents & renewals',support:'Support desk',bundle:'Attention & workflows',appearance:'Appearance & language',account:'Account & security'},fr:{tenants:'Vue d’ensemble','tenant-selection':'Organisations',launch:'Configuration et lancement',onboarding:'Activation des partenaires',accounts:'Comptes et rôles',masters:'Référentiels',documents:'Documents et renouvellements',support:'Assistance',bundle:'À vérifier et processus',appearance:'Apparence et langue',account:'Compte et sécurité'},es:{tenants:'Vista general','tenant-selection':'Organizaciones',launch:'Configuración y lanzamiento',onboarding:'Activación de socios',accounts:'Cuentas y roles',masters:'Datos de referencia',documents:'Documentos y renovaciones',support:'Soporte',bundle:'Atención y procesos',appearance:'Apariencia e idioma',account:'Cuenta y seguridad'}};
 const groups:string[][]=[[],[],[],[],[]],template=document.createElement('template');template.innerHTML=markup;
 for(const node of Array.from(template.content.children)){
  const id=(node as HTMLElement).dataset.section,cy=node.getAttribute('data-cy'),key=id??(cy==='look-nav'?'look':'growth');
  if(labels[locale]?.[key])node.textContent=labels[locale][key];
  if(node.tagName==='A'){node.querySelector('.media-icon')?.remove();node.insertAdjacentHTML('afterbegin',navigationIcon(key));}
  const group=['calls','vapi'].includes(key)?3:['training','text','appearance','account','look'].includes(key)?4:['accounts','masters','territories'].includes(key)?1:['operations','bundle','documents','support','reports','audit','growth'].includes(key)?2:0;
  groups[group].push(node.outerHTML);
 }
 return groups.map((items,i)=>items.length?`<section class="code-admin-nav-group"><h2>${esc((names[locale]??names.en)[i])}</h2>${items.join('')}</section>`:'').join('');
}

export function codeAdminDescription(view:string,locale:string):string{
 const copy=locale==='fr'?['Sélectionnez une organisation, gérez les accès et ouvrez vos espaces de travail.','Vos paramètres personnels et votre sécurité.','Découvrez les organisations, les personnes et les tâches, étape par étape.','Consultez les informations et les tâches disponibles pour votre rôle.']:locale==='es'?['Seleccione una organización, gestione el acceso y abra sus áreas de trabajo.','Su configuración personal y seguridad.','Conozca las organizaciones, las personas y las tareas paso a paso.','Revise la información y las tareas disponibles para su rol.']:['Select an organization, manage access, and open your work areas.','Your personal settings and security.','Learn about organizations, people, and daily tasks, one step at a time.','Review the information and tasks available to your role.'];
 return copy[view==='tenants'?0:view==='account'?1:view==='training'?2:3];
}
