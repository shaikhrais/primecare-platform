import catalog from '../../../../packages/shared/src/communications/registered-contracts.json';
import validators from '../../../../packages/shared/src/communications/registered-schema-validators.mjs';

// Identity ties dispatch to the exact bundled registered schemas. Unknown or
// copied/modified schemas fail closed; request data never selects a compiler.
const registered=new Map<unknown,(value:unknown)=>boolean>();
for(const api of catalog.apis)for(const kind of ['request','response'] as const){
 const validator=validators['api'+api.id+'_'+kind];
 if(typeof validator!=='function')throw Error('Registered communication validator missing');
 registered.set(api[kind==='request'?'requestSchema':'responseSchema'],validator);
}
export function validateRegisteredCommunicationSchema(schema:unknown,value:unknown):boolean{
 const validator=registered.get(schema);
 return validator===undefined?false:validator(value)===true;
}
