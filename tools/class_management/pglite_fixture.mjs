import {createRequire} from 'node:module';
import readline from 'node:readline';
const require=createRequire(import.meta.url);
const {PGlite}=require(process.env.CLASS_REGISTRY_PGLITE);
const db=new PGlite();await db.waitReady;
console.log(JSON.stringify({ready:true}));
const lines=readline.createInterface({input:process.stdin,crlfDelay:Infinity});
for await (const line of lines){
 try{const request=JSON.parse(line);if(request.close){await db.close();break;}
  let response;if(request.params?.length)response=await db.query(request.sql,request.params);else{const results=await db.exec(request.sql);response=results.at(-1)||{rows:[],fields:[]};}
  console.log(JSON.stringify({rows:response.rows.map(row=>(response.fields||[]).map(field=>row[field.name]))}));
 }catch(error){console.log(JSON.stringify({error:error.code||'fixture_sql_error'}));}
}
