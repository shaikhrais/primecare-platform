import {PrimeClientInvoices,ClientInvoices} from '../../../packages/primecare_ui/web/client-invoices';
import metadata from '../../../packages/primecare_ui/catalogs/client-invoices.registration.json';
/** Only the already server-filtered client-profile page may own this optional read view. */
export function mountClientInvoices(root:HTMLElement,options:{gateway:string;token:string;page:{code:string;route:string};identity:{userId:string;role:string};locale:'en'|'fr'|'es';isCurrent:()=>boolean;fetcher?:typeof fetch}):()=>void{
 const {page,identity}=options;
 if(page.code!==metadata.host.screenCode||page.route!==metadata.host.route||identity.role!==metadata.host.role||!options.isCurrent())return ()=>{};
 const main=root.querySelector('main');if(!main)return ()=>{};
 const slot=root.ownerDocument.createElement('section');slot.className='section';slot.dataset.cy='client-invoice-host';main.prepend(slot);
 let dead=false,view:PrimeClientInvoices|undefined,client:ClientInvoices|undefined;
 const current=()=>{try{return !dead&&root.contains(slot)&&options.isCurrent()&&sessionStorage.getItem('primecare_session')===options.token;}catch{return false;}};
 const dispose=()=>{if(dead)return;dead=true;view?.dispose();client?.dispose();slot.remove();};
 try{client=new ClientInvoices(options.gateway,options.token,identity,current,options.fetcher);view=new PrimeClientInvoices(slot,client,options.locale,current);void client.load();return dispose;}catch(error){dispose();throw error;}
}
