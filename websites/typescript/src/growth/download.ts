/** Keep export effects behind the same draw lease as the originating form. */
export type GrowthCleanup=(cleanup:()=>void)=>()=>void;
export function downloadGrowthPdf(blob:Blob,name:string,active:()=>boolean,retire?:GrowthCleanup){
 if(!active())return;const url=URL.createObjectURL(blob);
 let revoked=false,timer:ReturnType<typeof setTimeout>|undefined,unsubscribe=()=>{};
 const revoke=()=>{if(revoked)return;revoked=true;if(timer!==undefined)clearTimeout(timer);URL.revokeObjectURL(url);unsubscribe();};
 unsubscribe=retire?.(revoke)??unsubscribe;
 try{if(!active())return;const link=document.createElement('a');link.href=url;link.download=name;if(active())link.click();}
 finally{if(!active())revoke();else if(!revoked)timer=setTimeout(revoke,1000);}
}
