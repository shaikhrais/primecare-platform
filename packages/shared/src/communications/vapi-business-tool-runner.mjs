import {VapiGrowthToolClient} from './vapi-growth-tools.mjs';
import {VapiClientToolClient} from './vapi-client-tools.mjs';
/** Compose result-returning server handlers around existing native APIs. This
 * is not a browser side-effect tool and never creates an authentication context. */
export function createVapiBusinessToolRunner(options){
 const clients=[new VapiGrowthToolClient(options),new VapiClientToolClient(options)],definitions=clients.flatMap(c=>c.functionDefinitions());
 const names=new Set(definitions.map(d=>d.function.name));if(names.size!==definitions.length)throw Error('Ambiguous business tool');
 return Object.freeze({functionDefinitions:()=>structuredClone(definitions),async executeFunction(name,args,operationId){const client=clients.find(c=>c.functionDefinitions().some(d=>d.function.name===name));if(!client)throw Error('Unknown business tool');return client.executeFunction(name,args,operationId);}});
}
