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
