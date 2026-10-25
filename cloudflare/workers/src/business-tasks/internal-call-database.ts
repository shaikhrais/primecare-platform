/** A trusted Worker binding, never a URL supplied by an HTTP caller. Deployment
 * independently verifies the same pinned origin and disabled query caching. */
export type InternalCallDatabaseBinding={connectionString:string;host:string;port:number;database:string;user:string;password:string};
export function internalCallDatabaseOptions(binding:InternalCallDatabaseBinding){
 const fail=(reason:string):never=>{throw Object.assign(Error('Fresh call database required'),{communicationHealth:'call_database_'+reason});};
 if(!binding||typeof binding.host!=='string')return fail('missing');
 if(!/^([a-f0-9]{32}\.)?hyperdrive\.local$/.test(binding.host))return fail('host');
 if(binding.port!==5432)return fail('port');
 // These are local tunnel identifiers, not the pinned origin's credentials or
 // database name. Only the deployment API describes the actual origin.
 for(const field of ['database','user','password'] as const)if(typeof binding[field]!=='string'||binding[field].length>2048||binding[field].includes('\0'))return fail(field);
 if(!binding.database||!binding.user)return fail('identity');
 // Pass structured fields: workerd's generated URL can contain reserved
 // credential characters. TLS is disabled only for this in-process tunnel;
 // the independently verified Hyperdrive origin always uses verified TLS.
 return {host:binding.host,port:binding.port,database:binding.database,user:binding.user,password:binding.password,ssl:false as const,max:4,connectionTimeoutMillis:5000,query_timeout:10000,idleTimeoutMillis:1000};
}
/** Request-local aggregate durations only. No SQL, parameters or identity is
 * retained. Measuring ports avoids changing pg's own internal callback methods. */
export function measuredCallDatabase(pool:any,metrics:Map<string,{count:number;milliseconds:number;max:number}>){
 const measure=async<T>(key:string,work:()=>Promise<T>)=>{const start=performance.now();try{return await work();}finally{const duration=performance.now()-start,current=metrics.get(key)??{count:0,milliseconds:0,max:0};current.count++;current.milliseconds+=duration;current.max=Math.max(current.max,duration);metrics.set(key,current);}};
 const category=(sql:string)=>/primecare_call_context_v1/.test(sql)?'context':/govt_api_endpoints/.test(sql)?'permissions':/govt_platform_hierarchy_policy/.test(sql)?'policy':/auth_sessions/.test(sql)?'session':/^\s*(?:BEGIN|COMMIT|ROLLBACK|SET)\b/i.test(sql)?'transaction':'state';
 return {query:(sql:string,values?:any[])=>measure<{rows:Record<string,any>[]}>(category(sql),()=>pool.query(sql,values)),connect:()=>measure('connect',async()=>{const client=await pool.connect();return {query:(sql:string,values?:any[])=>measure<{rows:Record<string,any>[]}>(category(sql),()=>client.query(sql,values)),release:()=>client.release()};})};
}
