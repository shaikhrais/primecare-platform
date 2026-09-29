import {Client} from 'pg';
import {readFileSync} from 'node:fs';
import assert from 'node:assert/strict';
import {provisionRoles,validateRoles} from './seed-production-role-users.mjs';
const url=new URL(process.env.AUTH_TEST_DATABASE_URL);
if(!['localhost','127.0.0.1'].includes(url.hostname))throw new Error('Disposable local PostgreSQL only');
const db=new Client({connectionString:url.toString()});
await db.connect();
try {
 const roles=validateRoles(JSON.parse(readFileSync('docs/audits/role-dashboards/inventory.json','utf8')).roles);
 await provisionRoles(db,roles,'fixture-original-hash');
 assert.equal((await db.query('SELECT count(*)::int AS n FROM users')).rows[0].n,roles.length);
 await provisionRoles(db,roles,'must-not-overwrite-hash');
 assert.equal((await db.query("SELECT count(*)::int AS n FROM users WHERE password_hash='fixture-original-hash'")).rows[0].n,roles.length);
 const conflicting=[{code:'rmt',email:'rollback-check@example.test'}, {...roles[0],code:'different_role'}];
 await assert.rejects(provisionRoles(db,conflicting,'unused-hash'),/conflicts/);
 assert.equal((await db.query("SELECT count(*)::int AS n FROM users WHERE email='rollback-check@example.test'")).rows[0].n,0);
 assert.equal((await db.query('SELECT roles FROM users WHERE email=$1',[roles[0].email])).rows[0].roles,roles[0].code);
 console.log('PASS: 64-role provisioning, idempotency, password preservation and atomic conflict rollback.');
} finally {await db.end();}
