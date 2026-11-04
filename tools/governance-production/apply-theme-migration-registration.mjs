import pg from 'pg';
import {readFile} from 'node:fs/promises';
import {registerThemeMigrationControls} from './theme-migration-registration.mjs';
const pin=JSON.parse(await readFile(new URL('./production-pin.json',import.meta.url),'utf8'));
const expected={screenId:2534,roleId:72,apiId:777,controls:['theme-migration-review','theme-migration-save','theme-migration-retry'],tables:['screen_components','screen_required_elements','language_resources','language_resource_values'],runtimeActivation:false,roleGrants:false};
let db;
try {
 if(JSON.stringify(pin.themeMigrationWriter)!==JSON.stringify(expected) || process.env.REGISTER_THEME_MIGRATION!=='1') throw Error('Scoped writer required');
 const raw=process.env.PRODUCTION_DATABASE_URL,url=new URL(raw);
 if(!['postgres:','postgresql:'].includes(url.protocol)||url.hostname!=='pooled.db.prisma.io'||url.pathname!=='/postgres') throw Error('Pinned production connection required');
 const connect=async()=>{const client=new pg.Client({connectionString:raw,ssl:{rejectUnauthorized:true},connectionTimeoutMillis:10000});await client.connect();return client;};
 db=await connect();
 await registerThemeMigrationControls(db,pin.schema,pin.manifestSha256);
 const result=await registerThemeMigrationControls(db,pin.schema,pin.manifestSha256,{apply:true});
 await db.end();db=await connect();
 const readback=await registerThemeMigrationControls(db,pin.schema,pin.manifestSha256,{requireExisting:true});
 console.log(JSON.stringify({result,readback}));
} catch {console.error('Theme migration registration or readback failed.');process.exitCode=1;}
finally {if(db)await db.end();}
