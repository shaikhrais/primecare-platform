import {Client} from 'pg';
import assert from 'node:assert/strict';
import {randomUUID} from 'node:crypto';
import {readFile} from 'node:fs/promises';
import {cleanupRateLimits} from './cleanup-auth-rate-limits.mjs';

const connectionString=process.env.AUTH_TEST_DATABASE_URL;
const url=new URL(connectionString);
if(!['localhost','127.0.0.1'].includes(url.hostname) || url.pathname!=='/auth_test') {
  throw new Error('Cleanup tests require disposable loopback database auth_test');
}
const db=new Client({connectionString,query_timeout:5000});
const lock=new Client({connectionString,query_timeout:5000});
const keys=Array.from({length:4},()=>randomUUID());
try {
  await db.connect();await lock.connect();
  await db.query(await readFile('packages/database/migrations/20260928_auth_rate_limits.sql','utf8'));
  // A private temporary test table shadows the shared table on both connections.
  // Use a unique schema so concurrent suites cannot delete one another's fixtures.
  const schema='cleanup_'+randomUUID().replaceAll('-','');
  await db.query(`CREATE SCHEMA ${schema}`);
  try {
    await db.query(`CREATE TABLE ${schema}.auth_rate_limits (LIKE public.auth_rate_limits INCLUDING ALL)`);
    await db.query(`SET search_path TO ${schema}`);await lock.query(`SET search_path TO ${schema}`);
    for(let i=0;i<keys.length;i++) await db.query(
      "INSERT INTO auth_rate_limits VALUES($1,1,NOW()+($2*INTERVAL '1 hour'))",[keys[i],i===3?1:-1]);
    assert.equal((await cleanupRateLimits(db)).expiredUpToLimit,3);
    assert.equal((await db.query('SELECT * FROM auth_rate_limits')).rowCount,4);
    await lock.query('BEGIN');
    await lock.query('SELECT * FROM auth_rate_limits WHERE subject_hash=$1 FOR UPDATE',[keys[0]]);
    assert.equal((await cleanupRateLimits(db,{apply:true,batchSize:2,maxBatches:1})).deleted,2);
    assert.equal((await db.query('SELECT * FROM auth_rate_limits WHERE subject_hash=$1',[keys[0]])).rowCount,1);
    await lock.query("UPDATE auth_rate_limits SET reset_at=NOW()+INTERVAL '1 hour' WHERE subject_hash=$1",[keys[0]]);
    await lock.query('COMMIT');
    assert.equal((await cleanupRateLimits(db,{apply:true})).deleted,0);
    assert.equal((await db.query('SELECT * FROM auth_rate_limits')).rowCount,2);
    await db.query("UPDATE auth_rate_limits SET reset_at=NOW()-INTERVAL '1 second' WHERE subject_hash=$1",[keys[0]]);
    assert.equal((await cleanupRateLimits(db,{apply:true})).deleted,1);
    assert.equal((await db.query('SELECT * FROM auth_rate_limits')).rows[0].subject_hash,keys[3]);
    console.log('Cleanup PostgreSQL: preview, bounds, locked rows, refreshed counters and active counters passed');
  } finally {
    await lock.query('ROLLBACK');
    await db.query('SET search_path TO public');
    await db.query(`DROP SCHEMA ${schema} CASCADE`);
  }
} finally {await lock.end();await db.end();}
