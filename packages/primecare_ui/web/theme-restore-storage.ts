/** Restore copies have unique keys, so restoration never replaces the legacy library. */
const legacyPrefix='primecare-themes:v1:';
export function restoreCopyPrefix(legacyKey:string):string {
 if(!legacyKey.startsWith(legacyPrefix)||legacyKey.length===legacyPrefix.length)throw Error('Invalid theme scope');
 return 'primecare-theme-restored:v1:'+legacyKey.slice(legacyPrefix.length)+':';
}
export function restoreCopyKeys(storage:Storage,legacyKey:string):string[] {
 if(!legacyKey.startsWith(legacyPrefix)||legacyKey.length===legacyPrefix.length)return [];
 const prefix=restoreCopyPrefix(legacyKey),keys:string[]=[];
 for(let i=0;i<storage.length;i++){const key=storage.key(i);if(key?.startsWith(prefix))keys.push(key);}
 return keys.sort();
}
export function themeLibraryAbsent(storage:Storage,key:string):boolean {
 return storage.getItem(key)===null&&restoreCopyKeys(storage,key).length===0;
}
export function storeRestoreCopy(storage:Storage,key:string,value:string,id:string):string {
 if(!/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(id))throw Error('Invalid restore identity');
 const copyKey=restoreCopyPrefix(key)+id;
 if(!themeLibraryAbsent(storage,key)||storage.getItem(copyKey)!==null)throw Error('Local theme resolution required');
 storage.setItem(copyKey,value);
 return copyKey;
}

/** Run synchronous theme writes while holding an IndexedDB transaction across tabs. */
async function withDatabaseLock(key:string,work:()=>void):Promise<void> {
 const factory=globalThis.indexedDB;
 if(!factory)throw Error('theme_lock_unavailable');
 const db=await new Promise<IDBDatabase>((resolve,reject)=>{
  let settled=false;const request=factory.open('primecare-theme-write-lock',1);
  request.onupgradeneeded=()=>{if(!request.result.objectStoreNames.contains('locks'))request.result.createObjectStore('locks');};
  request.onerror=()=>{settled=true;reject(request.error??Error('theme_lock_unavailable'));};
  request.onblocked=()=>{settled=true;reject(Error('theme_lock_unavailable'));};
  request.onsuccess=()=>{if(settled){request.result.close();return;}settled=true;resolve(request.result);};
 });
 try {
  await new Promise<void>((resolve,reject)=>{
   let failure:unknown,completed=false;
   const transaction=db.transaction('locks','readwrite');
   transaction.oncomplete=()=>resolve();
   transaction.onabort=()=>{if(completed)resolve();else reject(failure??transaction.error??Error('theme_lock_unavailable'));};
   transaction.onerror=()=>{};
   const request=transaction.objectStore('locks').get(key);
   request.onsuccess=()=>{try{work();completed=true;}catch(error){failure=error;transaction.abort();}};
   request.onerror=()=>{failure=request.error??Error('theme_lock_unavailable');};
  });
 }finally{db.close();}
}
/** Coordinate new writers in every tab; retain Web Locks for already-open compatible tabs. */
export async function withThemeLibraryLock(key:string,work:()=>void):Promise<void> {
 const locks=globalThis.navigator?.locks;
 if(locks){
  await locks.request('primecare-theme-library:'+key,{mode:'exclusive'},async()=>{
   if(globalThis.indexedDB)await withDatabaseLock(key,work);else work();
  });
 }else await withDatabaseLock(key,work);
}
