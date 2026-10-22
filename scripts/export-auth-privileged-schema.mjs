import pg from 'pg';
import {readFileSync,mkdirSync,writeFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
import {privilegedTables,privilegedSchemaProfile} from './privileged-schema-profile.mjs';
if (!process.env.MFA_TEST_DATABASE_URL || !/^[a-f0-9]{40}$/.test(process.env.GITHUB_SHA ?? '')) throw Error('Native disposable producer required');
const sql=readFileSync('packages/database/migrations/20261027_auth_privileged_access.sql','utf8');
const db=new pg.Client({connectionString:process.env.MFA_TEST_DATABASE_URL});await db.connect();
const schema='mfa_schema_'+crypto.randomUUID().replaceAll('-','');
try{
  await db.query('CREATE SCHEMA '+schema);await db.query('SET search_path TO '+schema);await db.query(sql);
  const profiles={};for(const table of privilegedTables)profiles[table]=await privilegedSchemaProfile(db,schema,table);
  mkdirSync('test-results/auth-privileged-schema',{recursive:true});
  writeFileSync('test-results/auth-privileged-schema/manifest.json',JSON.stringify({version:1,source:process.env.GITHUB_SHA,
    migrationSha256:createHash('sha256').update(sql).digest('hex'),nativePostgres:true,profiles},null,2));
  console.log('PRIVILEGED_SCHEMA_BASELINE '+JSON.stringify({tables:privilegedTables.length,nativePostgres:true,accountChanges:0}));
}finally{await db.query('DROP SCHEMA IF EXISTS '+schema+' CASCADE');await db.end();}
