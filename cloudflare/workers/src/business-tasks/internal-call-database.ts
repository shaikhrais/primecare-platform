/** A trusted Worker binding, never a URL supplied by an HTTP caller. Deployment
 * independently verifies the same pinned origin and disabled query caching. */
export type InternalCallDatabaseBinding={connectionString:string;host:string;port:number;database:string;user:string;password:string};
export function internalCallDatabaseOptions(binding:InternalCallDatabaseBinding){
 if(!binding||typeof binding.connectionString!=='string')throw Error('Fresh call database required');
 const url=new URL(binding.connectionString);
 if(!['postgres:','postgresql:'].includes(url.protocol)||(url.search!==''&&url.search!=='?sslmode=disable')||url.hash||!/^([a-f0-9]{32}\.)?hyperdrive\.local$/.test(url.hostname)||url.hostname!==binding.host||Number(url.port||5432)!==binding.port||decodeURIComponent(url.pathname.slice(1))!==binding.database||binding.database!=='postgres'||!binding.user||!binding.password||decodeURIComponent(url.username)!==binding.user||decodeURIComponent(url.password)!==binding.password)throw Error('Fresh call database required');
 // workerd generates ?sslmode=disable for this in-process tunnel only.
 // The binding terminates locally within the Workers runtime. Hyperdrive's
 // origin connection uses verified TLS; no public plaintext DB URL is accepted.
 return {connectionString:binding.connectionString,max:4,connectionTimeoutMillis:5000,query_timeout:10000,idleTimeoutMillis:1000};
}
/** Request-local aggregate durations only. No SQL, parameters or identity is
 * retained. Measuring ports avoids changing pg's own internal callback methods. */
export function measuredCallDatabase(pool:any,metrics:Map<string,{count:number;milliseconds:number;max:number}>){
 const measure=async<T>(key:string,work:()=>Promise<T>)=>{const start=performance.now();try{return await work();}finally{const duration=performance.now()-start,current=metrics.get(key)??{count:0,milliseconds:0,max:0};current.count++;current.milliseconds+=duration;current.max=Math.max(current.max,duration);metrics.set(key,current);}};
 const category=(sql:string)=>/govt_api_endpoints/.test(sql)?'permissions':/govt_platform_hierarchy_policy/.test(sql)?'policy':/auth_sessions/.test(sql)?'session':/^\s*(?:BEGIN|COMMIT|ROLLBACK|SET)\b/i.test(sql)?'transaction':'state';
 return {query:(sql:string,values?:any[])=>measure<{rows:Record<string,any>[]}>(category(sql),()=>pool.query(sql,values)),connect:()=>measure('connect',async()=>{const client=await pool.connect();return {query:(sql:string,values?:any[])=>measure<{rows:Record<string,any>[]}>(category(sql),()=>client.query(sql,values)),release:()=>client.release()};})};
}
