import {PrimeClientInvoices,ClientInvoices} from '../../../packages/primecare_ui/web/client-invoices';
import metadata from '../../../packages/primecare_ui/catalogs/client-invoices.registration.json';
/** Only the already server-filtered client-profile page may own this optional read view. */
export function mountClientInvoices(root:HTMLElement,options:{gateway:string;token:string;page:{code:string;route:string};identity:{userId:string;role:string};locale:'en'|'fr'|'es';isCurrent:()=>boolean;fetcher?:typeof fetch}):()=>void{
 const {gateway,token,locale,isCurrent,fetcher}=options,page={...options.page},identity={...options.identity};
 const ownerCurrent=()=>{try{return isCurrent.call(options)===true;}catch{return false;}};
 if(page.code!==metadata.host.screenCode||page.route!==metadata.host.route||identity.role!==metadata.host.role||!ownerCurrent())return ()=>{};
 const main=root.querySelector('main');if(!main)return ()=>{};
 const slot=root.ownerDocument.createElement('section');slot.className='section';slot.dataset.cy='client-invoice-host';main.prepend(slot);
 let dead=false,view:PrimeClientInvoices|undefined,client:ClientInvoices|undefined;
 const current=()=>{if(dead||!root.contains(slot))return false;try{const active=ownerCurrent();return !dead&&root.contains(slot)&&active&&sessionStorage.getItem('primecare_session')===token;}catch{return false;}};
 const dispose=()=>{if(dead)return;dead=true;view?.dispose();client?.dispose();slot.remove();};
 try{client=new ClientInvoices(gateway,token,identity,current,fetcher);view=new PrimeClientInvoices(slot,client,locale,current);void client.load();return dispose;}catch(error){dispose();throw error;}
}
