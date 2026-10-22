import pg from 'pg';
import {readFileSync,mkdirSync,writeFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {mfaLifecycleTables,mfaSchemaProfile} from './mfa-schema-profile.mjs';
if (!process.env.MFA_TEST_DATABASE_URL || !/^[a-f0-9]{40}$/.test(process.env.GITHUB_SHA ?? '')) throw Error('Native disposable producer required');
const sql=readFileSync('packages/database/migrations/20261026_auth_mfa_lifecycle.sql','utf8');
const db=new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL});await db.connect();
const schema='mfa_schema_'+crypto.randomUUID().replaceAll('-','');
try{
  await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);await db.query(sql);
  const profiles={};for(const table of mfaLifecycleTables)profiles[table]=await mfaSchemaProfile(db,schema,table);
  mkdirSync('test-results/mfa-lifecycle-schema',{recursive:true});
  writeFileSync('test-results/mfa-lifecycle-schema/manifest.json',JSON.stringify({version:1,source:process.env.GITHUB_SHA,
    migrationSha256:createHash('sha256').update(sql).digest('hex'),nativePostgres:true,profiles},null,2));
  console.log('MFA_SCHEMA_BASELINE '+JSON.stringify({tables:mfaLifecycleTables.length,nativePostgres:true,accountChanges:0}));
}finally{await db.query('DROP SCHEMA IF EXISTS '+schema+' CASCADE');await db.end();}
