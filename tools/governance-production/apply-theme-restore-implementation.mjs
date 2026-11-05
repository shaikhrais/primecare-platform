import pg from 'pg';
import {readFile} from 'node:fs/promises';
import {recordThemeRestoreImplementation} from './record-theme-restore-implementation.mjs';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
let db;
try{
 if(process.env.RECORD_THEME_RESTORE_IMPLEMENTATION!=='1')throw Error('Scoped opt-in required');
 const raw=process.env.PRODUCTION_DATABASE_URL,url=new URL(raw);
 if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres')throw Error('Pinned production connection required');
 const connect=async()=>{const client=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await client.connect();return client;};
 db=await connect();await recordThemeRestoreImplementation(db,pin);const result=await recordThemeRestoreImplementation(db,pin,{apply:true});
 await db.end();db=await connect();const readback=await recordThemeRestoreImplementation(db,pin,{readback:true});
 console.log(JSON.stringify({result,readback}));
}catch{console.error('Theme restore implementation recording or readback failed.');process.exitCode=1;}
finally{if(db)await db.end();}
