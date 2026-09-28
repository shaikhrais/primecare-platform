import {Client} from 'pg';
import {pathToFileURL} from 'node:url';

/** Remove expired counters only. Each statement commits independently, with a
 * bounded batch and SKIP LOCKED so active login transactions are not blocked.
 * No account, session, password, or audit records are modified. */
export async function cleanupRateLimits(db,{apply=false,batchSize=1000,maxBatches=10}={}) {
  if(typeof apply!=='boolean' || !Number.isInteger(batchSize) || batchSize<1 || batchSize>1000 ||
     !Number.isInteger(maxBatches) || maxBatches<1 || maxBatches>10) {
    throw new Error('Invalid cleanup options');
  }
  if(!apply) {
    const result=await db.query(`SELECT COUNT(*)::int AS expired FROM (
      SELECT 1 FROM auth_rate_limits WHERE reset_at<=NOW() LIMIT $1
    ) expired`,[batchSize*maxBatches]);
    return {mode:'preview',expiredUpToLimit:Number(result.rows[0].expired),limit:batchSize*maxBatches};
  }
  let deleted=0;
  for(let batch=0;batch<maxBatches;batch++) {
    const result=await db.query(`WITH expired AS (
      SELECT subject_hash FROM auth_rate_limits WHERE reset_at<=NOW()
      ORDER BY reset_at,subject_hash LIMIT $1 FOR UPDATE SKIP LOCKED
    ) DELETE FROM auth_rate_limits r USING expired e
      WHERE r.subject_hash=e.subject_hash AND r.reset_at<=NOW()`,[batchSize]);
    deleted+=result.rowCount;
    if(result.rowCount<batchSize) return {mode:'apply',deleted,batchLimitReached:false};
  }
  return {mode:'apply',deleted,batchLimitReached:true};
}

async function main() {
  const args=process.argv.slice(2);
  if(args.length>1 || args.some(arg=>arg!=='--apply')) throw new Error('Invalid arguments');
  if(!process.env.PRODUCTION_DATABASE_URL) throw new Error('Missing database configuration');
  const db=new Client({connectionString:process.env.PRODUCTION_DATABASE_URL,
    connectionTimeoutMillis:10000,query_timeout:15000});
  try {
    await db.connect();
    console.log(JSON.stringify(await cleanupRateLimits(db,{apply:args.includes('--apply')})));
  } finally { await db.end(); }
}
if(process.argv[1] && import.meta.url===pathToFileURL(process.argv[1]).href) {
  main().catch(()=>{console.error('Auth counter cleanup failed; database details are not logged.');process.exitCode=1;});
}
