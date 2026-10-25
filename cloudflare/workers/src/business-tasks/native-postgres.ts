/** Shared pinned native PostgreSQL options for request-owned Worker pools. */
export function nativePostgresOptions(value:string){
 const url=new URL(value);if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.port&&url.port!=='5432'||url.pathname!=='/postgres'||!url.username||!url.password)throw Error('Pinned native database required');
 return {host:url.hostname,port:Number(url.port||5432),database:'postgres',user:decodeURIComponent(url.username),password:decodeURIComponent(url.password),max:4,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:5000,query_timeout:10000,idleTimeoutMillis:1000};
}
